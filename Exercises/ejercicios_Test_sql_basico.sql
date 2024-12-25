1. Merit Rewards Database

1. Merit Rewards
On the basis of merit, a company decides to promote some of its employee in its HR division at the end of the quarter because of their high performance. Write a query to find the employee IDs along with the names of all its employees who work in the HR department who earned a bonus of 5000 dollars or more in the last quarter.

 

There are two tables in the database: employee_information and last_quarter_bonus. Their primary keys are employee_ID.

 

Schema
There are 2 tables: employee_information, last_quarter_bonus.

employee_information
Name	Type	Description
employee_ID	INTEGER	The employee ID of the employee. This is the primary key.
name	STRING	The name of the employee.
division	STRING	The division in which the employee works.
last_quarter_bonus
Name	Type	Description
employee_ID	INTEGER	The employee ID of the employee. This is the primary key.
bonus	INTEGER	The bonus earned by employee in last quarter (in dollars).
 

Note: Both tables contain data about all employees working in the company.

 

Sample Data Tables
employee_information
employee_ID	name	division
1	Julia	HR
2	Samantha	Tech
3	Richard	HR
last_quarter_bonus
employee_ID	bonus
1	2000
2	5500
3	6240
Sample Output

3 Richard


Explanation

There are two employees working in the HR department, with employee IDs 1 and 3. However, only employee with ID 3 has a bonus greater than equal to 5000, and hence information about only that employee is displayed.
Employee 2, despite having a bonus of more than 5000 is not displayed because he does not belong to the HR department.


/*
Para resolver este problema, puedes utilizar una consulta SQL que realice un **JOIN** entre las tablas `employee_information` y `last_quarter_bonus`. Luego, filtra los resultados para incluir únicamente a los empleados que trabajan en el departamento de HR (`division = 'HR'`) y que han recibido un bono de al menos 5000 dólares (`bonus >= 5000`). 

Aquí está la consulta SQL que puedes usar:

```sql
SELECT 
    ei.employee_ID, 
    ei.name
FROM 
    employee_information ei
JOIN 
    last_quarter_bonus lqb
ON 
    ei.employee_ID = lqb.employee_ID
WHERE 
    ei.division = 'HR' AND 
    lqb.bonus >= 5000;
```

### Explicación:
1. **`JOIN`**:
   - Une las tablas `employee_information` y `last_quarter_bonus` utilizando la clave primaria `employee_ID`, que es común en ambas tablas.
   
2. **`WHERE`**:
   - Filtra los empleados que trabajan en el departamento de HR (`ei.division = 'HR'`).
   - Además, selecciona solo a los empleados cuyo bono sea mayor o igual a 5000 (`lqb.bonus >= 5000`).

3. **Selección de columnas**:
   - Selecciona únicamente los campos `employee_ID` y `name`, como se solicita en el enunciado.

### Salida esperada con los datos de ejemplo:
Para los datos de ejemplo proporcionados, esta consulta retornará:

```
3 Richard
```
*/

2. Country Codes DATABASE
A company wants to contact each of its customers regarding the policy changes. They have international customers, but their database does not include country codes with their phone numbers.

 

There are two tables in the database: customers and country_codes. The first table contains details of every customer including customer_id, name, phone_number, and country. The second table contains the country code for every country.

 

Write a query to retrieve a list of all customer ids, names, and phone numbers, with their country codes concatenated with their phone numbers. Sort the output in the order of their customer_id.

 

Note: The phone number should be in the following format: +COUNTRY_CODE PHONENUMBER (without spaces)

 

Schema
There are 2 tables: customers, country_codes.

customers
Name	Type	Description
customer_id	INTEGER	This is the unique customer id. It is the primary key.
name	STRING	The name of the customers having [1, 20] characters.
phone_number	
STRING


			
The phone number of the customer having [6,13] characters.


			
country	STRING	
			
The country of the customer. It is a foreign key taken from country_codes


			
 

country_codes
Name	Type	Description
country	STRING	The name of the country. It is the primary key.
country_code	STRING	The country code of this country.
Sample Data Tables 
customers
customer_id	name	phone_number	country
1	Raghav	951341341	India
2	Jake	52341351	USA
3	Alice	61341351	USA
 

country_codes
country	country_code
USA	1
India	91
 

Sample Output

1 Raghav +91951341341
2 Jake +152341351
3 Alice +161341351
 

Explanation:

Since Raghav is from India, the country code is 91, so the complete phone number is +91951341341
Since Jake is from the USA, the country code is 1, and the complete phone number is +152341351
Since Alice is from the USA, the country code is 1, and the complete phone number is +161341351

