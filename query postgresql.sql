--Tarea curso PostgreSQL UNAHUR
--22/10/2024 

--1. Genere los create table para registrar los datos del documento mostrado.
--2. Genere los queries que permitan insertar 5 facturas con 5 ítems cada una 
--3. Genere los queries para obtener: 
--La venta total de todas las facturas.
--La venta promedio por factura.
--El valor máximo y mínimo de los diferentes items de las diferentes facturas.

-- Introducción: 

-- visualización de base de datos en mi consola postgres:

camilo@camilo-VirtualBox:~$ psql -U usuarioadmin -W -l
Password:

  Name  	   |	Owner 	  | Encoding | Locale Provider |   Collate   |	Ctype      | ICU Locale | ICU Rules |   Access privileges   
---------------+--------------+----------+-----------------+-------------+-------------+------------+-----------+-----------------------
 cursodb1  	   | postgres 	  | UTF8 	 | libc            | es_ES.UTF-8 | es_ES.UTF-8 |        	|       	|
 databasecurso | usuarioadmin | UTF8 	 | libc        	   | es_ES.UTF-8 | es_ES.UTF-8 |        	|       	|
 db1           | usuarioadmin | UTF8 	 | libc        	   | es_ES.UTF-8 | es_ES.UTF-8 |        	|       	|
 postgres      | postgres 	  | UTF8 	 | libc        	   | es_ES.UTF-8 | es_ES.UTF-8 |        	|       	|
 template0 	   | postgres 	  | UTF8     | libc        	   | es_ES.UTF-8 | es_ES.UTF-8 |        	|       	| =c/postgres      	+
           	   |          	  |      	 |             	   |         	 |             |        	|       	| postgres=CTc/postgres
 template1 	   | postgres 	  | UTF8 	 | libc            | es_ES.UTF-8 | es_ES.UTF-8 |        	|       	| =c/postgres      	+
           	   |          	  |      	 |             	   |         	 |         	   |        	|       	| postgres=CTc/postgres
(6 rows)

(END)
 
-- Ingreso a la base de datos:

camilo@camilo-VirtualBox:~$ psql databasecurso -U usuarioadmin
Password for user usuarioadmin:
psql (16.4 (Ubuntu 16.4-0ubuntu0.24.04.2))
Type "help" for help.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creo las Tablas del documento

-- Tabla  registro: almacena los datos de cada factura, nombre de la empresa, cliente, fecha..

databasecurso=# CREATE TABLE registro ( id SERIAL PRIMARY KEY, numero_factura VARCHAR(20) NOT NULL, ruc_empresa VARCHAR(11) NOT NULL, nombre_empresa VARCHAR(100) NOT NULL, direccion_empresa VARCHAR(255) NOT NULL, fecha DATE NOT NULL, ruc_cliente VARCHAR(11) NOT NULL, nombre_cliente VARCHAR(100) NOT NULL, direccion_cliente VARCHAR(255) NOT NULL, subtotal DECIMAL(10,2) NOT NULL, total DECIMAL(10,2) NOT NULL );
CREATE TABLE


databasecurso=# \d registro;  -- Para visualizar la tabla/>

                                     	Table "public.registro"
  	Column   	   |      	Type         	| Collation | Nullable |           	Default           	 
-------------------+------------------------+-----------+----------+--------------------------------------
 id            	   | integer            	|       	| not null | nextval('registro_id_seq'::regclass)
 numero_factura	   | character varying(20)  |       	| not null |
 ruc_empresa   	   | character varying(11)  |       	| not null |
 nombre_empresa	   | character varying(100) |       	| not null |
 direccion_empresa | character varying(255) |       	| not null |
 fecha         	   | date               	|       	| not null |
 ruc_cliente   	   | character varying(11)  |       	| not null |
 nombre_cliente	   | character varying(100) |       	| not null |
 direccion_cliente | character varying(255) |       	| not null |
 subtotal      	   | numeric(10,2)      	|       	| not null |
 total         	   | numeric(10,2)      	|       	| not null |
Indexes:
	"registro_pkey" PRIMARY KEY, btree (id)



-- Tabla factura_items: almacena los datos de los productos, con los detalles y precios, enlazados con cada factura por un id. 

databasecurso=# CREATE TABLE factura_items ( id SERIAL PRIMARY KEY, id_factura INT REFERENCES registro(id) ON DELETE CASCADE, cantidad DECIMAL(10,2) NOT NULL, unidad_medida VARCHAR(10) NOT NULL, descripcion VARCHAR(255) NOT NULL, precio_unitario DECIMAL(10,2), importe DECIMAL(10,2) NOT NULL );
CREATE TABLE

databasecurso=# \d factura_items;  -- Para visualizar la tabla/>

                                    	Table "public.factura_items"
 	Column  	|      	Type      	| Collation | Nullable |              	Default             	 

