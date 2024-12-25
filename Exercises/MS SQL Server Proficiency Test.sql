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

--**Explicaci�n 1/18**  
La sentencia `CREATE TABLE` se usa para crear una nueva tabla en la base de datos. Dentro de los par�ntesis se definen las columnas de la tabla junto con su tipo de datos.
/*AS SELECT:
	En SQL, cuando usas CREATE TABLE ... AS SELECT ..., el AS indica que la nueva tabla ser� creada con la estructura y los datos seleccionados a partir de la consulta.
	Este uso de AS es para especificar que la creaci�n de la tabla se hace a partir del resultado de una consulta.

AS (alias): En este caso, e es el alias para la tabla Employees, pero esto es diferente a la creaci�n de una tabla.

	SELECT e.EmployeeID, e.FirstName, e.LastName
	FROM Employees AS e
	WHERE e.HireDate > '2020-01-01';

	El alias se usa en SQL para darle un nombre temporal a una tabla o a una columna dentro de una consulta. Esto es �til especialmente cuando trabajas con nombres largos de tablas o columnas, o cuando haces joins entre varias tablas y necesitas distinguir entre columnas con el mismo nombre.

--�Por qu� usar un alias para una tabla?
	*Facilitar la lectura: Si el nombre de la tabla es largo, un alias hace que el c�digo sea m�s f�cil de leer.
	
	*Simplificar consultas complejas: En consultas que involucran varias tablas (por ejemplo, cuando haces un JOIN), los alias ayudan a distinguir qu� columnas provienen de qu� tabla.
	
	*Evitar conflictos de nombres: Cuando tienes columnas con el mismo nombre en diferentes tablas, los alias pueden ayudarte a especificar a qu� columna te refieres.

Ejemplo 1: Alias de tabla
	Imagina que tienes dos tablas llamadas Orders y Customers, y ambas tienen una columna llamada ID. Si no usas alias, tendr�as que escribir el nombre completo de la tabla cada vez que haces referencia a esa columna:

	SELECT Orders.ID, Customers.ID 
	FROM Orders
	JOIN Customers ON Orders.CustomerID = Customers.CustomerID;	

	SELECT o.ID AS OrderID, c.ID AS CustomerID
	FROM Orders AS o
	JOIN Customers AS c ON o.CustomerID = c.CustomerID;

	* o es el alias para Orders.
	* c es el alias para Customers.
	* Se usa el alias en lugar de los nombres completos de las tablas, lo que hace que la consulta sea m�s corta y f�cil de leer.

Ejemplo 2: Alias de columna

	SELECT EmployeeID AS ID, FirstName AS Name 
	FROM Employees;

En este caso:
	EmployeeID se renombra temporalmente como ID.
	FirstName se renombra como Name.

Esto es �til cuando quieres que los resultados de la consulta tengan nombres m�s amigables o comprensibles, especialmente cuando se est�n combinando columnas de diferentes tablas.
*/ 

---

--2/18: **Insertar datos en una tabla**
1. Insertar valores sin especificar columnas (cuando se insertan valores para todas las columnas de la tabla):
syntax. 
	INSERT INTO table_name VALUES (value1, value2, �);
ex.
	INSERT INTO Employees 
	VALUES (1, 'John', 'Doe', '2024-01-15', 50000.00);

/*En este caso, estamos insertando valores en todas las columnas de la tabla Employees, en el mismo orden en que est�n definidas en la tabla. Es importante que el n�mero de valores coincida con el n�mero de columnas de la tabla.*/


2. Insertar valores especificando columnas (cuando se insertan datos solo para algunas columnas de la tabla):
syntax. 
	INSERT INTO table_name (column1, column2, �) VALUES (value1, value2, �);
ex. 
	INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary 
	VALUES (2, 'Jane', 'Smith', 55000.00);
/*Insertas valores en columnas espec�ficas, lo cual es �til si no deseas llenar todas las columnas o si el orden de las columnas no coincide con el orden en la tabla.*/