/*
Para resolver este problema, debes realizar un **JOIN** entre las tablas `customers` y `country_codes` para agregar el código de país correspondiente a cada cliente. Luego, debes concatenar el código de país con el número de teléfono en el formato requerido y ordenar los resultados por `customer_id`.

Aquí está la consulta SQL:

```sql
SELECT 
    c.customer_id, 
    c.name, 
    CONCAT('+', cc.country_code, c.phone_number) AS phone_number_with_code
FROM 
    customers c
JOIN 
    country_codes cc
ON 
    c.country = cc.country
ORDER BY 
    c.customer_id;
```

### Explicación:
1. **`JOIN`**:
   - Une las tablas `customers` y `country_codes` utilizando la columna `country` como clave común.
   
2. **`CONCAT`**:
   - Concatena el símbolo `+`, el código de país (`cc.country_code`), y el número de teléfono (`c.phone_number`) en el formato solicitado.

3. **Selección de columnas**:
   - Selecciona `customer_id`, `name`, y el número de teléfono con el código de país concatenado (`phone_number_with_code`).

4. **Orden**:
   - Ordena el resultado por `customer_id` en orden ascendente (`ORDER BY c.customer_id`).

### Salida esperada con los datos de ejemplo:
Para los datos de ejemplo proporcionados, esta consulta retornará:

```
1 Raghav +91951341341
2 Jake +152341351
3 Alice +161341351
```
*/ 

3. 1. Highest Salary
Escribe una consulta para encontrar el segundo salario más alto de la tabla employees. Si no hay un segundo salario, la consulta debería devolver NULL.

segundo salario más alto = MAX(salary) 

Tabla: employees

Column	Type
id	INTEGER
salary	INTEGER

-- Respuesta
SELECT salary 
FROM employees 
WHERE id = 2;
ORDER BY salary ASC

/*
Aquí tienes las respuestas con explicaciones detalladas para cada ejercicio:

1. Highest Salary
Consulta:

sql
Copy code
SELECT 
    MAX(salary) AS second_highest_salary
FROM 
    employees
WHERE 
    salary < (SELECT MAX(salary) FROM employees);
Explicación:

SELECT MAX(salary) obtiene el salario más alto.
La subconsulta (SELECT MAX(salary) FROM employees) encuentra el salario más alto en la tabla.
Filtramos los salarios menores al más alto con WHERE salary <.
Finalmente, usamos MAX(salary) nuevamente para encontrar el segundo salario más alto.
Si no hay un segundo salario, esta consulta devuelve NULL.
*/
-- correccion 
SELECT 
    MAX(salary) AS second_highest_salary
FROM 
    employees
WHERE 
    salary < (SELECT MAX(salary) FROM employees);

	/*
	MAX es una función de agregado:

La función MAX(column) en SQL calcula el valor máximo de una columna específica dentro de las filas seleccionadas.
En este caso, MAX(salary) busca el salario más alto (salary) entre todas las filas de la tabla employees

*/


2. Total Sales by Category
Encuentra la categoría con las mayores ventas totales en la tabla products.

Tablas: products, sales

products:

Column	Type
product_id	INTEGER
category	STRING
sales:

Column	Type
sale_id	INTEGER
product_id	INTEGER
quantity	INTEGER
price	FLOAT
Calcula las ventas totales (quantity * price) para cada categoría.

-- Respuesta
SELECT 


¡Claro! Aquí tienes algunos ejercicios prácticos de SQL para mejorar tus habilidades:

---

### **1. Highest Salary**
Escribe una consulta para encontrar el segundo salario más alto de la tabla `employees`. Si no hay un segundo salario, la consulta debería devolver NULL.

**Tabla: employees**
| Column      | Type    |
|-------------|---------|
| id          | INTEGER |
| salary      | INTEGER |

---

### **2. Total Sales by Category**
Encuentra la categoría con las mayores ventas totales en la tabla `products`.

**Tablas: products, sales**
- `products`:
  | Column       | Type    |
  |--------------|---------|
  | product_id   | INTEGER |
  | category     | STRING  |

- `sales`:
  | Column       | Type    |
  |--------------|---------|
  | sale_id      | INTEGER |
  | product_id   | INTEGER |
  | quantity     | INTEGER |
  | price        | FLOAT   |

Calcula las ventas totales (`quantity * price`) para cada categoría.

---

### **3. Department with Most Employees**
Escribe una consulta para encontrar el departamento que tiene más empleados.

**Tabla: departments**
| Column          | Type    |
|------------------|---------|
| department_id    | INTEGER |
| department_name  | STRING  |

**Tabla: employees**
| Column          | Type    |
|------------------|---------|
| employee_id      | INTEGER |
| department_id    | INTEGER |

---

### **4. Students with High Grades**
Encuentra los estudiantes que tienen una calificación mayor o igual al promedio de todos los estudiantes.

