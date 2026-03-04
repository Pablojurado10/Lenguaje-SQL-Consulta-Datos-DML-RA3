# Lenguaje SQL: Consulta de Datos (DML)

**RA3:** Consulta la información almacenada en una base de datos empleando asistentes, herramientas gráficas y el lenguaje de manipulación de datos.

**Nombre:** Pablo Jurado Bioque  
**Fecha:** ___________

---

## Escenario Técnico: CineGest 2.0

Esquema relacional para gestionar la información de una cadena de cines:

- **CINES** (id_cine, nombre, ciudad)
- **PELICULAS** (id_pelicula, titulo, director, genero)
- **PROYECCIONES** (id_proyeccion, id_cine, id_pelicula, fecha, hora, recaudacion)
  - *Nota: id_cine e id_pelicula son claves ajenas*

---

## EJERCICIO 1: Consultas Básicas y Composiciones 

### 1.1 Películas de Ciencia Ficción ordenadas alfabéticamente

```sql
SELECT titulo, genero
FROM PELICULAS
WHERE genero = 'Ciencia Ficción'
ORDER BY titulo ASC;
```

---

### 1.2 Nombre del cine y título de película por proyección (JOIN)

```sql
SELECT C.nombre, P.titulo
FROM PROYECCIONES PR
JOIN CINES     C  ON PR.id_cine     = C.id_cine
JOIN PELICULAS P  ON PR.id_pelicula = P.id_pelicula;
```

---

### 1.3 Cines sin proyecciones (LEFT JOIN)

```sql
SELECT C.nombre, PR.id_pelicula
FROM CINES C
LEFT JOIN PROYECCIONES PR ON C.id_cine = PR.id_cine;
```

> El `LEFT JOIN` incluye todos los cines aunque no tengan proyecciones. **Cine Retiro** aparece con `null` porque todavía no ha proyectado ninguna película.

---

## EJERCICIO 2: Consultas de Resumen y Agrupación 

### 2.1  Recaudación total por cine

```sql
SELECT C.nombre, SUM(PR.recaudacion) AS recaudacion_total
FROM PROYECCIONES PR
JOIN CINES C ON PR.id_cine = C.id_cine
GROUP BY C.nombre;
```

---

### 2.2 Cines con recaudación superior a 5.000 € (HAVING)

```sql
SELECT C.nombre, SUM(PR.recaudacion) AS recaudacion_total
FROM PROYECCIONES PR
JOIN CINES C ON PR.id_cine = C.id_cine
GROUP BY C.nombre
HAVING SUM(PR.recaudacion) > 5000;
```

**¿Por qué HAVING y no WHERE?**

> `WHERE` filtra filas **antes** de agrupar, mientras que `HAVING` filtra los grupos resultantes **después** de aplicar `GROUP BY`. Como la condición afecta al resultado de una función de agregación (`SUM`), solo puede usarse `HAVING`.

---

## EJERCICIO 3: Subconsultas y Herramientas *(20% de la nota)*

### 3.1 Películas con recaudación superior a la media

```sql
SELECT DISTINCT P.titulo
FROM PELICULAS P
JOIN PROYECCIONES PR ON P.id_pelicula = PR.id_pelicula
WHERE PR.recaudacion > (
    SELECT AVG(recaudacion) FROM PROYECCIONES
);
```

---

### 3.2 MySQL Workbench vs Consola CLI

> El comando DML es `SELECT` en ambos casos. El resultado obtenido es idéntico; la única diferencia es la presentación: **Workbench** lo muestra en una tabla visual interactiva, mientras que la **consola** lo devuelve en texto plano.

---

## EJERCICIO 4: Optimización de Consultas *(20% de la nota)*

### 4.1 Índice para búsquedas por fecha

```sql
CREATE INDEX idx_proyecciones_fecha ON PROYECCIONES (fecha);
```

> Un índice ordena los datos por `fecha` en una estructura **B-Tree**. En vez de recorrer toda la tabla (*full table scan*), el motor va directo a los registros que necesita, reduciendo drásticamente el tiempo de respuesta.

---

### 4.2 Comparativa de eficiencia

#### Versión 1 — Ineficiente 

```sql
SELECT *
FROM PELICULAS, PROYECCIONES
WHERE PELICULAS.id_pelicula = PROYECCIONES.id_pelicula
AND YEAR(fecha) = 2023;
```

#### Versión 2 — Optimizada 

```sql
SELECT DISTINCT P.titulo
FROM PELICULAS P
JOIN PROYECCIONES PR ON P.id_pelicula = PR.id_pelicula
WHERE PR.fecha >= DATE '2023-01-01'
  AND PR.fecha <  DATE '2024-01-01';
```

> La versión 1 usa `SELECT *` (pide todo sin necesidad) y `YEAR(fecha)` rompe el índice, por lo que el motor lee la tabla entera. La versión 2 pide solo el título y filtra con fechas exactas, aprovechando el índice y resultando mucho más rápida.
