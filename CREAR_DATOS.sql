-- ============================================
-- CineGest 2.0 - Creación de tablas
-- ============================================

CREATE TABLE CINES (
    id_cine NUMBER        PRIMARY KEY,
    nombre  VARCHAR2(100) NOT NULL,
    ciudad  VARCHAR2(100) NOT NULL
);

CREATE TABLE PELICULAS (
    id_pelicula NUMBER        PRIMARY KEY,
    titulo      VARCHAR2(200) NOT NULL,
    director    VARCHAR2(100) NOT NULL,
    genero      VARCHAR2(50)  NOT NULL
);

CREATE TABLE PROYECCIONES (
    id_proyeccion NUMBER      PRIMARY KEY,
    id_cine       NUMBER      NOT NULL,
    id_pelicula   NUMBER      NOT NULL,
    fecha         DATE        NOT NULL,
    hora          VARCHAR2(5) NOT NULL,
    recaudacion   NUMBER(10,2),
    CONSTRAINT fk_proyeccion_cine
        FOREIGN KEY (id_cine) REFERENCES CINES(id_cine),
    CONSTRAINT fk_proyeccion_pelicula
        FOREIGN KEY (id_pelicula) REFERENCES PELICULAS(id_pelicula)
);