**Tabla: students**
| Column     | Type    |
|------------|---------|
| student_id | INTEGER |
| name       | STRING  |
| grade      | FLOAT   |

---

### **5. Orders Without Customers**
Escribe una consulta para encontrar todos los pedidos que no tienen cliente asignado.

**Tablas: customers, orders**
- `customers`:
  | Column         | Type    |
  |-----------------|---------|
  | customer_id     | INTEGER |
  | name            | STRING  |

- `orders`:
  | Column         | Type    |
  |-----------------|---------|
  | order_id       | INTEGER |
  | customer_id    | INTEGER |

---

¡Intenta resolverlos y avísame si necesitas ayuda! 😊

Aquí tienes las respuestas con explicaciones detalladas para cada ejercicio:

---

### **1. Highest Salary**
**Consulta**:
```sql
SELECT 
    MAX(salary) AS second_highest_salary
FROM 
    employees
WHERE 
    salary < (SELECT MAX(salary) FROM employees);
```

**Explicación**:
1. `SELECT MAX(salary)` obtiene el salario más alto.
2. La subconsulta `(SELECT MAX(salary) FROM employees)` encuentra el salario más alto en la tabla.
3. Filtramos los salarios menores al más alto con `WHERE salary <`.
4. Finalmente, usamos `MAX(salary)` nuevamente para encontrar el segundo salario más alto.

Si no hay un segundo salario, esta consulta devuelve `NULL`.

---

### **2. Total Sales by Category**
**Consulta**:
```sql
SELECT 
    p.category, 
    SUM(s.quantity * s.price) AS total_sales
FROM 
    products p
JOIN 
    sales s
ON 
    p.product_id = s.product_id
GROUP BY 
    p.category
ORDER BY 
    total_sales DESC
LIMIT 1;
```

**Explicación**:
1. `JOIN` entre `products` y `sales` usando `product_id`.
2. Calculamos las ventas totales (`quantity * price`) para cada categoría con `SUM`.
3. Agrupamos por `p.category` con `GROUP BY`.
4. Ordenamos por `total_sales` en orden descendente (`ORDER BY ... DESC`) y usamos `LIMIT 1` para obtener solo la categoría con mayores ventas.

---

### **3. Department with Most Employees**
**Consulta**:
```sql
SELECT 
    d.department_name, 
    COUNT(e.employee_id) AS total_employees
FROM 
    departments d
JOIN 
    employees e
ON 
    d.department_id = e.department_id
GROUP BY 
    d.department_name
ORDER BY 
    total_employees DESC
LIMIT 1;
```

**Explicación**:
1. `JOIN` entre `departments` y `employees` usando `department_id`.
2. Contamos los empleados por departamento con `COUNT(e.employee_id)`.
3. Agrupamos por `d.department_name`.
4. Ordenamos por `total_employees` de forma descendente y usamos `LIMIT 1` para obtener el departamento con más empleados.

---

### **4. Students with High Grades**
**Consulta**:
```sql
SELECT 
    student_id, 
    name, 
    grade
FROM 
    students
WHERE 
    grade >= (SELECT AVG(grade) FROM students);
```

**Explicación**:
1. Calculamos el promedio de calificaciones con `SELECT AVG(grade)`.
2. Filtramos a los estudiantes cuyas calificaciones sean mayores o iguales al promedio.
3. Mostramos `student_id`, `name` y `grade`.

---

### **5. Orders Without Customers**
**Consulta**:
```sql
SELECT 
    o.order_id
FROM 
    orders o
LEFT JOIN 
    customers c
ON 
    o.customer_id = c.customer_id
WHERE 
    c.customer_id IS NULL;
```

**Explicación**:
1. Realizamos un `LEFT JOIN` entre `orders` y `customers`.
2. Esto asegura que todas las órdenes estén incluidas, incluso si no tienen un cliente asignado.
3. Filtramos las órdenes sin cliente con `WHERE c.customer_id IS NULL`.

---

Avísame si necesitas más ejercicios o aclaraciones. 😊

La subconsulta:

```sql
(SELECT MAX(salary) FROM employees)
```

**Encuentra el salario más alto en la tabla `employees` porque:**

1. **`MAX` es una función de agregado**:
   - La función `MAX(column)` en SQL calcula el valor máximo de una columna específica dentro de las filas seleccionadas.
   - En este caso, `MAX(salary)` busca el salario más alto (`salary`) entre todas las filas de la tabla `employees`.

2. **No hay condiciones adicionales**:
   - Si no hay una cláusula `WHERE` que limite las filas, se evalúan todas las filas de la tabla para encontrar el valor máximo.

3. **Es una subconsulta escalar**:
   - Esta subconsulta devuelve un solo valor: el salario más alto. Ese valor puede usarse en la consulta principal para comparaciones o cálculos adicionales.

