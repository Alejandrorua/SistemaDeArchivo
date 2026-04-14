<?php
// Conexión opcional: descomentar cuando tu compañero te pase el archivo
// include_once '../backend/conexion.php';
require_once '../backend/funciones.php';
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Archivo Fiscal - Ministerio Público</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --mp-blue: #2c3e50; --mp-gold: #b7950b; --danger-red: #e74c3c; }
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .navbar { background-color: var(--mp-blue) !important; border-bottom: 4px solid var(--mp-gold); }
        .card { border: none; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        .btn-fiscal { background-color: var(--mp-blue); color: white; border: none; }
        .btn-fiscal:hover { background-color: #1a252f; color: white; }
        .alert-vencido { border-left: 5px solid var(--danger-red); background: #fff3f2; }
        .section-title { border-bottom: 2px solid #dee2e6; margin-bottom: 20px; padding-bottom: 10px; color: var(--mp-blue); }
    </style>
</head>
<body>

<nav class="navbar navbar-dark mb-4 shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">
            <i class="bi bi-balance-scale me-2"></i>SISTEMA DE GESTIÓN DE CARPETAS FISCALES
        </a>
        <span class="navbar-text text-white d-none d-md-block">
            Módulo de Archivo Central
        </span>
    </div>
</nav>

<div class="container">
    <div class="row g-4">
        
        <div class="col-lg-5">
            <div class="card p-4">
                <h4 class="section-title"><i class="bi bi-file-earmark-plus me-2"></i>Registro de Carpeta</h4>
                <form action="../backend/guardar.php" method="POST">
                    <div class="mb-3">
                        <label class="form-label fw-bold small">NÚMERO DE CARPETA (ÚNICO)</label>
                        <input type="text" name="nro_carpeta" class="form-control" placeholder="Ej: 123-2026-FP" required>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold small">IMPUTADO</label>
                            <input type="text" name="imputado" class="form-control" placeholder="Nombre completo">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold small">DELITO</label>
                            <input type="text" name="delito" class="form-control" placeholder="Ej: Hurto">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small">AGRAVIADO</label>
                        <input type="text" name="agraviado" class="form-control" placeholder="Nombre del agraviado">
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small">UBICACIÓN FÍSICA</label>
                        <input type="text" name="ubicacion" class="form-control" placeholder="Estante - Fila - Caja" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small">ESTADO INICIAL</label>
                        <select name="estado" class="form-select">
                            <option value="Activo">Activo</option>
                            <option value="Archivado">Archivado</option>
                            <option value="En trámite">En trámite</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-fiscal w-100 py-2">
                        <i class="bi bi-device-hdd me-2"></i>GUARDAR REGISTRO
                    </button>
                </form>
                
                <div class="mt-4 p-3 bg-light rounded border">
                    <h6 class="fw-bold"><i class="bi bi-filetype-xlsx me-2 text-success"></i>Carga Masiva (Excel)</h6>
                    <form action="../backend/excel.php" method="POST" enctype="multipart/form-data">
                        <input type="file" name="archivo_excel" class="form-control form-control-sm mb-2" accept=".xlsx" required>
                        <button class="btn btn-outline-success btn-sm w-100">PROCESAR ARCHIVO</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card p-4 mb-4 border-start border-primary border-5">
                <h4 class="section-title"><i class="bi bi-search me-2"></i>Consulta de Ubicación</h4>
                <form action="" method="GET" class="d-flex mb-3">
                    <input type="text" name="q" class="form-control me-2" placeholder="Ingrese número de carpeta a buscar..." required>
                    <button class="btn btn-primary px-4">BUSCAR</button>
                </form>

                <?php
                if(isset($_GET['q'])) {
                    $busqueda = htmlspecialchars($_GET['q']); // Limpiamos la entrada
                    
                    if($busqueda == "CARPETA-OK") {
                        echo "
                        <div class='alert alert-success d-flex align-items-center' role='alert'>
                          <i class='bi bi-check-circle-fill me-2 fs-4'></i>
                          <div>
                            <strong>UBICACIÓN ENCONTRADA:</strong> Archivo Central - Estante 05 - Fila B
                          </div>
                        </div>";
                    } else {
                        echo "
                        <div class='alert alert-danger d-flex align-items-center fw-bold' role='alert text-uppercase'>
                          <i class='bi bi-x-octagon-fill me-2 fs-4'></i>
                          NO UBICADO
                        </div>";
                    }
                }
                ?>
            </div>

            <div class="card p-4 border-start border-danger border-5">
                <h4 class="section-title text-danger"><i class="bi bi-exclamation-triangle me-2"></i>Control de Vencimientos</h4>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Nro. Guía</th>
                                <th>Carpeta</th>
                                <th>Plazo</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="alert-vencido">
                                <td><strong>PREST-001</strong></td>
                                <td class="small">123-2026-FP</td>
                                <td><span class="text-danger fw-bold">8 días (Vencido)</span></td>
                                <td class="text-center">
                                    <button class="btn btn-danger btn-sm shadow-sm" title="Generar Nota de Devolución">
                                        <i class="bi bi-file-earmark-pdf"></i> NOTA
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>PREST-002</td>
                                <td class="small">456-2026-FP</td>
                                <td>4 días (Pendiente)</td>
                                <td class="text-center">
                                    <button class="btn btn-light btn-sm border" disabled><i class="bi bi-clock"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="mt-3 text-end">
                    <a href="#" class="btn btn-link btn-sm text-decoration-none text-muted">Ver historial completo →</a>
                </div>
            </div>
        </div>

    </div>
</div>

<footer class="container text-center mt-5 mb-4 py-3 border-top">
    <p class="text-muted small">© 2026 Ministerio Público - Sistema de Archivo Fiscal | Ingeniería Web</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>