MS SQL Server Proficiency Test

-- 1/18: **Crear una tabla en SQL**
syntax. 
CREATE TABLE table_name (column1 datatype, column2 datatype, column3 datatype, ...);

ex. 
A: Creating a table with explicitly defined columns and data types

	CREATE TABLE Employees (
		EmployeeID INT,
		FirstName VARCHAR(50),
		LastName VARCHAR(50),
		HireDate DATE,
		Salary DECIMAL(10, 2)
	);

B: Creating a table from another table

	CREATE TABLE NewEmployees AS --AS para especificar 
	SELECT EmployeeID, FirstName, LastName 
	FROM Employees 
	WHERE HireDate > '2020-01-01';

--**Explicación 1/18**  
La sentencia `CREATE TABLE` se usa para crear una nueva tabla en la base de datos. Dentro de los paréntesis se definen las columnas de la tabla junto con su tipo de datos.
/*AS SELECT:
	En SQL, cuando usas CREATE TABLE ... AS SELECT ..., el AS indica que la nueva tabla será creada con la estructura y los datos seleccionados a partir de la consulta.
	Este uso de AS es para especificar que la creación de la tabla se hace a partir del resultado de una consulta.

AS (alias): En este caso, e es el alias para la tabla Employees, pero esto es diferente a la creación de una tabla.

	SELECT e.EmployeeID, e.FirstName, e.LastName
	FROM Employees AS e
	WHERE e.HireDate > '2020-01-01';

	El alias se usa en SQL para darle un nombre temporal a una tabla o a una columna dentro de una consulta. Esto es útil especialmente cuando trabajas con nombres largos de tablas o columnas, o cuando haces joins entre varias tablas y necesitas distinguir entre columnas con el mismo nombre.

--¿Por qué usar un alias para una tabla?
	*Facilitar la lectura: Si el nombre de la tabla es largo, un alias hace que el código sea más fácil de leer.
	
	*Simplificar consultas complejas: En consultas que involucran varias tablas (por ejemplo, cuando haces un JOIN), los alias ayudan a distinguir qué columnas provienen de qué tabla.
	
	*Evitar conflictos de nombres: Cuando tienes columnas con el mismo nombre en diferentes tablas, los alias pueden ayudarte a especificar a qué columna te refieres.

Ejemplo 1: Alias de tabla
	Imagina que tienes dos tablas llamadas Orders y Customers, y ambas tienen una columna llamada ID. Si no usas alias, tendrías que escribir el nombre completo de la tabla cada vez que haces referencia a esa columna:

	SELECT Orders.ID, Customers.ID 
	FROM Orders
	JOIN Customers ON Orders.CustomerID = Customers.CustomerID;	

	SELECT o.ID AS OrderID, c.ID AS CustomerID
	FROM Orders AS o
	JOIN Customers AS c ON o.CustomerID = c.CustomerID;

	* o es el alias para Orders.
	* c es el alias para Customers.
	* Se usa el alias en lugar de los nombres completos de las tablas, lo que hace que la consulta sea más corta y fácil de leer.

Ejemplo 2: Alias de columna

	SELECT EmployeeID AS ID, FirstName AS Name 
	FROM Employees;

En este caso:
	EmployeeID se renombra temporalmente como ID.
	FirstName se renombra como Name.

Esto es útil cuando quieres que los resultados de la consulta tengan nombres más amigables o comprensibles, especialmente cuando se están combinando columnas de diferentes tablas.
*/ 

---

--2/18: **Insertar datos en una tabla**
1. Insertar valores sin especificar columnas (cuando se insertan valores para todas las columnas de la tabla):
syntax. 
	INSERT INTO table_name VALUES (value1, value2, …);
ex.
	INSERT INTO Employees 
	VALUES (1, 'John', 'Doe', '2024-01-15', 50000.00);

/*En este caso, estamos insertando valores en todas las columnas de la tabla Employees, en el mismo orden en que están definidas en la tabla. Es importante que el número de valores coincida con el número de columnas de la tabla.*/