--**Explicaci�n:**  
La primera forma de `INSERT INTO` inserta datos en todas las columnas de la tabla. La segunda forma permite especificar qu� columnas se est�n insertando, lo que es �til cuando no se quieren insertar valores para todas las columnas.
/* */ 

---

-- 3/18: **Crear una clave primaria**
1. Crear una tabla con una clave primaria definida en la misma instrucci�n CREATE TABLE:
syntax.
	CREATE TABLE table_name (column1 datatype PRIMARY KEY, column2 datatype, �);
EX. 
	CREATE TABLE Employees (
		EmployeeID INT PRIMARY KEY,
		FirstName VARCHAR(50),
		LastName VARCHAR(50),
		HireDate DATE,
		Salary DECIMAL(10, 2)
	);
/*Se crea la tabla Employees con una columna EmployeeID que es definida como clave primaria. Esto significa que los valores en esta columna ser�n �nicos y no podr�n ser nulos.
Las otras columnas (FirstName, LastName, HireDate, Salary) se definen sin restricciones de clave primaria.*/ 

2. Modificar una tabla existente para agregar una clave primaria utilizando ALTER TABLE:
syntax.
	ALTER TABLE table_name ADD PRIMARY KEY (column1);
EX. 
	ALTER TABLE Employees 
	ADD PRIMARY KEY (EmployeeID);
/*Se utiliza la instrucci�n ALTER TABLE para agregar una clave primaria en la columna EmployeeID de la tabla Employees. Esto asegura que los valores en esa columna ser�n �nicos y no nulos, si no lo est�n ya.*/

--**Explicaci�n:**  
Se puede definir una clave primaria tanto en la creaci�n de la tabla (al definir la columna) como agreg�ndola despu�s usando `ALTER TABLE` para una columna existente.

--Resumen:
- **`CREATE TABLE ... PRIMARY KEY`**: Se define una clave primaria durante la creaci�n de la tabla.
- **`ALTER TABLE ... ADD PRIMARY KEY`**: Se agrega una clave primaria a una columna existente en una tabla ya creada.

/*
Alter
La palabra ALTER en SQL proviene del verbo en ingl�s "alter", que significa "modificar" o "cambiar". En el contexto de SQL, se usa para indicar que deseas realizar una modificaci�n en la estructura de una tabla existente.
Por ejemplo, con ALTER TABLE, puedes modificar la definici�n de una tabla, como agregar o eliminar columnas, cambiar tipos de datos o agregar restricciones como claves primarias.

ALTER TABLE: "Modificar tabla"

As� que ALTER TABLE se puede interpretar como "Modificar la tabla", y la instrucci�n ALTER en general se usa para cambiar la estructura de la base de datos o de objetos dentro de la base de datos, sin necesidad de crear nuevos objetos desde cero.
*/
---

-- 4/18: **Crear un trigger**
/*
CREATE TRIGGER en SQL, que se usan para crear disparadores (triggers) en una base de datos. Los disparadores permiten ejecutar acciones autom�ticamente en respuesta a ciertos eventos (como INSERT, UPDATE, o DELETE) en una tabla.
*/
1. Sintaxis de CREATE TRIGGER con FOR para escuchar los eventos de INSERT, UPDATE y DELETE:
syntax.
	CREATE TRIGGER trigger_name ON table_name FOR INSERT, UPDATE, DELETE AS BEGIN � END;
EX. 
	CREATE TRIGGER trg_AfterInsertUpdateDelete
	ON Employees
	FOR INSERT, UPDATE, DELETE
	AS
	BEGIN
		-- L�gica o acciones a ejecutar cuando se inserte, actualice o elimine una fila en la tabla Employees
		PRINT 'Un cambio ha ocurrido en la tabla Employees.';
	END;