-----------------+------------------------+-----------+----------+-------------------------------------------
 id              | integer           	  |       	  | not null | nextval('factura_items_id_seq'::regclass)
 id_factura  	 | integer            	  |       	  |      	 |
 cantidad    	 | numeric(10,2)      	  |       	  | not null |
 unidad_medida   | character varying(10)  |       	  | not null |
 descripcion 	 | character varying(255) |       	  | not null |
 precio_unitario | numeric(10,2)      	  |       	  |     	 |
 importe     	 | numeric(10,2)      	  |       	  | not null |
Indexes:
	"factura_items_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
	"factura_items_id_factura_fkey" FOREIGN KEY (id_factura) REFERENCES registro(id) ON DELETE CASCADE


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Aca genere las queries para cada tabla con la información del documento, 5 facturas con 5 ítems cada una.

-- Ingreso 5 queries para tablas registro 

databasecurso=# INSERT INTO registro (numero_factura, ruc_empresa, nombre_empresa, direccion_empresa, fecha, ruc_cliente, nombre_cliente, direccion_cliente, subtotal, total) VALUES                                                        	('F002-00003529', '20537098008', 'Corporacion Palomos S.A.C', 'Punta Hermosa', '2020-08-06', '20605951741', 'Laporto Producciones S.A.C', 'San Borja', 127.97, 151.00),
('F002-00003530', '20537098008', 'Corporacion Palomos S.A.C', 'Punta Hermosa', '2020-08-07', '20605951741', 'Laporto Producciones S.A.C', 'San Borja', 200.00, 236.00),
('F002-00003531', '20537098008', 'Corporacion Palomos S.A.C', 'Punta Hermosa', '2020-08-08', '20605951741', 'Laporto Producciones S.A.C', 'San Borja', 300.00, 354.00),
('F002-00003532', '20537098008', 'Corporacion Palomos S.A.C', 'Punta Hermosa', '2020-08-09', '20605951741', 'Laporto Producciones S.A.C', 'San Borja', 400.00, 472.00),
('F002-00003533', '20537098008', 'Corporacion Palomos S.A.C', 'Punta Hermosa', '2020-08-10', '20605951741', 'Laporto Producciones S.A.C', 'San Borja', 500.00, 590.00);
INSERT 0 5


databasecurso=# SELECT * FROM registro;  -- Visualizar tabla/>

 id | numero_factura | ruc_empresa |  	nombre_empresa     	   | direccion_empresa |   fecha  	| ruc_cliente |   	nombre_cliente   	     | direccion_cliente | subtotal | total  
----+----------------+-------------+---------------------------+-------------------+------------+-------------+----------------------------+-------------------+----------+--------
  1 | F002-00003529  | 20537098008 | Corporacion Palomos S.A.C | Punta Hermosa 	   | 2020-08-06 | 20605951741 | Laporto Producciones S.A.C | San Borja     	   |   127.97 | 151.00
  2 | F002-00003530  | 20537098008 | Corporacion Palomos S.A.C | Punta Hermosa 	   | 2020-08-07 | 20605951741 | Laporto Producciones S.A.C | San Borja         |   200.00 | 236.00
  3 | F002-00003531  | 20537098008 | Corporacion Palomos S.A.C | Punta Hermosa 	   | 2020-08-08 | 20605951741 | Laporto Producciones S.A.C | San Borja     	   |   300.00 | 354.00
  4 | F002-00003532  | 20537098008 | Corporacion Palomos S.A.C | Punta Hermosa 	   | 2020-08-09 | 20605951741 | Laporto Producciones S.A.C | San Borja     	   |   400.00 | 472.00
  5 | F002-00003533  | 20537098008 | Corporacion Palomos S.A.C | Punta Hermosa 	   | 2020-08-10 | 20605951741 | Laporto Producciones S.A.C | San Borja     	   |   500.00 | 590.00
(5 rows)

(END)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ingreso 5 queries para factura items


databasecurso=# INSERT INTO factura_items (id_factura, cantidad, unidad_medida, descripcion, precio_unitario, importe)
VALUES
(1, 3.0, 'NIU', 'Removedor de pintura', 45.00, 135.00),
(1, 2.0, 'NIU', 'Espátula 4"', 4.00, 8.00),
(1, 1.0, 'NIU', 'Waype', 3.00, 3.00),
(1, 1.0, 'NIU', 'Brocha 4"', 5.00, 5.00),
(1, 1.0, 'NIU', 'Brocha 2"', 5.00, 5.00),

(2, 3.0, 'NIU', 'Removedor de pintura', 50.00, 150.00),
(2, 2.0, 'NIU', 'Espátula 5"', 6.00, 12.00),
(2, 1.0, 'NIU', 'Waype grande', 4.00, 4.00),
(2, 1.0, 'NIU', 'Brocha 5"', 6.00, 6.00),
(2, 1.0, 'NIU', 'Cinta adhesiva', 3.00, 3.00),

(3, 3.0, 'NIU', 'Removedor de pintura', 60.00, 180.00),
(3, 2.0, 'NIU', 'Espátula 6"', 8.00, 16.00),
(3, 1.0, 'NIU', 'Waype extra', 5.00, 5.00),
(3, 1.0, 'NIU', 'Brocha 6"', 7.00, 7.00),
(3, 1.0, 'NIU', 'Cinta doble cara', 10.00, 10.00),