2. Insertar valores especificando columnas (cuando se insertan datos solo para algunas columnas de la tabla):
syntax. 
	INSERT INTO table_name (column1, column2, …) VALUES (value1, value2, …);
ex. 
	INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary 
	VALUES (2, 'Jane', 'Smith', 55000.00);
/*Insertas valores en columnas específicas, lo cual es útil si no deseas llenar todas las columnas o si el orden de las columnas no coincide con el orden en la tabla.*/

--**Explicación:**  
La primera forma de `INSERT INTO` inserta datos en todas las columnas de la tabla. La segunda forma permite especificar qué columnas se están insertando, lo que es útil cuando no se quieren insertar valores para todas las columnas.
/* */ 

---

-- 3/18: **Crear una clave primaria**
1. Crear una tabla con una clave primaria definida en la misma instrucción CREATE TABLE:
syntax.
	CREATE TABLE table_name (column1 datatype PRIMARY KEY, column2 datatype, …);
EX. 
	CREATE TABLE Employees (
		EmployeeID INT PRIMARY KEY,
		FirstName VARCHAR(50),
		LastName VARCHAR(50),
		HireDate DATE,
		Salary DECIMAL(10, 2)
	);
/*Se crea la tabla Employees con una columna EmployeeID que es definida como clave primaria. Esto significa que los valores en esta columna serán únicos y no podrán ser nulos.
Las otras columnas (FirstName, LastName, HireDate, Salary) se definen sin restricciones de clave primaria.*/ 

2. Modificar una tabla existente para agregar una clave primaria utilizando ALTER TABLE:
syntax.
	ALTER TABLE table_name ADD PRIMARY KEY (column1);
EX. 
	ALTER TABLE Employees 
	ADD PRIMARY KEY (EmployeeID);
/*Se utiliza la instrucción ALTER TABLE para agregar una clave primaria en la columna EmployeeID de la tabla Employees. Esto asegura que los valores en esa columna serán únicos y no nulos, si no lo están ya.*/

--**Explicación:**  
Se puede definir una clave primaria tanto en la creación de la tabla (al definir la columna) como agregándola después usando `ALTER TABLE` para una columna existente.

--Resumen:
- **`CREATE TABLE ... PRIMARY KEY`**: Se define una clave primaria durante la creación de la tabla.
- **`ALTER TABLE ... ADD PRIMARY KEY`**: Se agrega una clave primaria a una columna existente en una tabla ya creada.

/*
Alter
La palabra ALTER en SQL proviene del verbo en inglés "alter", que significa "modificar" o "cambiar". En el contexto de SQL, se usa para indicar que deseas realizar una modificación en la estructura de una tabla existente.
Por ejemplo, con ALTER TABLE, puedes modificar la definición de una tabla, como agregar o eliminar columnas, cambiar tipos de datos o agregar restricciones como claves primarias.

ALTER TABLE: "Modificar tabla"

Así que ALTER TABLE se puede interpretar como "Modificar la tabla", y la instrucción ALTER en general se usa para cambiar la estructura de la base de datos o de objetos dentro de la base de datos, sin necesidad de crear nuevos objetos desde cero.
*/
---

-- 4/18: **Crear un trigger**
/*
CREATE TRIGGER en SQL, que se usan para crear disparadores (triggers) en una base de datos. Los disparadores permiten ejecutar acciones automáticamente en respuesta a ciertos eventos (como INSERT, UPDATE, o DELETE) en una tabla.
*/
1. Sintaxis de CREATE TRIGGER con FOR para escuchar los eventos de INSERT, UPDATE y DELETE:
syntax.
	CREATE TRIGGER trigger_name ON table_name FOR INSERT, UPDATE, DELETE AS BEGIN … END;
EX. 
	CREATE TRIGGER trg_AfterInsertUpdateDelete
	ON Employees
	FOR INSERT, UPDATE, DELETE
	AS
	BEGIN
		-- Lógica o acciones a ejecutar cuando se inserte, actualice o elimine una fila en la tabla Employees
		PRINT 'Un cambio ha ocurrido en la tabla Employees.';
	END;