/*
En este ejemplo:

*CREATE TRIGGER trg_AfterInsertUpdateDelete: Crea un disparador llamado trg_AfterInsertUpdateDelete.
*FOR INSERT, UPDATE, DELETE: Indica que el disparador se activar� cuando haya un INSERT, UPDATE o DELETE en la tabla Employees.
*AS BEGIN ... END: Dentro de este bloque es donde defines la l�gica o las acciones que se ejecutar�n cuando se active el disparador.
*/

2. Sintaxis de CREATE TRIGGER con AFTER para escuchar los eventos de INSERT, UPDATE y DELETE:
syntax.
	CREATE TRIGGER trigger_name ON table_name AFTER INSERT, UPDATE, DELETE AS BEGIN � END;
ex. 
	CREATE TRIGGER trg_AfterInsertUpdateDelete
	ON Employees
	AFTER INSERT, UPDATE, DELETE
	AS
	BEGIN
		-- L�gica o acciones a ejecutar despu�s de que se haya insertado, actualizado o eliminado una fila
		PRINT 'Una fila ha sido insertada, actualizada o eliminada de la tabla Employees.';
	END;
	/*
	En este ejemplo:

AFTER INSERT, UPDATE, DELETE: Define que el disparador se ejecutar� despu�s de que los eventos de INSERT, UPDATE o DELETE hayan ocurrido en la tabla Employees.

*/

--**Explicaci�n:**  
Un **trigger** se ejecuta autom�ticamente cuando se realiza una operaci�n en una tabla. La cl�usula `FOR` o `AFTER` especifica cu�ndo debe ejecutarse: `FOR` es m�s com�n, pero `AFTER` tambi�n es v�lido.
/*
La diferencia entre FOR y AFTER es sutil. Aunque ambos enfoques pueden ser usados para crear disparadores, algunos sistemas de bases de datos (como SQL Server) pueden tratar ambos de manera similar. Sin embargo, generalmente:

FOR: Es m�s com�n en bases de datos como SQL Server para disparadores que se ejecutan tanto antes como despu�s del evento.
AFTER: Se utiliza cuando quieres que el disparador se ejecute despu�s de que la acci�n (INSERT, UPDATE, DELETE) haya sido completada.
*/

---

--5/18: **Crear una funci�n de partici�n**
/*
se utiliza para crear funciones de partici�n en bases de datos, especialmente en SQL Server. Estas funciones se utilizan para dividir una tabla o �ndice en particiones basadas en un rango de valores.
*/
1. Sintaxis de CREATE PARTITION FUNCTION con RANGE LEFT:
syntax.
	CREATE PARTITION FUNCTION function_name (datatype) AS RANGE LEFT FOR VALUES (value1, value2, �);
EX.
	CREATE PARTITION FUNCTION pf_SalaryRange (INT)
	AS RANGE LEFT FOR VALUES (30000, 50000, 70000);
/*
En este ejemplo:

CREATE PARTITION FUNCTION pf_SalaryRange (INT): Crea una funci�n de partici�n llamada pf_SalaryRange que usa un tipo de dato INT (entero) para la partici�n.
AS RANGE LEFT: Especifica que la partici�n se realizar� a la izquierda del valor de cada l�mite (es decir, el valor de cada partici�n ser� incluido en la partici�n que se encuentra a su izquierda).
FOR VALUES (30000, 50000, 70000): Define los valores de partici�n. Los registros que tengan valores de salario menores a 30,000 ir�n a la primera partici�n, los que est�n entre 30,000 y 50,000 ir�n a la segunda, y as� sucesivamente.

*/
syntax.
	CREATE PARTITION FUNCTION function_name (datatype) AS RANGE RIGHT FOR VALUES (value1, value2, �);

