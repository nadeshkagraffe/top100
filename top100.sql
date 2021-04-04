--1. Crear base de datos llamada películas
CREATE DATABASE películas;

--2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,determinando la relación entre ambas tablas.
 CREATE TABLE películas(id SERIAL, pelicula VARCHAR(200), año_estreno SMALLINT, director VARCHAR(50), PRIMARY KEY(id)); 

 CREATE TABLE reparto(películas_id SMALLINT, nombre_de_reparto VARCHAR(50),FOREIGN KEY(películas_id) REFERIGN KEY(películas_id) REFERENCES películas(id));

 --3. Cargar ambos archivos a su tabla correspondiente 
\COPY películas FROM './peliculas.csv' csv header;
 
\COPY reparto FROM './reparto.csv' csv;

--4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,año de estreno, director y todo el reparto
SELECT pelicula, año_estreno, director, nombre_de_reparto FROM películas INNER JOIN reparto ON películas_id=películas.id WHERE pelicula='Titanic';

--5. Listar los titulos de las películas donde actúe Harrison Ford.
SELECT pelicula, nombre_de_reparto FROM películas INNER JOIN reparto ON películas_id=películas.id WHERE nombre_de_reparto='Harrison Ford';

--6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.
SELECT director, COUNT(*) AS cuenta_director FROM películas GROUP BY director ORDER BY cuenta_director DESC LIMIT 10;

--7. Indicar cuantos actores distintos hay
SELECT COUNT(DISTINCT nombre_de_reparto) FROM reparto;

--8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente.
SELECT pelicula FROM películas WHERE año_estreno >=1990 AND año_estreno <=1999 ORDER BY pelicula ASC;

--9. Listar el reparto de las películas lanzadas el año 2001
SELECT nombre_de_reparto FROM películas INNER JOIN reparto ON películas_id=películas.id WHERE año_estreno=2001;

--10. Listar los actores de la película más nueva
SELECT nombre_de_reparto FROM películas INNER JOIN reparto ON películas_id=películas.id WHERE año_estreno= (SELECT MAX (año_estreno) FROM películas);