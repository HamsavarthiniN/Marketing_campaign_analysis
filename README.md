# Marketing_campaign_analysis
## Table of Contents
- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Future Enhancements](#future-enhancements)

## Project Overview
This project presents an end-to-end Retail Marketing Analytics solution developed to help a retail company understand customer behavior, evaluate marketing campaign performance, and identify high-value customer segments. Using Python, MySQL, and Power BI, the project transforms raw marketing data into meaningful business insights through data cleaning, SQL-based analytics, and interactive dashboards.

The project answers the key business questions such as:
- Which marketing campaigns performed the best?
- Which customer segments generate the highest spending?
- How can future marketing campaigns be better targeted?
- Which products and sales channels drive the most revenue?

## Objectives
- Clean and preprocess the marketing dataset.
- Perform exploratory data analysis (EDA) to understand customer demographics and purchasing behavior.
- Design a SQL data model and create analytical views.
- Write SQL queries to answer business questions.
- Build an interactive Power BI dashboard for business users.
- Generate actionable insights and recommendations for marketing strategy.
## Tech Stack
- Python for Data Cleaning & EDA
- MySQL	for Database & SQL Analytics
- Power BI for	Interactive Dashboard
## Project Structure
```text
Retail-Marketing-Analytics/
│
├── data/
│   ├── marketing_campaign_data.csv
│   └── marketing_data_dictionary.csv
│
├── notebooks/
│   ├── data_cleaning.ipynb
│   └── EDA_univariate.ipynb
│   └──EDA_multivariate.ipynb
│   └──Rule_based_segmentation.ipynb
│   └──SQL_table_creation.ipynb
│   └──SQL_segmentation.ipynb
│   └──SQL_queries.ipynb
│   └──KPIs_sql.ipynb
│   └──creaating_views.ipynb
│
├── sql/
│   ├── SQL_bussiness_case.sql
│   ├── Segmentation.sql
│   └── KPI.sql
│
├── powerbi/
│   └── Retail_Marketing_Dashboard.pbix
├── README.md
└── requirements.txt
```
## Setup Instructions
1. **Clone the Repository**-git clone https://github.com/HamsavarthiniN/Marketing_campaign_analysis.git
2. **Create a Virtual Environment**- python -m venv myenv
   - *Activate-Windows*-copy path of Activate.ps1 and paste in terminal  
4. **Install Dependencies**- pip install -r requirement.txt
5. **Configure Database**
   - Create a MySQL database:
   - CREATE DATABASE market_analysis;
   - Update database credentials in the project:
   * host="localhost"
   * user="root"
   * password="your_password"
   * database="market_analysis" 
7. **Visualization**
   - Use PowerBI Retail_Marketing_Dashboard.pbix

## Future Enhancements
- Predict campaign acceptance using machine learning.