--**Explicaci�n:**  
Las **funciones de partici�n** se usan para dividir grandes conjuntos de datos en rangos. `RANGE LEFT` o `RANGE RIGHT` definen c�mo se dividen los valores en las particiones.
/*
Particion = divisi�n l�gica de grandes tablas o �ndices en partes m�s peque�as y manejables llamadas particiones.

Cada partici�n se gestiona de manera independiente, lo que mejora el rendimiento, la administraci�n y la escalabilidad de las bases de datos. La partici�n no divide f�sicamente los datos, sino que organiza c�mo se almacenan y acceden a ellos.

�C�mo se hace la partici�n?
La partici�n de una tabla o �ndice se realiza seg�n ciertos criterios de partici�n. Estos criterios pueden basarse en diferentes columnas o rangos de valores, como fechas, rangos num�ricos o valores espec�ficos.

	Tipos comunes de partici�n:
	Partici�n por rango (RANGE):
		Los datos se dividen en particiones basadas en rangos de valores de una columna espec�fica.

		Ejemplo: Si tienes una tabla de empleados y quieres dividir los salarios en rangos, podr�as particionar la tabla en rangos como: menores de 30,000, entre 30,000 y 50,000, y mayores de 50,000.
		En este caso, los valores de la columna (como el salario) se dividen en rangos, y cada rango corresponde a una partici�n separada.

	
	Partici�n por lista (LIST):
		Los datos se dividen en particiones basadas en valores espec�ficos de una columna. Cada partici�n contiene un conjunto de valores definidos.

		Ejemplo: Si tienes una tabla de productos y quieres dividir los datos seg�n categor�as (como "Electr�nica", "Ropa", "Alimentos"), puedes crear particiones para cada categor�a.
	
	Partici�n compuesta:
		Combinaci�n de diferentes m�todos de partici�n, como partici�n por rango y lista.
	
	Partici�n por hash:
	Los datos se dividen de manera uniforme en particiones usando una funci�n de dispersi�n (hash). Este m�todo no depende de un rango o lista espec�fica, sino que distribuye los datos aleatoriamente.
		
jemplo visual de partici�n por rango (RANGE LEFT):
Supongamos que tienes una tabla de ventas con una columna Amount (Monto de la venta). Quieres dividir las ventas en tres rangos:

Rango 1: Ventas menores a 10,000
Rango 2: Ventas entre 10,000 y 20,000
Rango 3: Ventas mayores a 20,000
La partici�n divide la tabla de esta manera:

Rango	Ventas
< 10,000	Partici�n 1
10,000 a 20,000	Partici�n 2
> 20,000	Partici�n 3

Esto ayuda a que las consultas que se centran en un rango espec�fico (por ejemplo, ventas mayores a 20,000) sean m�s r�pidas, ya que solo se accede a los datos de la partici�n relevante.

Beneficios de la partici�n:
Rendimiento mejorado: Las consultas que se centran en un subconjunto de datos pueden ejecutarse m�s r�pido al acceder solo a la partici�n necesaria.
Gesti�n de grandes vol�menes de datos: Dividir grandes tablas en particiones facilita la administraci�n de datos masivos, como el archivado o la eliminaci�n de datos antiguos.
Optimizaci�n de mantenimiento: Las operaciones de mantenimiento, como la reorganizaci�n de �ndices o la actualizaci�n de datos, pueden realizarse de manera m�s eficiente en particiones individuales.
En resumen, la partici�n en bases de datos es un enfoque para dividir los datos en segmentos l�gicos, lo que ayuda a mejorar el rendimiento, la organizaci�n y la escalabilidad de la base de datos.


Ejemplo2:
Imagina que tienes una tabla de ventas con millones de registros, y quieres realizar una consulta para obtener las ventas de un mes espec�fico. Sin partici�n, el sistema tendr�a que revisar toda la tabla de ventas, lo que podr�a ser muy lento.

Si particionas la tabla de ventas por mes o a�o, el sistema solo necesitar�a revisar la partici�n correspondiente al mes o a�o que te interesa, acelerando la consulta.

Tabla de ventas (no particionada):

			VentaID Fecha	Monto
			1	2023-01-01	100
			2	2023-01-15	200
			...	...	...
			50000	2024-11-30	150

Tabla de ventas (particionada por mes):
			
			Partici�n Enero 2023	Partici�n Febrero 2023	Partici�n Marzo 2023
			1, 2, 3, ...	200, 201, 202, ...	300, 301, 302, ...

En este caso, si buscas ventas en Enero 2023, la base de datos solo buscar� en la partici�n correspondiente a ese mes, haciendo la consulta mucho m�s r�pida.

Resumen:
La partici�n divide una tabla en segmentos m�s peque�os (particiones), lo que mejora la velocidad de las consultas, especialmente cuando trabajas con grandes vol�menes de datos. Esto se logra almacenando los datos de manera l�gica seg�n criterios espec�ficos (por ejemplo, rangos de fechas, valores num�ricos, etc.), lo que permite que las b�squedas se realicen m�s r�pidamente y que las operaciones de mantenimiento sean m�s eficientes.

Lo que pasa con la tabla original:
	No se elimina la tabla original: La tabla original sigue existiendo, pero los datos se distribuyen entre las particiones seg�n las reglas que definas. La estructura de la tabla no cambia, solo c�mo se organiza internamente para mejorar el rendimiento.

	Particiones dentro de la misma tabla: En lugar de duplicar o crear tablas separadas, las particiones son solo segmentos l�gicos dentro de la misma tabla. El sistema de gesti�n de bases de datos (DBMS) sabe c�mo y d�nde ubicar los datos en las particiones sin que el usuario tenga que preocuparse por esto.

	Acceso a las particiones: Cuando realizas consultas, la base de datos sabe c�mo acceder a las particiones espec�ficas seg�n las condiciones de la consulta. No tienes que preocuparte por consultar una "tabla nueva", simplemente accedes a la tabla particionada y el sistema gestiona las particiones para ti.

	No es temporal: La partici�n es una estructura permanente a menos que decidas eliminarla expl�citamente. No es una tabla temporal, sino una forma de organizar los datos de manera eficiente.

Ejemplo de c�mo funciona:
Supongamos que tienes una tabla de ventas y decides particionarla por mes. El sistema particionar� la tabla en subgrupos l�gicos para cada mes, pero la tabla original sigue existiendo. El sistema sabr� c�mo manejar los datos de cada mes de manera independiente.

Sin partici�n (tabla normal):
VentaID	Fecha	Monto
1	2023-01-01	100
2	2023-01-15	200
...	...	...
50000	2024-11-30	150
Con partici�n (por mes):
Internamente, la base de datos puede dividir los datos de la tabla de ventas en particiones l�gicas para Enero, Febrero, Marzo, etc.
No se crea una tabla separada para cada mes, pero cada partici�n contiene solo los datos de ese mes.
Si consultas ventas de Enero 2023, la base de datos solo buscar� en la partici�n correspondiente a Enero 2023, lo que hace que la consulta sea m�s r�pida.
Resumen:
La partici�n no crea nuevas tablas separadas, sino que divide la tabla original en segmentos l�gicos (particiones) seg�n un criterio (como un rango de fechas). Estos segmentos son gestionados de manera independiente para mejorar el rendimiento de las consultas. La tabla original sigue existiendo y los datos no se duplican, pero se reorganizan para optimizar la b�squeda y el mantenimiento.

Ejemplo de c�mo la base de datos maneja las particiones:
Si consultas las ventas de enero de 2023:


SELECT * FROM ventas
WHERE Fecha BETWEEN '2023-01-01' AND '2023-01-31';
	
La base de datos solo buscar� en la partici�n correspondiente a Enero 2023, lo que hace que la consulta sea mucho m�s r�pida en comparaci�n con una tabla no particionada, que tendr�a que recorrer toda la tabla para encontrar los resultados.

1. Eliminar la partici�n y volver a la tabla original:
La partici�n no elimina la tabla original; solo divide l�gicamente los datos. Para eliminar la partici�n, normalmente tienes que eliminar la funci�n de partici�n y volver a una estructura de tabla normal. (Esto eliminar� la funci�n de partici�n, pero los datos seguir�n existiendo.)

DROP PARTITION FUNCTION [function_name];

2. Eliminar el esquema de partici�n (Partition Scheme): El esquema de partici�n define c�mo se aplican las particiones a la tabla. Si la tabla usa un esquema de partici�n, tambi�n deber�s eliminarlo.

DROP PARTITION SCHEME [scheme_name];

3. Reorganizar los datos en la tabla: Despu�s de eliminar la partici�n, los datos pueden estar distribuidos entre diferentes particiones f�sicas. Para reorganizar los datos en una sola tabla sin partici�n, puedes eliminar y volver a crear el �ndice, o crear una nueva tabla sin partici�n y transferir los datos.

M�todo 1: Transferir los datos a una nueva tabla sin partici�n.

Crea una nueva tabla sin partici�n.

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
Si tienes una copia de seguridad de la tabla antes de que fuera particionada, otra opci�n es restaurar la tabla desde ese respaldo. Este enfoque puede ser m�s sencillo si tienes el respaldo de la tabla antes de aplicar el particionamiento.

-- Si tienes un backup, puedes restaurar la tabla:
RESTORE TABLE [table_name] FROM DISK = 'path_to_backup_file';

3. Reconfigurar los �ndices (si es necesario):
Si al particionar se crearon �ndices espec�ficos para las particiones, es posible que tambi�n debas eliminar esos �ndices y crear nuevos �ndices en la tabla no particionada.

-- Eliminar el �ndice de partici�n
DROP INDEX [index_name] ON [table_name];

-- Crear nuevos �ndices si es necesario
CREATE INDEX [index_name] ON [table_name] (column_name);

Resumen:
	Para deshacer una partici�n en SQL Server u otros sistemas de bases de datos:

	*Elimina la funci�n de partici�n y el esquema de partici�n.
	*Reorganiza los datos en una tabla sin particionamiento.
	*Si es necesario, crea �ndices apropiados para la nueva tabla.
	*Como alternativa, si tienes un respaldo, puedes restaurar la tabla a su estado anterior.

*/