**Ejemplo práctico:**
Supongamos que la tabla `employees` tiene estos datos:

| id | salary |
|----|--------|
| 1  | 5000   |
| 2  | 7000   |
| 3  | 6000   |

La subconsulta:
```sql
SELECT MAX(salary) FROM employees;
```
Retornará:
```
7000
```
Porque es el valor más alto en la columna `salary`.

---

**Cómo funciona en el contexto del problema**:
En la consulta principal:

```sql
SELECT MAX(salary) 
FROM employees 
WHERE salary < (SELECT MAX(salary) FROM employees);
```
1. La subconsulta `SELECT MAX(salary) FROM employees` encuentra el salario más alto, por ejemplo, 7000.
2. En la consulta principal, usamos `salary < 7000` para buscar los salarios que sean menores a 7000.
3. Luego, aplicamos `MAX(salary)` para encontrar el salario más alto entre los valores restantes, que sería el segundo salario más alto.

¿Te gustaría practicar con más ejemplos? 😊


¡Por supuesto! Aquí tienes una lista de palabras clave y frases comunes en los problemas de SQL, junto con las funciones o conceptos que deberías considerar usar:

---

### **Funciones de Agregación**
1. **"Encontrar el salario más alto"**:  
   - Usa: `MAX(column)`

2. **"Encontrar el salario más bajo"**:  
   - Usa: `MIN(column)`

3. **"Calcular el salario promedio"**:  
   - Usa: `AVG(column)`

4. **"Contar el número de empleados" / "Contar registros"**:  
   - Usa: `COUNT(column)` o `COUNT(*)`

5. **"Suma total de ventas"**:  
   - Usa: `SUM(column)`

---

### **Cláusulas de Filtrado**
6. **"Encontrar empleados en un departamento específico"**:  
   - Usa: `WHERE column = 'value'`

7. **"Filtrar empleados con salario mayor que X"**:  
   - Usa: `WHERE column > value`

8. **"Buscar registros dentro de un rango de valores"**:  
   - Usa: `WHERE column BETWEEN value1 AND value2`

9. **"Buscar registros que contienen cierto texto"**:  
   - Usa: `WHERE column LIKE '%text%'`  
     (Usa `%` como comodín para buscar coincidencias parciales).

10. **"Excluir ciertos valores"**:  
    - Usa: `WHERE column NOT IN (value1, value2)`

---

### **Clasificación y Orden**
11. **"Ordenar los registros por salario en orden ascendente"**:  
    - Usa: `ORDER BY column ASC`

12. **"Ordenar los registros por ventas en orden descendente"**:  
    - Usa: `ORDER BY column DESC`

---

### **Agrupamiento**
13. **"Encontrar el número de empleados por departamento"**:  
    - Usa: `GROUP BY column`

14. **"Calcular la suma total de ventas por región"**:  
    - Usa: `GROUP BY column` junto con `SUM(column)`

15. **"Filtrar resultados agrupados" (como promedios o conteos)**:  
    - Usa: `HAVING` (después de `GROUP BY`)  
      Ejemplo: `HAVING COUNT(*) > 10`

---

### **Uniones entre Tablas**
16. **"Combinar datos de dos tablas"**:  
    - Usa: `JOIN ... ON`  
      Ejemplo: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`

17. **"Encontrar registros que no tienen coincidencias en otra tabla"**:  
    - Usa: `LEFT JOIN` con `WHERE column IS NULL`

---

### **Consultas Anidadas**
18. **"Encontrar el segundo salario más alto"**:  
    - Usa: Subconsulta con `MAX`  
      Ejemplo: `WHERE column < (SELECT MAX(column) FROM table)`

19. **"Comparar un valor con el promedio de la tabla"**:  
    - Usa: Subconsulta con `AVG`  
      Ejemplo: `WHERE column > (SELECT AVG(column) FROM table)`

---

### **Funciones de Texto**
20. **"Concatenar nombre y apellido"**:  
    - Usa: `CONCAT(column1, column2)`

21. **"Convertir texto a mayúsculas/minúsculas"**:  
    - Usa: `UPPER(column)` o `LOWER(column)`

22. **"Extraer parte de un texto"**:  
    - Usa: `SUBSTRING(column, start, length)`

---

### **Otros**
23. **"Eliminar duplicados en los resultados"**:  
    - Usa: `DISTINCT column`

24. **"Limitar el número de registros en el resultado"**:  
    - Usa: `LIMIT N`

25. **"Buscar el registro más reciente o más antiguo"**:  
    - Usa: `ORDER BY column DESC` o `ORDER BY column ASC` junto con `LIMIT 1`

---

Esta lista debería ayudarte a identificar rápidamente qué funciones o conceptos usar al resolver problemas en SQL. ¿Quieres practicar con ejemplos basados en estas palabras clave? 😊