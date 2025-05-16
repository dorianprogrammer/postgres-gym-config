INSERT INTO tipo_correo (descripcion)
VALUES ('Primario'), ('Secundario');

INSERT INTO persona (
    Fecha_nacimiento, Correo, numero_Telefono, primer_Nombre, primer_Apellido, segundo_apellido
) VALUES
('1990-05-15', 'juan.perez@gmail.com', '83124567', 'Juan', 'Perez', 'Lopez'),
('1985-08-22', 'maria.gomez@hotmail.com', '72019843', 'Maria', 'Gomez', 'Rodriguez'),
('1992-11-10', 'luis.martin@gmail.com', '84562310', 'Luis', 'Martin', 'Torres'),
('1988-07-19', 'ana.ramirez@gmail.com', '60431298', 'Ana', 'Ramirez', 'Morales'),
('1991-04-22', 'sofia.fernandez@gmail.com', '70128890', 'Sofia', 'Fernandez', 'Vega'),
('1993-09-30', 'david.ruiz@gmail.com', '89234433', 'David', 'Ruiz', 'Castro'),
('1987-06-12', 'paula.diaz@gmail.com', '88817654', 'Paula', 'Diaz', 'Navarro'),
('1996-12-03', 'javier.molina@gmail.com', '87773030', 'Javier', 'Molina', 'Herrera'),
('1994-01-17', 'carla.mendez@gmail.com', '83456778', 'Carla', 'Mendez', 'Ortega'),
('1989-03-25', 'sergio.silva@gmail.com', '60214488', 'Sergio', 'Silva', 'Guerrero'),
('1990-02-10', 'laura.rios@gmail.com', '70105566', 'Laura', 'Rios', 'Luna'),
('1995-07-28', 'fernando.castro@gmail.com', '83100099', 'Fernando', 'Castro', 'Jimenez'),
('1993-10-09', 'elena.soto@gmail.com', '72053344', 'Elena', 'Soto', 'Peña'),
('1986-11-14', 'miguel.vargas@gmail.com', '88892211', 'Miguel', 'Vargas', 'Cruz'),
('1997-05-06', 'isabel.reyes@gmail.com', '86551133', 'Isabel', 'Reyes', 'Flores'),
('1992-08-18', 'ricardo.hernandez@gmail.com', '60407788', 'Ricardo', 'Hernandez', 'Romero'),
('1984-09-21', 'valeria.cabrera@gmail.com', '87335599', 'Valeria', 'Cabrera', 'Mendoza'),
('1998-01-11', 'alejandro.ibarra@gmail.com', '71112233', 'Alejandro', 'Ibarra', 'Salazar'),
('1991-06-07', 'monica.navarro@gmail.com', '83199900', 'Monica', 'Navarro', 'Arias');

INSERT INTO gimnasio (nombre)
VALUES ('FitZone'), ('PowerGym');

INSERT INTO retroalimentacion (id_gimnasio, comentarios)
VALUES (1, 'Excelente equipo'),
       (1, 'Horarios flexibles'),
       (2, 'Buena atención');

INSERT INTO horario (hora_entrada, hora_salida)
VALUES ('08:00:00', '12:00:00'),
       ('14:00:00', '18:00:00'),
       ('18:00:00', '22:00:00');

INSERT INTO administrador (id_persona, id_gimnasio)
VALUES (1, 1), (2, 2);

INSERT INTO catalogo_pago (Estado, Descripcion)
VALUES (1, 'Pagado'),
       (2, 'Pendiente'),
       (3, 'Inactivo');

INSERT INTO cliente (
    id_persona, id_gimnasio, id_estado_pago, fecha_inicio, fecha_proxima_pago
) VALUES
(4, 1, 1, '2023-01-10', '2025-05-14'),
(5, 1, 1, '2023-01-10', '2025-05-30'),
(6, 2, 1, '2023-01-10', '2025-05-19'),
(7, 2, 2, '2023-01-10', '2025-05-15'),
(8, 1, 2, '2023-01-10', '2025-05-30'),
(9, 1, 3, '2023-01-10', '2025-05-15'),
(10, 2, 3, '2023-01-10', '2025-05-30'),
(11, 1, 1, '2023-01-10', '2025-05-30'),
(12, 1, 2, '2023-01-10', '2025-05-17'),
(13, 2, 3, '2023-01-10', '2025-05-22'),
(14, 1, 2, '2023-01-10', '2025-05-20'),
(15, 1, 2, '2023-01-10', '2025-05-17'),
(16, 1, 3, '2023-01-10', '2025-05-27'),
(17, 2, 1, '2023-01-10', '2025-05-28');

INSERT INTO entrenador (id_persona, id_gimnasio, id_horario)
VALUES (18, 1, 1),
       (19, 2, 2);

INSERT INTO rutinas (
    id_entrenador, Nombre_Ejercicio, Img_ejercicio, gif_ejercicio, grupo_muscular, descripcion
) VALUES
(1, 'Sentadilla', '/img/squat.jpg', '/gif/squat.gif', 'Piernas', 'Ejercicio básico piernas'),
(1, 'Press banca', '/img/bench.jpg', '/gif/bench.gif', 'Pecho', 'Fuerza superior'),
(2, 'Dominadas', '/img/pullup.jpg', '/gif/pullup.gif', 'Espalda', 'Fuerza espalda');

INSERT INTO detalle_rutinas (id_entrenador, id_cliente, id_rutina)
VALUES (1, 1, 1),
       (1, 2, 2),
       (2, 3, 3);

INSERT INTO usuarios (id_persona, password_hash, role)
VALUES
(1, '$2b$10$bU9Z9VKMl8ObOzR.tXsB2eBTXBp3ZrcfeK7H7V0X1OAvBib6fBNW6', 'admin'),
(2, '$2b$10$bU9Z9VKMl8ObOzR.tXsB2eBTXBp3ZrcfeK7H7V0X1OAvBib6fBNW6', 'admin');

INSERT INTO monto_mensual_cliente (id_cliente, monto, fecha_inicio)
VALUES
(1, 18000.00, '2023-01-10'),
(2, 18000.00, '2023-01-10'),
(3, 18000.00, '2023-01-10'),
(4, 18000.00, '2023-01-10'),
(5, 18000.00, '2023-01-10'),
(6, 18000.00, '2023-01-10'),
(7, 18000.00, '2023-01-10'),
(8, 18000.00, '2023-01-10'),
(9, 18000.00, '2023-01-10'),
(10, 18000.00, '2023-01-10'),
(11, 18000.00, '2023-01-10'),
(12, 18000.00, '2023-01-10'),
(13, 18000.00, '2023-01-10');

INSERT INTO metodo_pago (descripcion)
VALUES ('Efectivo'), ('SINPE'), ('Tarjeta de Crédito/Débito');
