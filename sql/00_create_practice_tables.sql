DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  id         SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name  TEXT,
  dept       TEXT,
  salary     INT
);

INSERT INTO employees(first_name,last_name,dept,salary) VALUES
 ('Ana','Gonzalez','Sales',68000),
 ('Ben','Nguyen','Marketing',72000),
 ('Cara','Ivanova','Tech',98000),
 ('Dave','Okafor','Tech',105000),
 ('Ella','Schmidt','HR',60000);