/*
En este ejemplo:

*CREATE TRIGGER trg_AfterInsertUpdateDelete: Crea un disparador llamado trg_AfterInsertUpdateDelete.
*FOR INSERT, UPDATE, DELETE: Indica que el disparador se activará cuando haya un INSERT, UPDATE o DELETE en la tabla Employees.
*AS BEGIN ... END: Dentro de este bloque es donde defines la lógica o las acciones que se ejecutarán cuando se active el disparador.
*/

2. Sintaxis de CREATE TRIGGER con AFTER para escuchar los eventos de INSERT, UPDATE y DELETE:
syntax.
	CREATE TRIGGER trigger_name ON table_name AFTER INSERT, UPDATE, DELETE AS BEGIN … END;
ex. 
	CREATE TRIGGER trg_AfterInsertUpdateDelete
	ON Employees
	AFTER INSERT, UPDATE, DELETE
	AS
	BEGIN
		-- Lógica o acciones a ejecutar después de que se haya insertado, actualizado o eliminado una fila
		PRINT 'Una fila ha sido insertada, actualizada o eliminada de la tabla Employees.';
	END;
	/*
	En este ejemplo:

AFTER INSERT, UPDATE, DELETE: Define que el disparador se ejecutará después de que los eventos de INSERT, UPDATE o DELETE hayan ocurrido en la tabla Employees.

*/

--**Explicación:**  
Un **trigger** se ejecuta automáticamente cuando se realiza una operación en una tabla. La cláusula `FOR` o `AFTER` especifica cuándo debe ejecutarse: `FOR` es más común, pero `AFTER` también es válido.
/*
La diferencia entre FOR y AFTER es sutil. Aunque ambos enfoques pueden ser usados para crear disparadores, algunos sistemas de bases de datos (como SQL Server) pueden tratar ambos de manera similar. Sin embargo, generalmente:

FOR: Es más común en bases de datos como SQL Server para disparadores que se ejecutan tanto antes como después del evento.
AFTER: Se utiliza cuando quieres que el disparador se ejecute después de que la acción (INSERT, UPDATE, DELETE) haya sido completada.
*/

---

--5/18: **Crear una función de partición**
/*
se utiliza para crear funciones de partición en bases de datos, especialmente en SQL Server. Estas funciones se utilizan para dividir una tabla o índice en particiones basadas en un rango de valores.
*/
1. Sintaxis de CREATE PARTITION FUNCTION con RANGE LEFT:
syntax.
	CREATE PARTITION FUNCTION function_name (datatype) AS RANGE LEFT FOR VALUES (value1, value2, …);
EX.
	CREATE PARTITION FUNCTION pf_SalaryRange (INT)
	AS RANGE LEFT FOR VALUES (30000, 50000, 70000);
/*
En este ejemplo:

CREATE PARTITION FUNCTION pf_SalaryRange (INT): Crea una función de partición llamada pf_SalaryRange que usa un tipo de dato INT (entero) para la partición.
AS RANGE LEFT: Especifica que la partición se realizará a la izquierda del valor de cada límite (es decir, el valor de cada partición será incluido en la partición que se encuentra a su izquierda).
FOR VALUES (30000, 50000, 70000): Define los valores de partición. Los registros que tengan valores de salario menores a 30,000 irán a la primera partición, los que estén entre 30,000 y 50,000 irán a la segunda, y así sucesivamente.

*/
syntax.
	CREATE PARTITION FUNCTION function_name (datatype) AS RANGE RIGHT FOR VALUES (value1, value2, …);

