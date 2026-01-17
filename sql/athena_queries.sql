--------------------------------------------------------------------------------
-- athena_queries.sql
-- End-to-End HR Analytics Pipeline on AWS + Power BI
-- Author: You
--------------------------------------------------------------------------------

-----------------------------
-- 1) USE DATABASE (SCHEMA)
-----------------------------
USE hr_db;

-----------------------------
-- 2) VALIDATE CATALOG
-----------------------------
SHOW TABLES;

-----------------------------
-- 3) PREVIEW PROCESSED DATA
-----------------------------
SELECT *
FROM employees_clean
LIMIT 10;

-----------------------------
-- 4) DATA QUALITY CHECKS
-----------------------------

-- Total record count
SELECT 
  COUNT(*) AS total_records
FROM employees_clean;

-- Null checks on key columns
SELECT 
  SUM(CASE WHEN employeenumber IS NULL THEN 1 ELSE 0 END) AS null_emp_id,
  SUM(CASE WHEN department IS NULL THEN 1 ELSE 0 END) AS null_department,
  SUM(CASE WHEN attrition IS NULL THEN 1 ELSE 0 END) AS null_attrition
FROM employees_clean;

-----------------------------
-- 5) QUERIES USED FOR POWER BI VISUALS
-----------------------------

-- KPI: Total Employees
SELECT 
  COUNT(DISTINCT employeenumber) AS total_employees
FROM employees_clean;

-- Employees by Department (Bar Chart)
SELECT 
  department,
  COUNT(DISTINCT employeenumber) AS total_employees
FROM employees_clean
GROUP BY department
ORDER BY total_employees DESC;

-- Attrition Distribution (Yes vs No)
SELECT 
  attrition,
  COUNT(DISTINCT employeenumber) AS employee_count
FROM employees_clean
GROUP BY attrition;

-- Overall Attrition Rate
SELECT 
  CAST(
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS DOUBLE
  ) / COUNT(*) AS attrition_rate
FROM employees_clean;

-- Attrition Rate by Department
SELECT 
  department,
  CAST(
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS DOUBLE
  ) / COUNT(*) AS attrition_rate
FROM employees_clean
GROUP BY department
ORDER BY attrition_rate DESC;

-- Attrition by Job Role
SELECT 
  jobrole,
  COUNT(*) AS attrition_count
FROM employees_clean
WHERE attrition = 'Yes'
GROUP BY jobrole
ORDER BY attrition_count DESC;

-- Attrition vs Years at Company (for scatter plot)
SELECT 
  yearsatcompany,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM employees_clean
GROUP BY yearsatcompany
ORDER BY yearsatcompany;

-- Average Monthly Income by Department
SELECT 
  department,
  AVG(monthlyincome) AS avg_monthly_income
FROM employees_clean
GROUP BY department
ORDER BY avg_monthly_income DESC;

-- Salary vs Performance Rating
SELECT 
  performancerating,
  AVG(monthlyincome) AS avg_salary
FROM employees_clean
GROUP BY performancerating
ORDER BY performancerating;

-- Overtime vs Attrition
SELECT 
  overtime,
  attrition,
  COUNT(*) AS employee_count
FROM employees_clean
GROUP BY overtime, attrition;

-----------------------------
-- 6) PARTITION-AWARE QUERY (COST OPTIMIZATION)
-----------------------------
SELECT *
FROM employees_clean
WHERE department = 'Sales';

-----------------------------
-- 7) TABLE DEFINITION (REFERENCE)
-----------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS hr_db.employees_clean (
  employeenumber INT,
  department STRING,
  jobrole STRING,
  monthlyincome DOUBLE,
  yearsatcompany INT,
  overtime STRING,
  performancerating INT,
  attrition STRING
)
PARTITIONED BY (department STRING)
STORED AS PARQUET
LOCATION 's3://bipin-hr-analytics/processed/';

--------------------------------------------------------------------------------
-- END OF FILE
--------------------------------------------------------------------------------
