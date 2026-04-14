<?php
require_once 'config.php';

// Validar si existe carpeta para evitar duplicados
function existeCarpeta($numero) {
    global $pdo;
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM carpeta_fiscal WHERE numero_carpeta = ?");
    $stmt->execute([$numero]);
    return $stmt->fetchColumn() > 0;
}

// Registrar nueva carpeta
function registrarCarpeta($nro, $imp, $del, $agr, $ubi, $dep) {
    global $pdo;
    $sql = "INSERT INTO carpeta_fiscal (numero_carpeta, imputado, delito, agraviado, ubicacion_fisica, id_dependencia, estado) 
            VALUES (?, ?, ?, ?, ?, ?, 'Activo')";
    $stmt = $pdo->prepare($sql);
    return $stmt->execute([$nro, $imp, $del, $agr, $ubi, $dep]);
}

// Buscar ubicación de carpeta
function buscarUbicacion($numero) {
    global $pdo;
    $stmt = $pdo->prepare("SELECT * FROM carpeta_fiscal WHERE numero_carpeta = ?");
    $stmt->execute([$numero]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

// Obtener alertas de vencimiento
function obtenerAlertasVencidas() {
    global $pdo;
    $sql = "SELECT p.*, dp.numero_carpeta FROM prestamo p 
            JOIN detalle_prestamo dp ON p.id_prestamo = dp.id_prestamo 
            WHERE p.estado_prestamo = 'Pendiente' AND p.fecha_vencimiento < NOW()";
    return $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
}
?>