--**Explicación:**  
Las **funciones de partición** se usan para dividir grandes conjuntos de datos en rangos. `RANGE LEFT` o `RANGE RIGHT` definen cómo se dividen los valores en las particiones.
/*
Particion = división lógica de grandes tablas o índices en partes más pequeñas y manejables llamadas particiones.

Cada partición se gestiona de manera independiente, lo que mejora el rendimiento, la administración y la escalabilidad de las bases de datos. La partición no divide físicamente los datos, sino que organiza cómo se almacenan y acceden a ellos.

¿Cómo se hace la partición?
La partición de una tabla o índice se realiza según ciertos criterios de partición. Estos criterios pueden basarse en diferentes columnas o rangos de valores, como fechas, rangos numéricos o valores específicos.

	Tipos comunes de partición:
	Partición por rango (RANGE):
		Los datos se dividen en particiones basadas en rangos de valores de una columna específica.

		Ejemplo: Si tienes una tabla de empleados y quieres dividir los salarios en rangos, podrías particionar la tabla en rangos como: menores de 30,000, entre 30,000 y 50,000, y mayores de 50,000.
		En este caso, los valores de la columna (como el salario) se dividen en rangos, y cada rango corresponde a una partición separada.

	
	Partición por lista (LIST):
		Los datos se dividen en particiones basadas en valores específicos de una columna. Cada partición contiene un conjunto de valores definidos.

		Ejemplo: Si tienes una tabla de productos y quieres dividir los datos según categorías (como "Electrónica", "Ropa", "Alimentos"), puedes crear particiones para cada categoría.
	
	Partición compuesta:
		Combinación de diferentes métodos de partición, como partición por rango y lista.
	
	Partición por hash:
	Los datos se dividen de manera uniforme en particiones usando una función de dispersión (hash). Este método no depende de un rango o lista específica, sino que distribuye los datos aleatoriamente.
		
jemplo visual de partición por rango (RANGE LEFT):
Supongamos que tienes una tabla de ventas con una columna Amount (Monto de la venta). Quieres dividir las ventas en tres rangos:

Rango 1: Ventas menores a 10,000
Rango 2: Ventas entre 10,000 y 20,000
Rango 3: Ventas mayores a 20,000
La partición divide la tabla de esta manera:

Rango	Ventas
< 10,000	Partición 1
10,000 a 20,000	Partición 2
> 20,000	Partición 3

Esto ayuda a que las consultas que se centran en un rango específico (por ejemplo, ventas mayores a 20,000) sean más rápidas, ya que solo se accede a los datos de la partición relevante.

Beneficios de la partición:
Rendimiento mejorado: Las consultas que se centran en un subconjunto de datos pueden ejecutarse más rápido al acceder solo a la partición necesaria.
Gestión de grandes volúmenes de datos: Dividir grandes tablas en particiones facilita la administración de datos masivos, como el archivado o la eliminación de datos antiguos.
Optimización de mantenimiento: Las operaciones de mantenimiento, como la reorganización de índices o la actualización de datos, pueden realizarse de manera más eficiente en particiones individuales.
En resumen, la partición en bases de datos es un enfoque para dividir los datos en segmentos lógicos, lo que ayuda a mejorar el rendimiento, la organización y la escalabilidad de la base de datos.


Ejemplo2:
Imagina que tienes una tabla de ventas con millones de registros, y quieres realizar una consulta para obtener las ventas de un mes específico. Sin partición, el sistema tendría que revisar toda la tabla de ventas, lo que podría ser muy lento.

Si particionas la tabla de ventas por mes o año, el sistema solo necesitaría revisar la partición correspondiente al mes o año que te interesa, acelerando la consulta.

Tabla de ventas (no particionada):

			VentaID Fecha	Monto
			1	2023-01-01	100
			2	2023-01-15	200
			...	...	...
			50000	2024-11-30	150

Tabla de ventas (particionada por mes):
			
			Partición Enero 2023	Partición Febrero 2023	Partición Marzo 2023
			1, 2, 3, ...	200, 201, 202, ...	300, 301, 302, ...

En este caso, si buscas ventas en Enero 2023, la base de datos solo buscará en la partición correspondiente a ese mes, haciendo la consulta mucho más rápida.

Resumen:
La partición divide una tabla en segmentos más pequeños (particiones), lo que mejora la velocidad de las consultas, especialmente cuando trabajas con grandes volúmenes de datos. Esto se logra almacenando los datos de manera lógica según criterios específicos (por ejemplo, rangos de fechas, valores numéricos, etc.), lo que permite que las búsquedas se realicen más rápidamente y que las operaciones de mantenimiento sean más eficientes.

Lo que pasa con la tabla original:
	No se elimina la tabla original: La tabla original sigue existiendo, pero los datos se distribuyen entre las particiones según las reglas que definas. La estructura de la tabla no cambia, solo cómo se organiza internamente para mejorar el rendimiento.

	Particiones dentro de la misma tabla: En lugar de duplicar o crear tablas separadas, las particiones son solo segmentos lógicos dentro de la misma tabla. El sistema de gestión de bases de datos (DBMS) sabe cómo y dónde ubicar los datos en las particiones sin que el usuario tenga que preocuparse por esto.

	Acceso a las particiones: Cuando realizas consultas, la base de datos sabe cómo acceder a las particiones específicas según las condiciones de la consulta. No tienes que preocuparte por consultar una "tabla nueva", simplemente accedes a la tabla particionada y el sistema gestiona las particiones para ti.

	No es temporal: La partición es una estructura permanente a menos que decidas eliminarla explícitamente. No es una tabla temporal, sino una forma de organizar los datos de manera eficiente.

Ejemplo de cómo funciona:
Supongamos que tienes una tabla de ventas y decides particionarla por mes. El sistema particionará la tabla en subgrupos lógicos para cada mes, pero la tabla original sigue existiendo. El sistema sabrá cómo manejar los datos de cada mes de manera independiente.

Sin partición (tabla normal):
VentaID	Fecha	Monto
1	2023-01-01	100
2	2023-01-15	200
...	...	...
50000	2024-11-30	150
Con partición (por mes):
Internamente, la base de datos puede dividir los datos de la tabla de ventas en particiones lógicas para Enero, Febrero, Marzo, etc.
No se crea una tabla separada para cada mes, pero cada partición contiene solo los datos de ese mes.
Si consultas ventas de Enero 2023, la base de datos solo buscará en la partición correspondiente a Enero 2023, lo que hace que la consulta sea más rápida.
Resumen:
La partición no crea nuevas tablas separadas, sino que divide la tabla original en segmentos lógicos (particiones) según un criterio (como un rango de fechas). Estos segmentos son gestionados de manera independiente para mejorar el rendimiento de las consultas. La tabla original sigue existiendo y los datos no se duplican, pero se reorganizan para optimizar la búsqueda y el mantenimiento.

Ejemplo de cómo la base de datos maneja las particiones:
Si consultas las ventas de enero de 2023:


SELECT * FROM ventas
WHERE Fecha BETWEEN '2023-01-01' AND '2023-01-31';
	
La base de datos solo buscará en la partición correspondiente a Enero 2023, lo que hace que la consulta sea mucho más rápida en comparación con una tabla no particionada, que tendría que recorrer toda la tabla para encontrar los resultados.

1. Eliminar la partición y volver a la tabla original:
La partición no elimina la tabla original; solo divide lógicamente los datos. Para eliminar la partición, normalmente tienes que eliminar la función de partición y volver a una estructura de tabla normal. (Esto eliminará la función de partición, pero los datos seguirán existiendo.)

DROP PARTITION FUNCTION [function_name];

2. Eliminar el esquema de partición (Partition Scheme): El esquema de partición define cómo se aplican las particiones a la tabla. Si la tabla usa un esquema de partición, también deberás eliminarlo.

DROP PARTITION SCHEME [scheme_name];

3. Reorganizar los datos en la tabla: Después de eliminar la partición, los datos pueden estar distribuidos entre diferentes particiones físicas. Para reorganizar los datos en una sola tabla sin partición, puedes eliminar y volver a crear el índice, o crear una nueva tabla sin partición y transferir los datos.

Método 1: Transferir los datos a una nueva tabla sin partición.

Crea una nueva tabla sin partición.

Inserta los datos de la tabla particionada en la nueva tabla.

	CREATE TABLE new_table (
  column1 datatype,
  column2 datatype,
  ...
);

INSERT INTO new_table SELECT * FROM original_table;

Elimina la tabla particionada original (si ya no la necesitas).

DROP TABLE original_table;

2. Restaurar la tabla a su estado anterior:
Si tienes una copia de seguridad de la tabla antes de que fuera particionada, otra opción es restaurar la tabla desde ese respaldo. Este enfoque puede ser más sencillo si tienes el respaldo de la tabla antes de aplicar el particionamiento.

-- Si tienes un backup, puedes restaurar la tabla:
RESTORE TABLE [table_name] FROM DISK = 'path_to_backup_file';

3. Reconfigurar los índices (si es necesario):
Si al particionar se crearon índices específicos para las particiones, es posible que también debas eliminar esos índices y crear nuevos índices en la tabla no particionada.

-- Eliminar el índice de partición
DROP INDEX [index_name] ON [table_name];

-- Crear nuevos índices si es necesario
CREATE INDEX [index_name] ON [table_name] (column_name);

Resumen:
	Para deshacer una partición en SQL Server u otros sistemas de bases de datos:

	*Elimina la función de partición y el esquema de partición.
	*Reorganiza los datos en una tabla sin particionamiento.
	*Si es necesario, crea índices apropiados para la nueva tabla.
	*Como alternativa, si tienes un respaldo, puedes restaurar la tabla a su estado anterior.

*/