---

---6/18: **Operador EXCEPT**

It returns the rows that are in the first result set but not in the second result set.

**Explicaci�n:**  
El operador `EXCEPT` devuelve las filas que est�n en el primer conjunto de resultados pero no en el segundo. Es �til para encontrar diferencias entre dos conjuntos de datos.

SYNTAXIS.
	SELECT column1, column2, ...
	FROM table1
	EXCEPT
	SELECT column1, column2, ...
	FROM table2;


/*
El operador EXCEPT en SQL es particularmente �til cuando necesitas comparar dos conjuntos de datos y obtener solo los registros que existen en el primer conjunto, pero no en el segundo. Aqu� est� la explicaci�n desglosada con un ejemplo:

Ejemplo pr�ctico
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

Si deseas encontrar empleados que est�n en el proyecto 1, pero no en el proyecto 2, puedes usar EXCEPT:

SELECT EmployeeID, Name
FROM employees_in_project1
EXCEPT
SELECT EmployeeID, Name
FROM employees_in_project2;

Resultado
El resultado incluir� solo las filas que est�n en la Tabla A (employees_in_project1), pero no en la Tabla B (employees_in_project2):

EmployeeID	Name
1	John

Notas importantes
Orden y columnas:
Las columnas en ambos conjuntos deben coincidir en:

N�mero de columnas.
Orden.
Tipos de datos.
Sin duplicados:
EXCEPT elimina autom�ticamente los duplicados, como lo har�a un DISTINCT.

Caso especial - Sin resultados:
Si todos los registros del primer conjunto tambi�n est�n en el segundo, el resultado ser� un conjunto vac�o.

En resumen, EXCEPT es excelente para identificar diferencias entre dos conjuntos de datos, como elementos que existen en un grupo, pero no en otro.
*/


