# CRIME INTELLIGENCE & ANALYTICS PLATFORM

An end-to-end Crime Intelligence & Analytical Platform developed to transform historical crime records into actionable insights through data analytics, business intelligence, and machine learning.

The platform integrates data preprocessing, SQL-based data management, interactive Power BI dashboards, predictive analytics, and a Flask-based web application into a unified decision-support solution.

---

## Project Overview

The objective of this project is to analyze crime patterns, identify geographical hotspots, monitor crime trends, and forecast future crime occurrences using historical data.

The solution follows a complete analytics workflow:

```
Raw Dataset
     │
     ▼
Data Cleaning (Excel)
     │
     ▼
MySQL Database
     │
     ▼
SQL Analysis
     │
     ▼
Power BI Dashboards
     │
     ▼
Machine Learning Forecasting
     │
     ▼
Flask Web Application
```

---

## Key Features

- Data cleaning and preprocessing using Microsoft Excel
- Structured relational database using MySQL
- SQL-based analytical queries
- Interactive Power BI dashboards
- Karnataka district crime hotspot visualization
- Crime trend analysis
- Machine Learning based future crime forecasting using Linear Regression
- Flask web application for presenting dashboards and predictions
- Clean and modular project architecture

---

## Technology Stack

| Technology | Purpose |
|------------|---------|
| Microsoft Excel | Data Cleaning & Preparation |
| MySQL | Database Management |
| SQL | Data Analysis |
| Power BI | Business Intelligence & Visualization |
| Python | Data Processing |
| Scikit-learn | Machine Learning |
| Flask | Web Application |
| GitHub | Version Control |

---

## Dashboard Overview

### Executive Dashboard

- Crime KPIs
- Year-wise Crime Trend
- Crime Severity Distribution
- Top Crime Categories
- Top Crime Districts

---

### Geographic Analysis

- Karnataka Shape Map
- District-wise Crime Distribution
- Police Unit Analysis
- Crime Hotspot Identification

---

### Predictive Analytics

- Machine Learning Forecast
- Future Crime Prediction (2025–2030)
- Forecast Trend Visualization
- Prediction Summary

---

## Machine Learning

### Model Used

**Linear Regression**

The forecasting model was trained using historical yearly crime data to estimate future crime counts.

### Forecast Period

- 2025
- 2026
- 2027
- 2028
- 2029
- 2030

The generated predictions are visualized within the dashboard and the Flask web application.

---

## Project Structure

```
Crime-Intelligence-Analytics-Platform
│
├── Dashboard/
│   ├── Crime_Intelligence.pbix
│   ├── Dashboard_Page1.png
│   ├── Dashboard_Page2.png
│   └── Dashboard_Page3.png
│
├── Documentation/
│
├── ML/
│   ├── Crime_Forecasting.py
│   ├── crime_forecast_chart.png
│   └── crime_forecast_2025_2030.csv
│
├── SQL/
│   └── Database.sql
│
├── static/
│   ├── css/
│   └── images/
│
├── templates/
│
├── app.py
├── requirements.txt
├── README.md
└── LICENSE
```

---

## Installation

Clone the repository

```bash
git clone https://github.com/JashwanthRamadugu27/Crime-Intelligence-Analytics-Platform.git
```

Navigate to the project

```bash
cd Crime-Intelligence-Analytics-Platform
```

Install dependencies

```bash
pip install -r requirements.txt
```

Run the Flask application

```bash
python app.py
```

Open your browser

```
http://127.0.0.1:5000
```

---

## Dashboard Preview

> ### Executive Dashboard

![Executive Dashboard](Dashboard/Dashboard_Page1.png)

> ### Geographic Dashboard

![Geographic Dashboard](Dashboard/Dashboard_Page2.png)

> ### Machine Learning Dashboard

![Machine Learning Dashboard](Dashboard/Dashboard_Page3.png)

---

## Results

The platform successfully demonstrates a complete analytics pipeline capable of:

- Converting raw crime records into structured information
- Identifying district-wise crime hotspots
- Visualizing crime trends through interactive dashboards
- Forecasting future crime counts using machine learning
- Presenting analytical insights through a web-based interface

---

## Future Enhancements

- Real-time crime data integration
- Advanced forecasting models
- GIS-based spatial analytics
- Automated hotspot detection
- Crime recommendation engine
- Predictive resource allocation

---

## License

This project is licensed under the MIT License.

---

## Author

**Jashwanth Ramadugu**

Data Analytics | Business Intelligence | Machine Learning

GitHub: https://github.com/JashwanthRamadugu27

LinkedIn: https://www.linkedin.com/in/jashwanth-ramadugu-18969931b