---

---6/18: **Operador EXCEPT**

It returns the rows that are in the first result set but not in the second result set.

**Explicación:**  
El operador `EXCEPT` devuelve las filas que están en el primer conjunto de resultados pero no en el segundo. Es útil para encontrar diferencias entre dos conjuntos de datos.

SYNTAXIS.
	SELECT column1, column2, ...
	FROM table1
	EXCEPT
	SELECT column1, column2, ...
	FROM table2;


/*
El operador EXCEPT en SQL es particularmente útil cuando necesitas comparar dos conjuntos de datos y obtener solo los registros que existen en el primer conjunto, pero no en el segundo. Aquí está la explicación desglosada con un ejemplo:

Ejemplo práctico
Imaginemos dos tablas:

Tabla A (employees_in_project1)
EmployeeID	Name
1	John
2	Alice
3	Bob
Tabla B (employees_in_project2)
EmployeeID	Name
2	Alice
3	Bob
4	Carol

Si deseas encontrar empleados que están en el proyecto 1, pero no en el proyecto 2, puedes usar EXCEPT:

SELECT EmployeeID, Name
FROM employees_in_project1
EXCEPT
SELECT EmployeeID, Name
FROM employees_in_project2;

Resultado
El resultado incluirá solo las filas que están en la Tabla A (employees_in_project1), pero no en la Tabla B (employees_in_project2):

EmployeeID	Name
1	John

Notas importantes
Orden y columnas:
Las columnas en ambos conjuntos deben coincidir en:

Número de columnas.
Orden.
Tipos de datos.
Sin duplicados:
EXCEPT elimina automáticamente los duplicados, como lo haría un DISTINCT.

Caso especial - Sin resultados:
Si todos los registros del primer conjunto también están en el segundo, el resultado será un conjunto vacío.

En resumen, EXCEPT es excelente para identificar diferencias entre dos conjuntos de datos, como elementos que existen en un grupo, pero no en otro.
*/


