<?php
require_once 'funciones.php'; 

// Lógica para el Buscador
$resultadoBusqueda = null;
if (isset($_GET['q'])) {
    $resultadoBusqueda = buscarUbicacion($_GET['q']);
}

// Lógica para las Alertas
$alertas = obtenerAlertasVencidas();
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Sistema de Archivo Fiscal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>

<nav class="navbar navbar-dark bg-dark mb-4 shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.php"><i class="bi bi-balance-scale me-2"></i>GESTIÓN FISCAL</a>
    </div>
</nav>

<div class="container">
    <div class="row g-4">
        
        <div class="col-lg-5">
            <div class="card p-4 shadow-sm">
                <h4 class="mb-3">Registro de Carpeta</h4>
                <form action="guardar.php" method="POST">
                    <input type="text" name="nro_carpeta" class="form-control mb-2" placeholder="Número de Carpeta" required>
                    <input type="text" name="imputado" class="form-control mb-2" placeholder="Imputado">
                    <input type="text" name="delito" class="form-control mb-2" placeholder="Delito">
                    <input type="text" name="agraviado" class="form-control mb-2" placeholder="Agraviado">
                    <input type="text" name="ubicacion" class="form-control mb-3" placeholder="Ubicación Física" required>
                    <button type="submit" class="btn btn-primary w-100">GUARDAR</button>
                </form>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card p-4 mb-4 border-start border-primary border-5 shadow-sm">
                <h5>Buscar Ubicación</h5>
                <form action="index.php" method="GET" class="d-flex mb-3">
                    <input type="text" name="q" class="form-control me-2" placeholder="Ingrese número..." value="<?= isset($_GET['q']) ? htmlspecialchars($_GET['q']) : '' ?>">
                    <button class="btn btn-primary">BUSCAR</button>
                </form>

                <?php if(isset($_GET['q'])): ?>
                    <?php if($resultadoBusqueda): ?>
                        <div class="alert alert-success">
                            <strong>UBICACIÓN:</strong> <?= $resultadoBusqueda['ubicacion_fisica'] ?> | <strong>ESTADO:</strong> <?= $resultadoBusqueda['estado'] ?>
                        </div>
                    <?php else: ?>
                        <div class="alert alert-danger">CARPETA NO ENCONTRADA</div>
                    <?php endif; ?>
                <?php endif; ?>
            </div>

            <div class="card p-4 border-start border-danger border-5 shadow-sm">
                <h5 class="text-danger">Vencimientos detectados</h5>
                <table class="table table-sm mt-2">
                    <thead>
                        <tr><th>Guía</th><th>Carpeta</th><th>Retraso</th><th>Acción</th></tr>
                    </thead>
                    <tbody>
                        <?php foreach($alertas as $a): ?>
                        <tr class="table-danger">
                            <td><?= $a['nro_guia_prestamo'] ?></td>
                            <td><?= $a['numero_carpeta'] ?></td>
                            <td><span class="badge bg-danger"><?= $a['dias_vencidos'] ?> días</span></td>
                            <td><button class="btn btn-sm btn-outline-danger"><i class="bi bi-file-pdf"></i></button></td>
                        </tr>
                        <?php endforeach; ?>
                        <?php if(empty($alertas)): ?> <tr><td colspan="4" class="text-center text-muted">Sin alertas</td></tr> <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>