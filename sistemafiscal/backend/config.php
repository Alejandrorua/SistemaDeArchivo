<?php
/**
 * Configuración de conexión a la base de datos
 */

$host = 'localhost';
$db   = 'sistema_archivo';
$user = 'root';
$pass = '1234567'; // Cambiar según configuración de MySQL Workbench
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
     $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
     header('Content-Type: application/json');
     echo json_encode(['error' => 'Error de conexión: ' . $e->getMessage()]);
     exit;
}

/**
 * Función para registrar auditoría
 */
function registrarAuditoria($pdo, $usuario, $accion, $tabla, $id) {
    $stmt = $pdo->prepare("INSERT INTO auditoria (usuario, accion, tabla_afectada, registro_id) VALUES (?, ?, ?, ?)");
    $stmt->execute([$usuario, $accion, $tabla, $id]);
}
?>