(4, 3.0, 'NIU', 'Removedor de pintura', 65.00, 195.00),
(4, 2.0, 'NIU', 'Espátula 7"', 10.00, 20.00),
(4, 1.0, 'NIU', 'Waype plus', 6.00, 6.00),
(4, 1.0, 'NIU', 'Brocha 7"', 8.00, 8.00),
(4, 1.0, 'NIU', 'Cinta plástica', 12.00, 12.00),

(5, 3.0, 'NIU', 'Removedor de pintura', 70.00, 210.00),
(5, 2.0, 'NIU', 'Espátula 8"', 12.00, 24.00),
(5, 1.0, 'NIU', 'Waype pro', 7.00, 7.00),
(5, 1.0, 'NIU', 'Brocha 8"', 9.00, 9.00),
(5, 1.0, 'NIU', 'Cinta transparente', 15.00, 15.00);
INSERT 0 25



databasecurso=# SELECT * FROM factura_items; --Visualizar tabla/>

 id | id_factura | cantidad | unidad_medida | 	descripcion  	     | precio_unitario | importe
 ----+------------+----------+---------------+----------------------+-----------------+--------- 
  1 |          1 | 	3.00    | NIU       	  | Removedor de pintura |           45.00 |  135.00
  2 |      	   1 | 	2.00    | NIU         	| Espátula 4"      	   |          	4.00 |	8.00
  3 |      	   1 | 	1.00    | NIU         	| Waype            	   |          	3.00 |	3.00
  4 |      	   1 | 	1.00    | NIU         	| Brocha 4"        	   |          	5.00 |	5.00
  5 |      	   1 | 	1.00    | NIU         	| Brocha 2"        	   |          	5.00 |	5.00
  6 |      	   2 | 	3.00    | NIU          	| Removedor de pintura |           50.00 |  150.00
  7 |      	   2 | 	2.00    | NIU         	| Espátula 5"      	   |          	6.00 |   12.00
  8 |      	   2 | 	1.00    | NIU         	| Waype grande     	   |          	4.00 |	4.00
  9 |      	   2 | 	1.00    | NIU         	| Brocha 5"        	   |          	6.00 |	6.00
  10 |      	   2 | 	1.00    | NIU         	| Cinta adhesiva   	   |          	3.00 |	3.00
  11 |      	   3 | 	3.00    | NIU         	| Removedor de pintura |           60.00 |  180.00
  12 |      	   3 | 	2.00    | NIU         	| Espátula 6"          |          	8.00 |   16.00
  13 |      	   3 | 	1.00    | NIU         	| Waype extra      	   |           	5.00 |	5.00
  14 |      	   3 | 	1.00    | NIU       	  | Brocha 6"        	   |          	7.00 |	7.00
  15 |      	   3 | 	1.00    | NIU          	| Cinta doble cara 	   |       	   10.00 |   10.00
  16 |      	   4 | 	3.00    | NIU         	| Removedor de pintura |       	   65.00 |  195.00
  17 |          4 | 	2.00    | NIU         	| Espátula 7"      	   |       	   10.00 |   20.00
  18 |      	   4 | 	1.00    | NIU         	| Waype plus       	   |          	6.00 |	6.00
  19 |      	   4 | 	1.00    | NIU          	| Brocha 7"        	   |        	  8.00 |	8.00
  20 |      	   4 | 	1.00    | NIU         	| Cinta plástica   	   |       	   12.00 |   12.00
  21 |      	   5 | 	3.00    | NIU         	| Removedor de pintura |       	   70.00 |  210.00
  22 |      	   5 | 	2.00    | NIU         	| Espátula 8"      	   |       	   12.00 |   24.00
  23 |      	   5 | 	1.00    | NIU         	| Waype pro            |          	7.00 |	7.00
  24 |      	   5 | 	1.00    | NIU         	| Brocha 8"        	   |          	9.00 |	9.00
  25 |      	   5 | 	1.00    | NIU       	  | Cinta transparente   |       	   15.00 |   15.00
  (25 rows)


-------------------------------------------------------------------------------------------------------------


--3. CONSULTAS

--Venta total (suma) de todas las facturas:

databasecurso=# SELECT SUM(total) AS venta_total FROM registro;
 venta_total
-------------
 	1803.00
(1 row)

--Venta promedio total por factura:

databasecurso=# SELECT AVG(total) AS venta_promedio FROM registro;
	venta_promedio    
----------------------
 360.6000000000000000
(1 row)


--Valor máximo y mínimo de los diferentes ítems de las diferentes facturas:

databasecurso=# SELECT MAX(importe) AS valor_maximo, MIN(importe) AS valor_minimo FROM factura_items;
 valor_maximo | valor_minimo
--------------+--------------
   	210.00 |     	3.00
(1 row)

-----------------------------------------------------------------------------------------------
