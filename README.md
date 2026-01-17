# 📊 End-to-End HR Analytics Pipeline on AWS with Power BI

## 🚀 Project Overview

This project demonstrates an **end-to-end cloud-based data analytics pipeline** that ingests raw HR data, transforms it using AWS serverless services, stores it in an analytics-ready format, and visualizes insights through a **professional Power BI dashboard**.

The goal of this project was to build a scalable, cost-effective, and industry-aligned analytics workflow using modern cloud and BI tools.

---

## 🏗️ Architecture
Raw CSV (S3)

↓

AWS Lambda (ETL)

↓

Cleaned & Partitioned Parquet (S3)

↓

AWS Glue Data Catalog

↓

Amazon Athena (SQL Analytics)

↓

Power BI (Professional Dashboard)


---

## 🛠️ Technologies Used

**Cloud & Data Engineering**
- Amazon S3 (Data Lake - Raw & Processed layers)
- AWS Lambda (Serverless ETL)
- AWS Glue Data Catalog
- Amazon Athena (Serverless SQL Analytics)
- AWS IAM (Access & Security)

**Data & Analytics**
- Python (Pandas, AWS Wrangler)
- Parquet (Columnar storage format)
- SQL (Athena Queries)

**Business Intelligence**
- Microsoft Power BI
- DAX Measures
- Interactive Visualizations & Slicers

---

## 📂 Dataset

The dataset used in this project is:

**IBM HR Employee Attrition Dataset**

Contains attributes such as:
- Department  
- Job Role  
- Monthly Income  
- Years at Company  
- Overtime  
- Performance Rating  
- Attrition (Yes/No)  

---

## ⚙️ Data Pipeline Implementation

### **1️⃣ Data Ingestion (S3)**
- Raw HR CSV uploaded to: s3://bipin-hr-analytics/raw/


### **2️⃣ ETL Processing (AWS Lambda)**
A Python Lambda function:
- Reads CSV from S3
- Cleans and transforms data
- Converts it to **Parquet format**
- Stores it in: s3://bipin-hr-analytics/processed/


### **3️⃣ Data Cataloging (AWS Glue)**
- AWS Glue Crawler creates metadata catalog
- Enables querying via Athena

### **4️⃣ Analytics Layer (Amazon Athena)**
- Partitioned Parquet table created
- SQL used for analytical queries

Example query:
```sql
SELECT department, COUNT(*) AS total_employees
FROM hr_db.employees_clean
GROUP BY department;
```
## 📈 Power BI Dashboard (Professional Design)

A **3-page interactive dashboard** was built in Power BI to provide actionable HR insights and support data-driven decision making.

### **Page 1 — Workforce Overview**
- **Total Employees (KPI)**
- **Attrition Rate (KPI)**
- **Avg Monthly Income (KPI)**
- **Headcount by Department (Bar Chart)**
- **Attrition Distribution (Donut Chart)**
- **Small Attrition Trend Visual**

### **Page 2 — Attrition Insights**
- **Attrition Rate by Job Role**
- **Attrition vs Years at Company (Scatter Plot)**
- **Interactive slicers** for:
  - Department  
  - Job Role  

### **Page 3 — Salary & Performance**
- **Average Salary by Department**
- **Salary vs Performance Rating**
- **Overtime vs Attrition**

---

## 🎯 Business Insights Derived

The dashboard enabled exploration of key HR analytics questions such as:

- Which departments have the **highest attrition rate?**
- Is **overtime correlated with attrition?**
- Does **salary influence employee retention?**
- How does **tenure (years at company) impact attrition?**

These insights help HR teams identify high-risk departments, understand workforce patterns, and design better retention strategies.

---

## 🔮 Future Enhancements (Optional)

Potential improvements to make this project more production-ready:

- **Automate pipeline using AWS EventBridge + Lambda triggers**
- **Add incremental data loading instead of full refresh**
- **Implement Power BI scheduled refresh**
- **Integrate real-time streaming analytics**

---

## 👨‍💻 Author

**Bipin Banala**  
Cloud & Data Analytics Enthusiast  
AWS | Python | SQL | Power BI



