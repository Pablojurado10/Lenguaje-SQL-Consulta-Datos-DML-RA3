-- ============================================
-- CineGest 2.0 - Inserción de datos
-- ============================================

-- CINES
INSERT INTO CINES VALUES (1, 'Cine Lumière',     'Madrid');
INSERT INTO CINES VALUES (2, 'Multicines Norte', 'Barcelona');
INSERT INTO CINES VALUES (3, 'Cine Retiro',      'Madrid');

-- PELICULAS
INSERT INTO PELICULAS VALUES (1, 'Interestelar', 'Christopher Nolan',    'Ciencia Ficción');
INSERT INTO PELICULAS VALUES (2, 'El Padrino',   'Francis Ford Coppola', 'Drama');
INSERT INTO PELICULAS VALUES (3, 'Dune',         'Denis Villeneuve',     'Ciencia Ficción');
INSERT INTO PELICULAS VALUES (4, 'Matrix',       'Lana Wachowski',       'Ciencia Ficción');

-- PROYECCIONES
INSERT INTO PROYECCIONES VALUES (1, 1, 1, DATE '2023-03-10', '18:00', 1200);
INSERT INTO PROYECCIONES VALUES (2, 2, 1, DATE '2023-03-11', '20:00', 4500);
INSERT INTO PROYECCIONES VALUES (3, 2, 2, DATE '2023-05-20', '19:30', 3200);
INSERT INTO PROYECCIONES VALUES (4, 1, 3, DATE '2023-06-15', '17:00',  980);
INSERT INTO PROYECCIONES VALUES (5, 2, 3, DATE '2023-06-16', '21:00', 5800);
INSERT INTO PROYECCIONES VALUES (6, 1, 4, DATE '2023-09-01', '20:30',  650);

COMMIT;