---

--- 7/18: **Operador PIVOT**
It converts rows into columns.

/*
El operador PIVOT en SQL es una herramienta muy �til para reorganizar datos de filas a columnas. Sirve principalmente para an�lisis donde necesitas agrupar informaci�n y mostrarla de una forma m�s compacta o intuitiva.
*/
syntax.
	SELECT <column1>, [PivotColumn1], [PivotColumn2], ...
	FROM (
		SELECT <column1>, <column2>, <value_column>
		FROM <table>
	) AS SourceTable
	PIVOT (
		SUM(<value_column>) -- O cualquier funci�n de agregaci�n
		FOR <column2> IN ([PivotColumn1], [PivotColumn2], ...)
	) AS PivotTable;

---**Explicaci�n:**  
--pivot = reorganizar los datos (convirtiendo filas en columnas (o viceversa).)
El operador `PIVOT` transforma datos de filas a columnas. Esto es �til cuando se quiere cambiar la disposici�n de los datos, por ejemplo, para realizar an�lisis cruzados.

Ejemplo pr�ctico

	Tabla original (sales)
	Year	Month	Sales
	2023	January	100
	2023	February	150
	2023	March	200
	2024	January	120
	2024	February	180

Si quieres convertir los meses en columnas para ver las ventas agrupadas por a�o, usas el operador PIVOT:

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
Transformaci�n de datos:
PIVOT siempre necesita una funci�n de agregaci�n (como SUM, AVG, etc.) para calcular valores cuando hay datos duplicados para una combinaci�n de columnas.

