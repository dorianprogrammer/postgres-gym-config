-- Ensure UTF-8 encoding by creating this file in a text editor with UTF-8 setting
CREATE TABLE tipo_correo (
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);
CREATE TABLE Persona (
    id SERIAL PRIMARY KEY,
    id_tipo_correo INT REFERENCES tipo_correo(id),
    Fecha_nacimiento DATE,
    Correo VARCHAR(50),
    numero_Telefono VARCHAR(15),
    primer_Nombre VARCHAR(50),
    primer_Apellido VARCHAR(50),
    segundo_apellido VARCHAR(50)
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
    id_persona INT REFERENCES Persona(id),
    id_gimnasio INT REFERENCES Gimnasio(id)
);
CREATE TABLE Catalogo_Pago (
    id SERIAL PRIMARY KEY,
    Estado INT,
    Descripcion VARCHAR(50)
);
CREATE TABLE Cliente (
    id SERIAL PRIMARY KEY,
    id_persona INT REFERENCES Persona(id),
    id_gimnasio INT REFERENCES Gimnasio(id),
    id_estado_pago INT REFERENCES Catalogo_Pago(id),
    fecha_inicio DATE,
    fecha_proxima_pago DATE
);
CREATE TABLE Entrenador (
    id SERIAL PRIMARY KEY,
    id_persona INT REFERENCES Persona(id),
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
CREATE TABLE Usuarios (
    id SERIAL PRIMARY KEY,
    id_persona INT UNIQUE REFERENCES Persona(id) ON DELETE CASCADE,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) CHECK (role IN ('admin', 'trainer', 'client')) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO tipo_correo (descripcion)
VALUES ('Primario'),
    ('Secundario');
INSERT INTO Persona (
        Fecha_nacimiento,
        Correo,
        numero_Telefono,
        primer_Nombre,
        primer_Apellido,
        segundo_apellido
    )
VALUES (
        '1990-05-15',
        'juan.perez@gmail.com',
        '83124567',
        'Juan',
        'Perez',
        'Lopez'
    ),
    (
        '1985-08-22',
        'maria.gomez@hotmail.com',
        '72019843',
        'Maria',
        'Gomez',
        'Rodriguez'
    ),
    (
        '1992-11-10',
        'luis.martin@gmail.com',
        '84562310',
        'Luis',
        'Martin',
        'Torres'
    ),
    (
        '1988-07-19',
        'ana.ramirez@gmail.com',
        '60431298',
        'Ana',
        'Ramirez',
        'Morales'
    ),
    (
        '1991-04-22',
        'sofia.fernandez@gmail.com',
        '70128890',
        'Sofia',
        'Fernandez',
        'Vega'
    ),
    (
        '1993-09-30',
        'david.ruiz@gmail.com',
        '89234433',
        'David',
        'Ruiz',
        'Castro'
    ),
    (
        '1987-06-12',
        'paula.diaz@gmail.com',
        '88817654',
        'Paula',
        'Diaz',
        'Navarro'
    ),
    (
        '1996-12-03',
        'javier.molina@gmail.com',
        '87773030',
        'Javier',
        'Molina',
        'Herrera'
    ),
    (
        '1994-01-17',
        'carla.mendez@gmail.com',
        '83456778',
        'Carla',
        'Mendez',
        'Ortega'
    ),
    (
        '1989-03-25',
        'sergio.silva@gmail.com',
        '60214488',
        'Sergio',
        'Silva',
        'Guerrero'
    ),
    (
        '1990-02-10',
        'laura.rios@gmail.com',
        '70105566',
        'Laura',
        'Rios',
        'Luna'
    ),
    (
        '1995-07-28',
        'fernando.castro@gmail.com',
        '83100099',
        'Fernando',
        'Castro',
        'Jimenez'
    ),
    (
        '1993-10-09',
        'elena.soto@gmail.com',
        '72053344',
        'Elena',
        'Soto',
        'Peña'
    ),
    (
        '1986-11-14',
        'miguel.vargas@gmail.com',
        '88892211',
        'Miguel',
        'Vargas',
        'Cruz'
    ),
    (
        '1997-05-06',
        'isabel.reyes@gmail.com',
        '86551133',
        'Isabel',
        'Reyes',
        'Flores'
    ),
    (
        '1992-08-18',
        'ricardo.hernandez@gmail.com',
        '60407788',
        'Ricardo',
        'Hernandez',
        'Romero'
    ),
    (
        '1984-09-21',
        'valeria.cabrera@gmail.com',
        '87335599',
        'Valeria',
        'Cabrera',
        'Mendoza'
    ),
    (
        '1998-01-11',
        'alejandro.ibarra@gmail.com',
        '71112233',
        'Alejandro',
        'Ibarra',
        'Salazar'
    ),
    (
        '1991-06-07',
        'monica.navarro@gmail.com',
        '83199900',
        'Monica',
        'Navarro',
        'Arias'
    );
INSERT INTO Gimnasio (nombre)
VALUES ('FitZone'),
    ('PowerGym');
INSERT INTO Retroalimentacion (id_gimnasio, comentarios)
VALUES (1, 'Excelente equipo'),
    (1, 'Horarios flexibles'),
    (2, 'Buena atención');
INSERT INTO Horario (hora_entrada, hora_salida)
VALUES ('08:00:00', '12:00:00'),
    ('14:00:00', '18:00:00'),
    ('18:00:00', '22:00:00');
INSERT INTO Administrador (id_persona, id_gimnasio)
VALUES (1, 1),
    (2, 2);
INSERT INTO Catalogo_Pago (Estado, Descripcion)
VALUES (1, 'Pagado'),
    (2, 'Pendiente'),
    (3, 'Inactivo');
INSERT INTO Cliente (
        id_persona,
        id_gimnasio,
        id_estado_pago,
        fecha_inicio,
        fecha_proxima_pago
    )
VALUES (4, 1, 1, '2023-01-10', '2025-03-30'),
    (5, 1, 1, '2023-01-10', '2025-03-30'),
    (6, 2, 1, '2023-01-10', '2025-03-30'),
    (7, 2, 2, '2023-01-10', '2025-03-30'),
    (8, 1, 2, '2023-01-10', '2025-03-30'),
    (9, 1, 3, '2023-01-10', '2025-03-30'),
    (10, 2, 3, '2023-01-10', '2025-03-30'),
    (11, 1, 1, '2023-01-10', '2025-03-30'),
    (12, 1, 2, '2023-01-10', '2025-03-30'),
    (13, 2, 3, '2023-01-10', '2025-03-30'),
    (14, 1, 2, '2023-01-10', '2025-03-30'),
    (15, 2, 2, '2023-01-10', '2025-03-30'),
    (16, 1, 3, '2023-01-10', '2025-03-30'),
    (17, 2, 1, '2023-01-10', '2025-03-30');
INSERT INTO Entrenador (id_persona, id_gimnasio, id_horario)
VALUES (18, 1, 1),
    (19, 2, 2);
INSERT INTO Rutinas (
        id_entrenador,
        Nombre_Ejercicio,
        Img_ejercicio,
        gif_ejercicio,
        grupo_muscular,
        descripcion
    )
VALUES (
        1,
        'Sentadilla',
        '/img/squat.jpg',
        '/gif/squat.gif',
        'Piernas',
        'Ejercicio básico piernas'
    ),
    (
        1,
        'Press banca',
        '/img/bench.jpg',
        '/gif/bench.gif',
        'Pecho',
        'Fuerza superior'
    ),
    (
        2,
        'Dominadas',
        '/img/pullup.jpg',
        '/gif/pullup.gif',
        'Espalda',
        'Fuerza espalda'
    );
INSERT INTO Detalle_Rutinas (id_entrenador, id_cliente, id_rutina)
VALUES (1, 1, 1),
    (1, 2, 2),
    (2, 3, 3);
INSERT INTO Usuarios (id_persona, password_hash, role)
VALUES (
        1,
        '$2b$10$bU9Z9VKMl8ObOzR.tXsB2eBTXBp3ZrcfeK7H7V0X1OAvBib6fBNW6',
        'admin'
    ),
    (
        2,
        '$2b$10$bU9Z9VKMl8ObOzR.tXsB2eBTXBp3ZrcfeK7H7V0X1OAvBib6fBNW6',
        'admin'
    );

CREATE OR REPLACE PROCEDURE update_user_info(
        p_id INT,
        p_primer_nombre VARCHAR,
        p_primer_apellido VARCHAR,
        p_segundo_apellido VARCHAR,
        p_telefono VARCHAR,
        p_correo VARCHAR,
        p_fecha_inicio DATE,
        p_fecha_proxima_pago DATE,
        p_id_estado_pago INT
    ) AS $$ BEGIN
UPDATE persona
SET primer_nombre = p_primer_nombre,
    primer_apellido = p_primer_apellido,
    segundo_apellido = p_segundo_apellido,
    numero_telefono = p_telefono,
    correo = p_correo
WHERE id = p_id;
UPDATE cliente
SET id_estado_pago = p_id_estado_pago,
    fecha_inicio = p_fecha_inicio,
    fecha_proxima_pago = p_fecha_proxima_pago
WHERE id_persona = p_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_clients_with_persona(gym_id INT) RETURNS TABLE (
        id_persona INT,
        id_gimnasio INT,
        id_estado_pago INT,
        descripcion_estado_pago VARCHAR,
        estado_pago INT,
        fecha_inicio DATE,
        fecha_proxima_pago DATE,
        primer_nombre VARCHAR,
        primer_apellido VARCHAR,
        segundo_apellido VARCHAR,
        numero_telefono VARCHAR,
        correo VARCHAR
    ) AS $$ BEGIN RETURN QUERY
SELECT c.id_persona,
    c.id_gimnasio,
    c.id_estado_pago,
    cp.descripcion,
    cp.estado,
    c.fecha_inicio,
    c.fecha_proxima_pago,
    p.primer_nombre,
    p.primer_apellido,
    p.segundo_apellido,
    p.numero_telefono,
    p.correo
FROM cliente c
    JOIN persona p ON c.id_persona = p.id
    JOIN Catalogo_Pago cp ON c.id_estado_pago = cp.id
WHERE c.id_gimnasio = gym_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_person_client(
        p_fecha_nacimiento DATE,
        p_correo VARCHAR(50),
        p_numero_telefono VARCHAR(15),
        p_primer_nombre VARCHAR(50),
        p_primer_apellido VARCHAR(50),
        p_segundo_apellido VARCHAR(50),
        c_id_gimnasio INTEGER,
        c_id_estado_pago INTEGER,
        c_fecha_inicio DATE,
        c_fecha_proxima_pago DATE,
        p_id_tipo_correo INT
    ) RETURNS INT LANGUAGE plpgsql AS $$
DECLARE v_id_persona INT;
BEGIN
INSERT INTO Persona (
        id_tipo_correo,
        Fecha_nacimiento,
        Correo,
        numero_Telefono,
        primer_Nombre,
        primer_Apellido,
        segundo_apellido
    )
VALUES (
        p_id_tipo_correo,
        p_fecha_nacimiento,
        p_correo,
        p_numero_telefono,
        p_primer_nombre,
        p_primer_apellido,
        p_segundo_apellido
    )
RETURNING id INTO v_id_persona;
INSERT INTO cliente (
        id_persona,
        id_gimnasio,
        id_estado_pago,
        fecha_inicio,
        fecha_proxima_pago
    )
VALUES (
        v_id_persona,
        c_id_gimnasio,
        c_id_estado_pago,
        c_fecha_inicio,
        c_fecha_proxima_pago
    );
RETURN v_id_persona;
EXCEPTION
WHEN OTHERS THEN RAISE EXCEPTION 'Error al registrar persona y cliente: %',
SQLERRM;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_clients_with_pending_payment(gym_id INT)
RETURNS TABLE (
  id_persona VARCHAR,
  id_gimnasio INT,
  id_estado_pago INT,
  descripcion_estado_pago VARCHAR,
  estado_pago INT,
  fecha_inicio DATE,
  fecha_proxima_pago DATE,
  primer_nombre VARCHAR,
  primer_apellido VARCHAR,
  segundo_apellido VARCHAR,
  numero_telefono VARCHAR,
  correo VARCHAR
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    c.id_persona,
    c.id_gimnasio,
    c.id_estado_pago,
    cp.descripcion,
    cp.estado,
    c.fecha_inicio,
    c.fecha_proxima_pago,
    p.primer_nombre,
    p.primer_apellido,
    p.segundo_apellido,
    p.numero_telefono,
    p.correo
  FROM cliente c
  JOIN persona p ON c.id_persona = p.id
  JOIN Catalogo_Pago cp ON c.id_estado_pago = cp.id
  WHERE c.id_gimnasio = gym_id
    AND c.id_estado_pago = 2;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE actualizar_estado_pago(
    p_id_persona VARCHAR,
    p_id_estado_pago INT,
    p_fecha_proxima_pago DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE cliente
    SET
        id_estado_pago = p_id_estado_pago,
        fecha_proxima_pago = p_fecha_proxima_pago
    WHERE id_persona = p_id_persona;
END;
$$;
