<?php
require_once 'config.php';

/**
 * Validar si existe carpeta para evitar duplicados
 */
function existeCarpeta($numero) {
    global $pdo;
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM carpeta_fiscal WHERE numero_carpeta = ?");
    $stmt->execute([$numero]);
    return $stmt->fetchColumn() > 0;
}

/**
 * Registrar nueva carpeta
 * Nota: Se eliminó id_dependencia de aquí porque la carpeta nace en el archivo central, 
 * la dependencia solo aparece cuando se presta.
 */
function registrarCarpeta($nro, $imp, $del, $agr, $ubi) {
    global $pdo;
    $sql = "INSERT INTO carpeta_fiscal (numero_carpeta, imputado, delito, agraviado, ubicacion_fisica, estado) 
            VALUES (?, ?, ?, ?, ?, 'Activo')";
    $stmt = $pdo->prepare($sql);
    return $stmt->execute([$nro, $imp, $del, $agr, $ubi]);
}

/**
 * Buscar ubicación de carpeta (Usado por el buscador del Index)
 */
function buscarUbicacion($numero) {
    global $pdo;
    $stmt = $pdo->prepare("SELECT * FROM carpeta_fiscal WHERE numero_carpeta = ?");
    $stmt->execute([$numero]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

/**
 * Obtener alertas de vencimiento
 * Filtra por carpetas que están en detalle_prestamo y NO han sido devueltas
 */
function obtenerAlertasVencidas() {
    global $pdo;
    $sql = "SELECT 
                p.nro_guia_prestamo, 
                dp.numero_carpeta, 
                DATE_ADD(p.fecha_prestamo, INTERVAL p.plazo_dias DAY) AS fecha_limite,
                DATEDIFF(NOW(), DATE_ADD(p.fecha_prestamo, INTERVAL p.plazo_dias DAY)) AS dias_vencidos
            FROM prestamo p 
            JOIN detalle_prestamo dp ON p.nro_guia_prestamo = dp.nro_guia_prestamo 
            WHERE dp.devuelto = FALSE 
            AND DATE_ADD(p.fecha_prestamo, INTERVAL p.plazo_dias DAY) < NOW()";
    return $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
}
?>