Filas a columnas:
Se define qu� columna del conjunto de datos se convertir� en encabezados de columna (en este caso, Month).

Valores faltantes:
Si una fila no tiene datos para una combinaci�n espec�fica (como "March" en 2024), el resultado ser� NULL.

Cu�ndo usar PIVOT
Resumir ventas, ingresos o cualquier m�trica agrupada.
Reorganizar datos para reportes tabulares.
An�lisis cruzados de categor�as (por ejemplo, comparaci�n de productos por regiones).
En resumen, PIVOT es �til para transformar datos de una forma que facilite la visualizaci�n y an�lisis al convertir filas en columnas.
*/
---

### 8/18: **Declarar una variable**
**Respuesta correcta:**
```sql
DECLARE @name VARCHAR(50);
```
**Explicaci�n:**  
En SQL Server, la sintaxis correcta para declarar una variable es `DECLARE @variable_name data_type;`. Espec�ficamente, en este caso, se declara una variable `@name` de tipo `VARCHAR(50)`.

---

### 9/18: **Crear una funci�n que devuelve una tabla**
**Respuesta correcta:**
```sql
CREATE FUNCTION fn_name (@param INT) RETURNS TABLE AS SELECT * FROM table_name WHERE column_name = @param;
```
**Explicaci�n:**  
Las funciones que devuelven una tabla en SQL Server deben usar la palabra clave `RETURNS TABLE` y se define la consulta `SELECT` que devuelve los datos. La sintaxis correcta no debe usar `RETURN` como si fuera una funci�n escalar.

---

### 10/18: **Usar la cl�usula OUTPUT**
**Respuesta correcta:**  
```sql
INSERT INTO table_name OUTPUT inserted.* VALUES (�value1�, �value2�, �);
UPDATE table_name SET column_name = �value� OUTPUT deleted.* WHERE condition;
DELETE FROM table_name OUTPUT deleted.* WHERE condition;
```
**Explicaci�n:**  
La cl�usula `OUTPUT` se utiliza para devolver los valores insertados, actualizados o eliminados. Se puede usar en operaciones `INSERT`, `UPDATE` y `DELETE` para capturar el resultado.

---

### 11/18: **Usar la sentencia MERGE**
**Respuesta correcta:**
```sql
MERGE target_table USING source_table ON join_condition WHEN MATCHED THEN UPDATE SET column_name = value WHEN NOT MATCHED THEN INSERT (column_list) VALUES (value_list);
```
**Explicaci�n:**  
La sentencia `MERGE` se utiliza para combinar datos de una tabla de origen con una tabla de destino seg�n una condici�n de coincidencia. Si los registros coinciden, se actualizan; si no, se insertan nuevos registros.

---

