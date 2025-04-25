-- Ensure UTF-8 encoding by creating this file in a text editor with UTF-8 setting
CREATE TABLE Persona (
    id INTEGER PRIMARY KEY IDENTITY(1,1),
    Fecha_nacimiento DATE,
    Correo VARCHAR(50),
    numero_Telefono VARCHAR(15),
    primer_Nombre VARCHAR(50),
    primer_Apellido VARCHAR(50),
    segundo_apellido VARCHAR(50),
    Fecha_inicio DATE
);

CREATE TABLE Gimnasio (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(15)
);

CREATE TABLE Retroalimentacion (
    id SERIAL PRIMARY KEY,
    id_gimnasio INT REFERENCES Gimnasio(id),
    comentarios VARCHAR(50)
);

CREATE TABLE Horario (
    id SERIAL PRIMARY KEY,
    hora_entrada TIME,
    hora_salida TIME
);

CREATE TABLE Administrador (
    id SERIAL PRIMARY KEY,
    id_persona VARCHAR(15) REFERENCES Persona(id),
    id_gimnasio INT REFERENCES Gimnasio(id)
);

CREATE TABLE Cliente (
    id SERIAL PRIMARY KEY,
    id_persona VARCHAR(15) REFERENCES Persona(id),
    id_gimnasio INT REFERENCES Gimnasio(id),
    estado_pago INT
);

CREATE TABLE Catalogo_Pago (
    id SERIAL PRIMARY KEY,
    Pagado VARCHAR(50),
    Pendiente VARCHAR(50),
    Inactivo VARCHAR(50)
);

CREATE TABLE Entrenador (
    id SERIAL PRIMARY KEY,
    id_persona VARCHAR(15) REFERENCES Persona(id),
    id_gimnasio INT REFERENCES Gimnasio(id),
    id_horario INT REFERENCES Horario(id)
);

CREATE TABLE Rutinas (
    id SERIAL PRIMARY KEY,
    id_entrenador INT REFERENCES Entrenador(id),
    Nombre_Ejercicio VARCHAR(50),
    Img_ejercicio VARCHAR(255),
    gif_ejercicio VARCHAR(255),
    grupo_muscular VARCHAR(50),
    descripcion VARCHAR(50)
);

CREATE TABLE Detalle_Rutinas (
    id SERIAL PRIMARY KEY,
    id_entrenador INT REFERENCES Entrenador(id),
    id_cliente INT REFERENCES Cliente(id),
    id_rutina INT REFERENCES Rutinas(id)
);

INSERT INTO Persona (id, Fecha_nacimiento, Correo, numero_Telefono, primer_Nombre, primer_Apellido, segundo_apellido, Fecha_inicio) VALUES
    ('P001', '1990-05-15', 'juan.perez@gmail.com', '555-123-4567', 'Juan', 'Perez', 'Lopez', '2023-01-10'),
    ('P002', '1985-08-22', 'maria.gomez@hotmail.com', '555-987-6543', 'Maria', 'Gomez', 'Rodriguez', '2023-02-15'),
    ('P003', '1995-03-30', 'carlos.sanchez@yahoo.com', '555-456-7890', 'Carlos', 'Sanchez', 'Martinez', '2023-03-01');

INSERT INTO Gimnasio (nombre) VALUES
    ('FitZone'),
    ('PowerGym');

INSERT INTO Retroalimentacion (id_gimnasio, comentarios) VALUES
    (1, 'Excelente equipo'),
    (1, 'Horarios flexibles'),
    (2, 'Buena atención');

INSERT INTO Horario (hora_entrada, hora_salida) VALUES
    ('08:00:00', '12:00:00'),
    ('14:00:00', '18:00:00'),
    ('18:00:00', '22:00:00');

INSERT INTO Administrador (id_persona, id_gimnasio) VALUES
    ('P001', 1),
    ('P002', 2);

INSERT INTO Cliente (id_persona, id_gimnasio, estado_pago) VALUES
    ('P003', 1, 1),
    ('P002', 1, 2),
    ('P001', 2, 3);

INSERT INTO Catalogo_Pago (Pagado, Pendiente, Inactivo) VALUES
    ('Pagado', NULL, NULL),
    (NULL, 'Pendiente', NULL),
    (NULL, NULL, 'Inactivo');

INSERT INTO Entrenador (id_persona, id_gimnasio, id_horario) VALUES
    ('P003', 1, 1),
    ('P001', 2, 2);

INSERT INTO Rutinas (id_entrenador, Nombre_Ejercicio, Img_ejercicio, gif_ejercicio, grupo_muscular, descripcion) VALUES
    (1, 'Sentadilla', '/img/squat.jpg', '/gif/squat.gif', 'Piernas', 'Ejercicio básico piernas'),
    (1, 'Press banca', '/img/bench.jpg', '/gif/bench.gif', 'Pecho', 'Fuerza superior'),
    (2, 'Dominadas', '/img/pullup.jpg', '/gif/pullup.gif', 'Espalda', 'Fuerza espalda');

INSERT INTO Detalle_Rutinas (id_entrenador, id_cliente, id_rutina) VALUES
    (1, 1, 1),
    (1, 2, 2),
    (2, 3, 3);

CREATE OR REPLACE FUNCTION get_personas()
RETURNS TABLE (
    id VARCHAR(15),
    fecha_nacimiento DATE,
    correo VARCHAR(50),
    numero_telefono VARCHAR(15),
    primer_nombre VARCHAR(50),
    primer_apellido VARCHAR(50),
    segundo_apellido VARCHAR(50),
    fecha_inicio DATE
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM persona;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_person_client(
    p_id_persona VARCHAR(15),
    p_fecha_nacimiento DATE,
    p_correo VARCHAR(50),
    p_numero_telefono VARCHAR(15),
    p_primer_nombre VARCHAR(50),
    p_primer_apellido VARCHAR(50),
    p_segundo_apellido VARCHAR(50),
    p_id_gimnasio INTEGER,
    p_id_estado_pago INTEGER,
    p_fecha_inicio DATE,
    p_fecha_proxima_pago DATE
)
RETURNS VARCHAR(15) AS $$
BEGIN
    -- 1. Insertar en la tabla persona
    INSERT INTO persona (
        id,
        fecha_nacimiento,
        correo,
        numero_telefono,
        primer_nombre,
        primer_apellido,
        segundo_apellido
    )
    VALUES (
        p_id_persona,
        p_fecha_nacimiento,
        p_correo,
        p_numero_telefono,
        p_primer_nombre,
        p_primer_apellido,
        p_segundo_apellido
    );

    INSERT INTO cliente (
        id_persona,
        id_gimnasio,
        id_estado_pago,
        fecha_inicio,
        fecha_proxima_pago
    )
    VALUES (
        p_id_persona,
        p_id_gimnasio,
        p_id_estado_pago,
        p_fecha_inicio,
        p_fecha_proxima_pago
    );

    RETURN p_id_persona;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al registrar persona y cliente: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;