---

--- 7/18: **Operador PIVOT**
It converts rows into columns.

/*
El operador PIVOT en SQL es una herramienta muy útil para reorganizar datos de filas a columnas. Sirve principalmente para análisis donde necesitas agrupar información y mostrarla de una forma más compacta o intuitiva.
*/
syntax.
	SELECT <column1>, [PivotColumn1], [PivotColumn2], ...
	FROM (
		SELECT <column1>, <column2>, <value_column>
		FROM <table>
	) AS SourceTable
	PIVOT (
		SUM(<value_column>) -- O cualquier función de agregación
		FOR <column2> IN ([PivotColumn1], [PivotColumn2], ...)
	) AS PivotTable;

---**Explicación:**  
--pivot = reorganizar los datos (convirtiendo filas en columnas (o viceversa).)
El operador `PIVOT` transforma datos de filas a columnas. Esto es útil cuando se quiere cambiar la disposición de los datos, por ejemplo, para realizar análisis cruzados.

Ejemplo práctico

	Tabla original (sales)
	Year	Month	Sales
	2023	January	100
	2023	February	150
	2023	March	200
	2024	January	120
	2024	February	180

Si quieres convertir los meses en columnas para ver las ventas agrupadas por año, usas el operador PIVOT:

EX.
	SELECT Year, [January], [February], [March]
	FROM (
		SELECT Year, Month, Sales
		FROM sales
	) AS SourceTable
	PIVOT (
		SUM(Sales)
		FOR Month IN ([January], [February], [March])
	) AS PivotTable;

	Resultado
