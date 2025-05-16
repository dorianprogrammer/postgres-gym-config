
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

CREATE OR REPLACE FUNCTION get_clients_with_persona(gym_id INT)
RETURNS TABLE (
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
)
AS $$
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
        JOIN catalogo_pago cp ON c.id_estado_pago = cp.id
    WHERE c.id_gimnasio = get_clients_with_persona.gym_id;
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
) RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_persona INT;
BEGIN
    -- Insert into persona and get the generated ID
    INSERT INTO persona (
        id_tipo_correo,
        fecha_nacimiento,
        correo,
        numero_telefono,
        primer_nombre,
        primer_apellido,
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

    -- Insert into cliente
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
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al registrar persona y cliente: %', SQLERRM;
END;
$$;



CREATE OR REPLACE FUNCTION get_clients_with_pending_payment(gym_id INT)
RETURNS TABLE (
  id_persona INT,
  id_gimnasio INT,
  id_estado_pago INT,
  id_cliente INT,
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
    c.id,
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
  JOIN catalogo_pago cp ON c.id_estado_pago = cp.id
  WHERE c.id_gimnasio = gym_id
    AND c.id_estado_pago = 2;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE actualizar_estado_pago(
    p_id_persona INT,
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
