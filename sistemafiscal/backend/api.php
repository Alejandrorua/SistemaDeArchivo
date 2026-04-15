<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once 'config.php';

session_start();

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? '';

// Middleware simple para verificar sesión (excepto login)
if ($action !== 'login' && !isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'No autorizado']);
    exit;
}

switch ($action) {
    case 'login':
        $data = json_decode(file_get_contents('php://input'), true);
        $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE username = ?");
        $stmt->execute([$data['username']]);
        $user = $stmt->fetch();

        if ($user && password_verify($data['password'], $user['password'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['nombre'] = $user['nombre'];
            echo json_encode(['success' => true, 'user' => [
                'username' => $user['username'],
                'nombre' => $user['nombre']
            ]]);
        } else {
            http_response_code(401);
            echo json_encode(['error' => 'Credenciales inválidas']);
        }
        break;

    case 'logout':
        session_destroy();
        echo json_encode(['success' => true]);
        break;

    case 'carga_masiva':
        // Simulación de carga desde CSV (Excel se suele manejar con librerías como PhpSpreadsheet)
        if (!isset($_FILES['file'])) {
            http_response_code(400);
            echo json_encode(['error' => 'No se subió ningún archivo']);
            break;
        }

        $file = $_FILES['file']['tmp_name'];
        $handle = fopen($file, "r");
        $count = 0;
        $errors = [];

        // Saltar cabecera
        fgetcsv($handle);

        $pdo->beginTransaction();
        try {
            while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
                // data: [numero, imputado, delito, agraviado, estado, ubicacion]
                $stmt = $pdo->prepare("INSERT INTO carpeta_fiscal (numero_carpeta, imputado, delito, agraviado, estado, ubicacion_fisica) VALUES (?, ?, ?, ?, ?, ?)");
                $stmt->execute([$data[0], $data[1], $data[2], $data[3], $data[4], $data[5]]);
                $count++;
            }
            $pdo->commit();
            registrarAuditoria($pdo, $_SESSION['username'], "Carga masiva: $count carpetas", 'carpeta_fiscal', 0);
            echo json_encode(['success' => true, 'count' => $count]);
        } catch (Exception $e) {
            $pdo->rollBack();
            http_response_code(400);
            echo json_encode(['error' => 'Error en la fila ' . ($count + 1) . ': ' . $e->getMessage()]);
        }
        fclose($handle);
        break;

    case 'get_carpetas':
        $stmt = $pdo->query("SELECT * FROM carpeta_fiscal ORDER BY fecha_registro DESC");
        echo json_encode($stmt->fetchAll());
        break;

    case 'buscar_carpeta':
        $numero = $_GET['numero'] ?? '';
        $stmt = $pdo->prepare("SELECT * FROM carpeta_fiscal WHERE numero_carpeta = ?");
        $stmt->execute([$numero]);
        $result = $stmt->fetch();
        if ($result) {
            echo json_encode($result);
        } else {
            http_response_code(404);
            echo json_encode(['message' => 'No ubicado']);
        }
        break;

    case 'registrar_carpeta':
        $data = json_decode(file_get_contents('php://input'), true);
        try {
            $stmt = $pdo->prepare("INSERT INTO carpeta_fiscal (numero_carpeta, imputado, delito, agraviado, estado, ubicacion_fisica) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->execute([
                $data['numero_carpeta'],
                $data['imputado'],
                $data['delito'],
                $data['agraviado'],
                $data['estado'],
                $data['ubicacion_fisica']
            ]);
            $id = $pdo->lastInsertId();
            registrarAuditoria($pdo, 'admin', 'Registro de carpeta', 'carpeta_fiscal', $id);
            echo json_encode(['success' => true, 'id' => $id]);
        } catch (Exception $e) {
            http_response_code(400);
            echo json_encode(['error' => $e->getMessage()]);
        }
        break;

    case 'get_dependencias':
        $stmt = $pdo->query("SELECT * FROM dependencia");
        echo json_encode($stmt->fetchAll());
        break;

    case 'registrar_prestamo':
        $data = json_decode(file_get_contents('php://input'), true);
        // $data: { guia_numero, dependencia_id, fecha_prestamo, plazo_dias, carpetas: [id1, id2] }
        try {
            $pdo->beginTransaction();
            
            $fecha_vencimiento = date('Y-m-d', strtotime($data['fecha_prestamo'] . ' + ' . $data['plazo_dias'] . ' days'));
            
            $stmt = $pdo->prepare("INSERT INTO prestamo (guia_numero, dependencia_id, fecha_prestamo, plazo_dias, fecha_vencimiento) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([
                $data['guia_numero'],
                $data['dependencia_id'],
                $data['fecha_prestamo'],
                $data['plazo_dias'],
                $fecha_vencimiento
            ]);
            $prestamo_id = $pdo->lastInsertId();

            foreach ($data['carpetas'] as $carpeta_id) {
                $stmt = $pdo->prepare("INSERT INTO detalle_prestamo (prestamo_id, carpeta_id) VALUES (?, ?)");
                $stmt->execute([$prestamo_id, $carpeta_id]);

                // Actualizar estado de la carpeta
                $stmt = $pdo->prepare("UPDATE carpeta_fiscal SET estado = 'En Préstamo' WHERE id = ?");
                $stmt->execute([$carpeta_id]);
            }

            registrarAuditoria($pdo, 'admin', 'Registro de préstamo', 'prestamo', $prestamo_id);
            $pdo->commit();
            echo json_encode(['success' => true]);
        } catch (Exception $e) {
            $pdo->rollBack();
            http_response_code(400);
            echo json_encode(['error' => $e->getMessage()]);
        }
        break;

    case 'get_alertas':
        // Carpetas vencidas (fecha_vencimiento < hoy y estado Pendiente)
        $stmt = $pdo->query("
            SELECT p.*, d.nombre as dependencia, GROUP_CONCAT(c.numero_carpeta) as carpetas
            FROM prestamo p
            JOIN dependencia d ON p.dependencia_id = d.id
            JOIN detalle_prestamo dp ON p.id = dp.prestamo_id
            JOIN carpeta_fiscal c ON dp.carpeta_id = c.id
            WHERE p.fecha_vencimiento < CURDATE() AND p.estado = 'Pendiente'
            GROUP BY p.id
        ");
        echo json_encode($stmt->fetchAll());
        break;

    case 'get_reporte_prestamos':
        $stmt = $pdo->query("
            SELECT d.nombre as dependencia, COUNT(p.id) as total_prestamos
            FROM dependencia d
            LEFT JOIN prestamo p ON d.id = p.dependencia_id
            GROUP BY d.id
        ");
        echo json_encode($stmt->fetchAll());
        break;

    default:
        echo json_encode(['message' => 'Acción no válida']);
        break;
}
?>