Year	January	February	March
2023	100	150	200
2024	120	180	NULL

/*
Notas importantes
Transformación de datos:
PIVOT siempre necesita una función de agregación (como SUM, AVG, etc.) para calcular valores cuando hay datos duplicados para una combinación de columnas.

Filas a columnas:
Se define qué columna del conjunto de datos se convertirá en encabezados de columna (en este caso, Month).

Valores faltantes:
Si una fila no tiene datos para una combinación específica (como "March" en 2024), el resultado será NULL.

Cuándo usar PIVOT
Resumir ventas, ingresos o cualquier métrica agrupada.
Reorganizar datos para reportes tabulares.
Análisis cruzados de categorías (por ejemplo, comparación de productos por regiones).
En resumen, PIVOT es útil para transformar datos de una forma que facilite la visualización y análisis al convertir filas en columnas.
*/
---

### 8/18: **Declarar una variable**
**Respuesta correcta:**
```sql
DECLARE @name VARCHAR(50);
```
**Explicación:**  
En SQL Server, la sintaxis correcta para declarar una variable es `DECLARE @variable_name data_type;`. Específicamente, en este caso, se declara una variable `@name` de tipo `VARCHAR(50)`.

---

### 9/18: **Crear una función que devuelve una tabla**
**Respuesta correcta:**
```sql
CREATE FUNCTION fn_name (@param INT) RETURNS TABLE AS SELECT * FROM table_name WHERE column_name = @param;
```
**Explicación:**  
Las funciones que devuelven una tabla en SQL Server deben usar la palabra clave `RETURNS TABLE` y se define la consulta `SELECT` que devuelve los datos. La sintaxis correcta no debe usar `RETURN` como si fuera una función escalar.

---

### 10/18: **Usar la cláusula OUTPUT**
**Respuesta correcta:**  
```sql
INSERT INTO table_name OUTPUT inserted.* VALUES (‘value1’, ‘value2’, …);
UPDATE table_name SET column_name = ‘value’ OUTPUT deleted.* WHERE condition;
DELETE FROM table_name OUTPUT deleted.* WHERE condition;
```
**Explicación:**  
La cláusula `OUTPUT` se utiliza para devolver los valores insertados, actualizados o eliminados. Se puede usar en operaciones `INSERT`, `UPDATE` y `DELETE` para capturar el resultado.

---

### 11/18: **Usar la sentencia MERGE**
**Respuesta correcta:**
```sql
MERGE target_table USING source_table ON join_condition WHEN MATCHED THEN UPDATE SET column_name = value WHEN NOT MATCHED THEN INSERT (column_list) VALUES (value_list);
```
**Explicación:**  
La sentencia `MERGE` se utiliza para combinar datos de una tabla de origen con una tabla de destino según una condición de coincidencia. Si los registros coinciden, se actualizan; si no, se insertan nuevos registros.

