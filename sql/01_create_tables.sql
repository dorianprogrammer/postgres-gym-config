CREATE TABLE tipo_correo (
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE persona (
    id SERIAL PRIMARY KEY,
    id_tipo_correo INT REFERENCES tipo_correo(id),
    Fecha_nacimiento DATE,
    Correo VARCHAR(50),
    numero_Telefono VARCHAR(15),
    primer_Nombre VARCHAR(50),
    primer_Apellido VARCHAR(50),
    segundo_apellido VARCHAR(50)
);

CREATE TABLE gimnasio (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(15)
);

CREATE TABLE retroalimentacion (
    id SERIAL PRIMARY KEY,
    id_gimnasio INT REFERENCES gimnasio(id),
    comentarios VARCHAR(50)
);

CREATE TABLE horario (
    id SERIAL PRIMARY KEY,
    hora_entrada TIME,
    hora_salida TIME
);

CREATE TABLE administrador (
    id SERIAL PRIMARY KEY,
    id_persona INT REFERENCES persona(id),
    id_gimnasio INT REFERENCES gimnasio(id)
);

CREATE TABLE catalogo_pago (
    id SERIAL PRIMARY KEY,
    Estado INT,
    Descripcion VARCHAR(50)
);

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    id_persona INT REFERENCES persona(id),
    id_gimnasio INT REFERENCES gimnasio(id),
    id_estado_pago INT REFERENCES catalogo_pago(id),
    fecha_inicio DATE,
    fecha_proxima_pago DATE
);

CREATE TABLE entrenador (
    id SERIAL PRIMARY KEY,
    id_persona INT REFERENCES persona(id),
    id_gimnasio INT REFERENCES gimnasio(id),
    id_horario INT REFERENCES horario(id)
);

CREATE TABLE rutinas (
    id SERIAL PRIMARY KEY,
    id_entrenador INT REFERENCES entrenador(id),
    Nombre_Ejercicio VARCHAR(50),
    Img_ejercicio VARCHAR(255),
    gif_ejercicio VARCHAR(255),
    grupo_muscular VARCHAR(50),
    descripcion VARCHAR(50)
);

CREATE TABLE detalle_rutinas (
    id SERIAL PRIMARY KEY,
    id_entrenador INT REFERENCES entrenador(id),
    id_cliente INT REFERENCES cliente(id),
    id_rutina INT REFERENCES rutinas(id)
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    id_persona INT UNIQUE REFERENCES persona(id) ON DELETE CASCADE,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) CHECK (role IN ('admin', 'trainer', 'client')) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE monto_mensual_cliente (
    id SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES cliente(id) ON DELETE CASCADE,
    monto NUMERIC(10, 2) NOT NULL,
    moneda VARCHAR(10) DEFAULT 'CRC',
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    activo BOOLEAN DEFAULT true
);

CREATE TABLE metodo_pago (
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE pago_cliente (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES cliente(id) ON DELETE CASCADE,
    id_monto_mensual INT REFERENCES monto_mensual_cliente(id),
    fecha_pago TIMESTAMP NOT NULL DEFAULT NOW(),
    monto_pagado NUMERIC(10, 2) NOT NULL,
    id_metodo_pago INT NOT NULL REFERENCES metodo_pago(id),
    observaciones TEXT,
    registrado_por INT REFERENCES usuarios(id), -- JUST IN CASE
    confirmado BOOLEAN DEFAULT true,
    metadata JSONB -- JUST IN CASE: for SINPE ref, bank name, etc.
);

CREATE INDEX idx_pago_cliente_cliente ON pago_cliente(id_cliente);
CREATE INDEX idx_pago_cliente_fecha ON pago_cliente(fecha_pago);
CREATE INDEX idx_pago_cliente_metodo ON pago_cliente(id_metodo_pago);

CREATE UNIQUE INDEX unico_pago_diario
ON pago_cliente (id_cliente, date(fecha_pago));

CREATE UNIQUE INDEX unico_monto_activo_por_cliente
ON monto_mensual_cliente (id_cliente)
WHERE activo = true;