### 12/18: **Usar la funci�n ROW_NUMBER()**
**Respuesta correcta:**
```sql
SELECT ROW_NUMBER() OVER (ORDER BY column_name) AS row_num, column_name FROM table_name;
SELECT ROW_NUMBER() OVER (PARTITION BY column_name ORDER BY column_name) AS row_num, column_name FROM table_name;
SELECT ROW_NUMBER() OVER (ORDER BY column_name DESC) AS row_num, column_name FROM table_name;
```
**Explicaci�n:**  
La funci�n `ROW_NUMBER()` se utiliza para asignar un n�mero de fila �nico a cada fila dentro de un conjunto de resultados. Se puede usar con `ORDER BY` y `PARTITION BY` para controlar c�mo se numeran las filas.

---

### 13/18: **Usar TRY_CONVERT()**
**Respuesta correcta:**
```sql
SELECT TRY_CONVERT(DATE, �2024-01-29�);
SELECT TRY_CONVERT(INT, �123�);
```
**Explicaci�n:**  
La funci�n `TRY_CONVERT()` intenta convertir un valor a un tipo de datos especificado y devuelve `NULL` si la conversi�n falla. Es �til para manejar conversiones que pueden no ser v�lidas.

---

### 14/18: **Ejecutar un procedimiento almacenado**
**Respuesta correcta:**
```sql
EXECUTE procedure_name;
EXEC procedure_name;
```
**Explicaci�n:**  
En SQL Server, se puede ejecutar un procedimiento almacenado usando las palabras clave `EXECUTE` o su forma abreviada `EXEC`.

---

### 15/18: **Pasar par�metros a un procedimiento almacenado**
**Respuesta correcta:**
```sql
By position: EXECUTE procedure_name �value1�, �value2�, �;
By name: EXECUTE procedure_name @param1 = �value1�, @param2 = �value2�, �;
```
**Explicaci�n:**  
Se pueden pasar par�metros a un procedimiento almacenado de dos formas: por posici�n o por nombre. La forma por nombre permite especificar los par�metros de manera m�s clara.

---

### 16/18: **Usar la sentencia RETURN en un procedimiento almacenado**
**Respuesta correcta:**
```
To return a single integer value to the caller.
To exit the stored procedure and return control to the caller.
```
**Explicaci�n:**  
El `RETURN` en un procedimiento almacenado puede usarse para devolver un valor entero o simplemente para salir del procedimiento y devolver el control al llamador.

---

### 17/18: **Usar el tipo de dato JSON**
**Respuesta correcta:**
```sql
SELECT * FROM OPENJSON(�{�books�: [{�title�: �The Catcher in the Rye�, �author�: �J.D. Salinger�}]}�, �$.books�);
SELECT JSON_VALUE(�{�books�: [{�title�: �The Catcher in the Rye�, �author�: �J.D. Salinger�}]}�, �$.books[0].title�);
```
**Explicaci�n:**  
SQL Server permite trabajar con datos JSON utilizando funciones como `OPENJSON` y `JSON_VALUE`. `OPENJSON` descompone el JSON en filas, mientras que `JSON_VALUE` extrae un valor de una cadena JSON.

---

### 18/18: **Uso incorrecto de un cursor**
**Respuesta correcta:**
```sql
DECLARE cursor_name CURSOR FOR SELECT * FROM table_name; OPEN cursor_name; FETCH NEXT FROM cursor_name INTO @variable; WHILE @@FETCH_STATUS = 0 BEGIN -- do something FETCH NEXT FROM cursor_name INTO @variable; END; CLOSE cursor_name; DEALLOCATE cursor_name;
```
**Explicaci�n:**  
Aunque el c�digo es correcto, en este caso, el tipo de cursor especificado en la opci�n incorrecta (si existiera) puede afectar el comportamiento de la consulta. Dependiendo de los valores del cursor, pueden producirse errores si no se manejan correctamente.

---

Espero que estas explicaciones te ayuden a entender el por qu� de las respuestas correctas. Si tienes alguna duda adicional, �no dudes en preguntar!