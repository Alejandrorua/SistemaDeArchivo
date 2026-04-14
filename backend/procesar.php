<?php
require_once 'funciones.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['btn_registrar'])) {
    $nro = trim($_POST['nro_carpeta']);
    $imp = trim($_POST['imputado']);
    $del = $_POST['delito'];
    $agr = $_POST['agraviado'];
    $ubi = $_POST['ubicacion'];
    $dep = $_POST['id_dep'];

    if (existeCarpeta($nro)) {
        header("Location: index.php?status=duplicado");
    } else {
        if (registrarCarpeta($nro, $imp, $del, $agr, $ubi, $dep)) {
            header("Location: index.php?status=ok");
        } else {
            header("Location: index.php?status=error");
        }
    }
    exit();
}
?>