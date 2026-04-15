-- Base de Datos para Sistema de Gestión de Carpetas Fiscales
-- Compatible con MySQL Workbench

CREATE DATABASE IF NOT EXISTS sistema_archivo;
USE sistema_archivo;

-- Tabla: dependencia
CREATE TABLE IF NOT EXISTS dependencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabla: carpeta_fiscal
CREATE TABLE IF NOT EXISTS carpeta_fiscal (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_carpeta VARCHAR(50) NOT NULL UNIQUE,
    imputado VARCHAR(255) NOT NULL,
    delito VARCHAR(255) NOT NULL,
    agraviado VARCHAR(255) NOT NULL,
    estado ENUM('Activo', 'Archivado', 'En Préstamo') DEFAULT 'Activo',
    ubicacion_fisica VARCHAR(100) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabla: prestamo
CREATE TABLE IF NOT EXISTS prestamo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    guia_numero VARCHAR(50) NOT NULL UNIQUE,
    dependencia_id INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    plazo_dias INT DEFAULT 7,
    fecha_vencimiento DATE NOT NULL,
    estado ENUM('Pendiente', 'Devuelto') DEFAULT 'Pendiente',
    FOREIGN KEY (dependencia_id) REFERENCES dependencia(id)
) ENGINE=InnoDB;

-- Tabla: detalle_prestamo
CREATE TABLE IF NOT EXISTS detalle_prestamo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    prestamo_id INT NOT NULL,
    carpeta_id INT NOT NULL,
    FOREIGN KEY (prestamo_id) REFERENCES prestamo(id) ON DELETE CASCADE,
    FOREIGN KEY (carpeta_id) REFERENCES carpeta_fiscal(id),
    UNIQUE(prestamo_id, carpeta_id)
) ENGINE=InnoDB;

-- Tabla: devolucion
CREATE TABLE IF NOT EXISTS devolucion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    prestamo_id INT NOT NULL,
    fecha_devolucion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observacion TEXT,
    FOREIGN KEY (prestamo_id) REFERENCES prestamo(id)
) ENGINE=InnoDB;

-- Tabla: auditoria (Requerimiento No Funcional)
CREATE TABLE IF NOT EXISTS auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50),
    accion VARCHAR(255),
    tabla_afectada VARCHAR(50),
    registro_id INT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Datos iniciales de prueba
-- Tabla: usuarios (Requerimiento No Funcional: Seguridad/Multiusuario)
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    rol ENUM('Administrador', 'Operador') DEFAULT 'Operador',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Datos iniciales de prueba
INSERT INTO usuarios (username, password, nombre, rol) VALUES 
('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrador Sistema', 'Administrador'); 
-- password es 'password' hasheado

INSERT INTO dependencia (nombre) VALUES ('Fiscalía Penal 1'), ('Fiscalía de Familia'), ('Anticorrupción');
INSERT INTO carpeta_fiscal (numero_carpeta, imputado, delito, agraviado, estado, ubicacion_fisica) 
VALUES ('EXP-2024-001', 'Juan Perez', 'Hurto Agravado', 'Empresa X', 'Activo', 'Estante A-1');