---

### 12/18: **Usar la función ROW_NUMBER()**
**Respuesta correcta:**
```sql
SELECT ROW_NUMBER() OVER (ORDER BY column_name) AS row_num, column_name FROM table_name;
SELECT ROW_NUMBER() OVER (PARTITION BY column_name ORDER BY column_name) AS row_num, column_name FROM table_name;
SELECT ROW_NUMBER() OVER (ORDER BY column_name DESC) AS row_num, column_name FROM table_name;
```
**Explicación:**  
La función `ROW_NUMBER()` se utiliza para asignar un número de fila único a cada fila dentro de un conjunto de resultados. Se puede usar con `ORDER BY` y `PARTITION BY` para controlar cómo se numeran las filas.

---

### 13/18: **Usar TRY_CONVERT()**
**Respuesta correcta:**
```sql
SELECT TRY_CONVERT(DATE, ‘2024-01-29’);
SELECT TRY_CONVERT(INT, ‘123’);
```
**Explicación:**  
La función `TRY_CONVERT()` intenta convertir un valor a un tipo de datos especificado y devuelve `NULL` si la conversión falla. Es útil para manejar conversiones que pueden no ser válidas.

---

### 14/18: **Ejecutar un procedimiento almacenado**
**Respuesta correcta:**
```sql
EXECUTE procedure_name;
EXEC procedure_name;
```
**Explicación:**  
En SQL Server, se puede ejecutar un procedimiento almacenado usando las palabras clave `EXECUTE` o su forma abreviada `EXEC`.

---

### 15/18: **Pasar parámetros a un procedimiento almacenado**
**Respuesta correcta:**
```sql
By position: EXECUTE procedure_name ‘value1’, ‘value2’, …;
By name: EXECUTE procedure_name @param1 = ‘value1’, @param2 = ‘value2’, …;
```
**Explicación:**  
Se pueden pasar parámetros a un procedimiento almacenado de dos formas: por posición o por nombre. La forma por nombre permite especificar los parámetros de manera más clara.

---

### 16/18: **Usar la sentencia RETURN en un procedimiento almacenado**
**Respuesta correcta:**
```
To return a single integer value to the caller.
To exit the stored procedure and return control to the caller.
```
**Explicación:**  
El `RETURN` en un procedimiento almacenado puede usarse para devolver un valor entero o simplemente para salir del procedimiento y devolver el control al llamador.

---

### 17/18: **Usar el tipo de dato JSON**
**Respuesta correcta:**
```sql
SELECT * FROM OPENJSON(‘{“books”: [{“title”: “The Catcher in the Rye”, “author”: “J.D. Salinger”}]}’, ‘$.books’);
SELECT JSON_VALUE(‘{“books”: [{“title”: “The Catcher in the Rye”, “author”: “J.D. Salinger”}]}’, ‘$.books[0].title’);
```
**Explicación:**  
SQL Server permite trabajar con datos JSON utilizando funciones como `OPENJSON` y `JSON_VALUE`. `OPENJSON` descompone el JSON en filas, mientras que `JSON_VALUE` extrae un valor de una cadena JSON.

---

### 18/18: **Uso incorrecto de un cursor**
**Respuesta correcta:**
```sql
DECLARE cursor_name CURSOR FOR SELECT * FROM table_name; OPEN cursor_name; FETCH NEXT FROM cursor_name INTO @variable; WHILE @@FETCH_STATUS = 0 BEGIN -- do something FETCH NEXT FROM cursor_name INTO @variable; END; CLOSE cursor_name; DEALLOCATE cursor_name;
```
**Explicación:**  
Aunque el código es correcto, en este caso, el tipo de cursor especificado en la opción incorrecta (si existiera) puede afectar el comportamiento de la consulta. Dependiendo de los valores del cursor, pueden producirse errores si no se manejan correctamente.

---

Espero que estas explicaciones te ayuden a entender el por qué de las respuestas correctas. Si tienes alguna duda adicional, ¡no dudes en preguntar!