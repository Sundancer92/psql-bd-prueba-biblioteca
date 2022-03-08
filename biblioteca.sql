

-- Crecacion DB Biblioteca
CREATE DATABASE biblioteca;
\c biblioteca;

-- COMUNA
CREATE TABLE comuna(
    comuna_id INT,
    comuna VARCHAR (15),
    PRIMARY KEY (comuna_id)
);

INSERT INTO comuna (comuna_id, comuna)
VALUES (1, 'Santiago');

SELECT * FROM comuna;
-- SOCIO

CREATE TABLE socio(
    rut VARCHAR (11),
    nombre_socio VARCHAR(50),
    apellido_socio VARCHAR(50),
    telefono INT UNIQUE,
    direccion VARCHAR(30) UNIQUE,
    nombre_comuna VARCHAR(30),
    PRIMARY KEY (rut)
);

INSERT INTO socio (rut, nombre_socio, apellido_socio, telefono, direccion, nombre_comuna)
VALUES ('1111111-1', 'JUAN', 'SOTO', 911111111, 'Avenida 1', (
    SELECT comuna FROM comuna WHERE comuna_id = 1));

INSERT INTO socio (rut, nombre_socio, apellido_socio, telefono, direccion, nombre_comuna)
VALUES ('2222222-2', 'ANA', 'PÉREZ', 922222222, 'PASAJE 2', (
    SELECT comuna FROM comuna WHERE comuna_id = 1));

INSERT INTO socio (rut, nombre_socio, apellido_socio, telefono, direccion, nombre_comuna)
VALUES ('3333333-3', 'SANDRA', 'AGUILAR', 933333333, 'AVENIDA 2', (
    SELECT comuna FROM comuna WHERE comuna_id = 1));

INSERT INTO socio (rut, nombre_socio, apellido_socio, telefono, direccion, nombre_comuna)
VALUES ('4444444-4', 'ESTEBAN', 'JEREZ', 944444444, 'AVENIDA 3', (
    SELECT comuna FROM comuna WHERE comuna_id = 1));

INSERT INTO socio (rut, nombre_socio, apellido_socio, telefono, direccion, nombre_comuna)
VALUES ('5555555-5 ', 'SILVANA', 'MUÑOZ', 955555555, 'PASAJE 3', (
    SELECT comuna FROM comuna WHERE comuna_id = 1));
    
SELECT * FROM socio;

-- TIPO DE AUTOR

CREATE TABLE tipo_de_autor(
    tipo_de_autor_id INT,
    tipo VARCHAR (15),
    PRIMARY KEY (tipo_de_autor_id)
);

INSERT INTO tipo_de_autor (tipo_de_autor_id, tipo)
VALUES (1, 'PRINCIPAL');

INSERT INTO tipo_de_autor (tipo_de_autor_id, tipo)
VALUES (2, 'COAUTOR');
SELECT * FROM tipo_de_autor;

-- AUTOR

CREATE TABLE autor(
    autor_id SERIAL,
    nombre_autor VARCHAR (50),
    apellido_autor VARCHAR (50),
    fecha_de_nacimiento SMALLINT,
    fecha_de_defuncion SMALLINT,
    PRIMARY KEY (autor_id)
);

INSERT INTO autor(nombre_autor, apellido_autor, fecha_de_nacimiento)
VALUES ('ANDRÉS','ULLOA',1982);
INSERT INTO autor(nombre_autor, apellido_autor, fecha_de_nacimiento, fecha_de_defuncion)
VALUES ('SERGIO','MARDONES',1950,2012);
INSERT INTO autor(nombre_autor, apellido_autor, fecha_de_nacimiento, fecha_de_defuncion)
VALUES ('JOSE','SALGADO',1968,2020);
INSERT INTO autor(nombre_autor, apellido_autor, fecha_de_nacimiento)
VALUES ('ANA','SALGADO',1972);
INSERT INTO autor(nombre_autor, apellido_autor, fecha_de_nacimiento)
VALUES ('MARTIN','PORTA',1976);

SELECT * FROM autor;

-- LIBRO

CREATE TABLE libro(
    isbn VARCHAR(15) UNIQUE,
    nombre_libro VARCHAR (100),
    numero_de_paginas SMALLINT,
    PRIMARY KEY (isbn)
);

INSERT INTO libro(isbn, nombre_libro, numero_de_paginas)
VALUES ('111-1111111-111','CUENTOS DE TERROR',344);
INSERT INTO libro(isbn, nombre_libro, numero_de_paginas)
VALUES ('222-2222222-222','POESÍAS CONTEMPO RANEAS',167);
INSERT INTO libro(isbn, nombre_libro, numero_de_paginas)
VALUES ('333-3333333-333','HISTORIA DE ASIA',511);
INSERT INTO libro(isbn, nombre_libro, numero_de_paginas)
VALUES ('444-4444444-444','MANUAL DE MECÁNICA',298);

SELECT * FROM libro;

-- AUTORES

CREATE TABLE autores (
    autores_id SMALLINT,
    autor_id SMALLINT,
    tipo_de_autor_id SMALLINT,
    isbn VARCHAR,
    PRIMARY KEY (autores_id),
    FOREIGN KEY (autor_id) REFERENCES autor(autor_id),
    FOREIGN KEY (tipo_de_autor_id) REFERENCES tipo_de_autor(tipo_de_autor_id),
    FOREIGN KEY (isbn) REFERENCES libro(isbn)
);

INSERT INTO autores(autores_id, autor_id, tipo_de_autor_id, isbn)
VALUES (1,3,1,(SELECT isbn FROM libro WHERE isbn = '111-1111111-111'));
INSERT INTO autores(autores_id, autor_id, tipo_de_autor_id, isbn)
VALUES (2,4,2,(SELECT isbn FROM libro WHERE isbn = '111-1111111-111'));
INSERT INTO autores(autores_id, autor_id, tipo_de_autor_id, isbn)
VALUES (3,1,1,(SELECT isbn FROM libro WHERE isbn = '222-2222222-222'));
INSERT INTO autores(autores_id, autor_id, tipo_de_autor_id, isbn)
VALUES (4,2,1,(SELECT isbn FROM libro WHERE isbn = '333-3333333-333'));
INSERT INTO autores(autores_id, autor_id, tipo_de_autor_id, isbn)
VALUES (5,5,1,(SELECT isbn FROM libro WHERE isbn = '444-4444444-444'));

SELECT * FROM autores;

-- PRESTAMO LIBRO

CREATE TABLE prestamo_libro(
    prestamo_libro SERIAL,
    socio_id VARCHAR (11),
    fecha_inicio DATE,
    fecha_devolucion DATE,
    isbn VARCHAR,
    PRIMARY KEY (prestamo_libro),
    FOREIGN KEY (socio_id) REFERENCES socio(rut),
    FOREIGN KEY (isbn) REFERENCES libro(isbn)
);

INSERT INTO prestamo_libro(socio_id, fecha_inicio, fecha_devolucion, isbn)
VALUES 
    ('1111111-1', '2020-01-20','2020-01-27',
    (SELECT isbn FROM libro WHERE isbn = '111-1111111-111')),

    ('5555555-5 ', '2020-01-20','2020-01-30',
    (SELECT isbn FROM libro WHERE isbn = '222-2222222-222')),

    ('3333333-3', '2020-01-22','2020-01-30',
    (SELECT isbn FROM libro WHERE isbn = '333-3333333-333')),

    ('4444444-4', '2020-01-23','2020-01-30',
    (SELECT isbn FROM libro WHERE isbn = '444-4444444-444')),

    ('2222222-2', '2020-01-27','2020-02-04',
    (SELECT isbn FROM libro WHERE isbn = '111-1111111-111')),

    ('1111111-1', '2020-01-31','2020-02-12',
    (SELECT isbn FROM libro WHERE isbn = '444-4444444-444')),

    ('3333333-3', '2020-01-31','2020-02-12',
    (SELECT isbn FROM libro WHERE isbn = '222-2222222-222'));

SELECT * FROM prestamo_libro;
SELECT * FROM socio;
SELECT * FROM libro;

-- CONSULTAS

SELECT * FROM libro WHERE numero_de_paginas <=300;

SELECT nombre_autor, apellido_autor, fecha_de_nacimiento FROM autor WHERE fecha_de_nacimiento >= 1970;


SELECT nombre_libro, prestamo_libro.isbn, COUNT(prestamo_libro.isbn) AS cantidad_de_solicitudes FROM libro 
JOIN prestamo_libro ON prestamo_libro.isbn = libro.isbn 
GROUP BY libro.nombre_libro,prestamo_libro.isbn
HAVING COUNT(prestamo_libro.isbn) > 1
ORDER BY cantidad_de_solicitudes DESC, nombre_libro ASC;


SELECT 
    nombre_socio,
    apellido_socio,
    fecha_inicio,
    fecha_devolucion,
    CAST(EXTRACT
            (day FROM fecha_devolucion)
            -
            (EXTRACT
                (day FROM fecha_inicio)+7) as bigint)
             AS  
    Dias_de_atraso,
    CAST(EXTRACT
            (day FROM fecha_devolucion)
            -
            (EXTRACT
                (day FROM fecha_inicio)+7) as bigint)*100
            AS
    Deuda_atraso
    FROM prestamo_libro
    INNER JOIN socio
    ON socio.rut = prestamo_libro.socio_id

    WHERE CAST(EXTRACT
            (day FROM fecha_devolucion)
            -
            (EXTRACT
                (day FROM fecha_inicio)+7) as bigint) >0;

SELECT * FROM prestamo_libro;

SELECT * FROM libro;
SELECT * FROM autor;
SELECT * FROM autores;
SELECT * FROM tipo_de_autor;
SELECT * FROM socio;
SELECT * FROM comuna;