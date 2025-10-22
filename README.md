🧠 Weekly Mortality Forecasting with ARIMA and GARCH Models

Author: Víctor Suesta Arribas
Program: MSc in Data Science, Universitat Autònoma de Barcelona
Course: Time Series Analysis (Practical Assignment 2, 2024/25)

📘 Project Overview

This project applies advanced time series modeling techniques in R to analyze and forecast weekly mortality data from 2010 to 2024.
The analysis is based on official data from INE (Instituto Nacional de Estadística, Spain), with the objective of detecting trend, seasonality, and volatility patterns, as well as assessing the impact of the COVID-19 pandemic on the mortality series.

The workflow follows a complete Data Science pipeline — data preprocessing, exploratory visualization, model fitting, forecasting, and statistical validation.

🧩 Dataset

Source: INE – Weekly Estimated Deaths Dataset

Variable: Number of weekly deaths (by province and gender)

Period: 2010–2024 (first 52 weeks per year)

Frequency: Weekly (52 obs/year)

Encoding: ISO-8859-1; decimal separator “,”

Download link: INEbase – Estimación del número de defunciones semanales

⚙️ Methodology

The analysis proceeds through systematic statistical modeling steps to understand and forecast the weekly mortality trend:

1️⃣ Exploratory Analysis

Filtering data to include 52 weeks per year (2010–2023).

Visualization with global mean and 52-week moving average to identify long-term trends.

Detection of positive linear trend confirmed by regression (β ≈ 3.98, p < 0.01).

2️⃣ Seasonality and COVID Impact

Seasonal decomposition and weekly season plot revealing recurrent annual patterns.

COVID indicator variable (2020–2021) tested via regression → significant positive effect (β ≈ 42.8, p < 0.01).

3️⃣ Stationarity and Differencing

Sequential differencing (first difference + seasonal difference, lag 52) to achieve stationarity.

ADF test confirms stationarity (p < 0.01).

4️⃣ ARIMA Modeling

Candidate model suggested by auto.arima(): ARIMA(0,1,1).

Model captures short-term dependencies and stabilizes non-stationary behavior.

Forecast for 2024 compared with observed data: coherent within confidence intervals.

5️⃣ Residual Diagnostics

Ljung–Box tests on residuals and squared residuals confirm absence of autocorrelation.

Validation of model adequacy before extending to volatility analysis.

6️⃣ GARCH Modeling

Applied GARCH(1,0), GARCH(1,1), and GARCH(2,1) to residuals.

Best model selected: GARCH(1,1) (lowest AIC ≈ 120.5).

Captures conditional heteroskedasticity and residual volatility effectively.

📈 Key Results
Model	Description	AIC	Notes
ARIMA(0,1,1)	Main forecasting model	780.1	Captures trend and short-term correlation
GARCH(1,1)	Residual volatility model	120.5	Best volatility structure (no remaining autocorrelation)

The ARIMA model successfully forecasts short-term mortality evolution.

The GARCH layer captures fluctuations in variance and risk dynamics post-COVID.

The COVID variable shows a temporary but statistically significant impact (2020–2021).

🧮 Data Science Workflow

Data preprocessing: filtering, cleaning, encoding normalization.

EDA: visual inspection, trend/seasonality decomposition.

Feature engineering: creation of COVID indicator variable.

Model fitting: ARIMA and GARCH with diagnostic validation.

Forecasting: one-year-ahead predictions (2024).

Evaluation: model selection via AIC and residual diagnostics.

Reporting: results visualized and interpreted in PDF summary.

🧠 Key Data Science Competencies

Time Series Forecasting (ARIMA, GARCH)

Statistical Inference and Hypothesis Testing

Volatility and Residual Modeling

Feature Engineering (Exogenous Variables)

Model Selection (AIC, Residual Diagnostics)

Data Visualization with ggplot2

Reproducible Analytical Workflows in R

🗂️ Repository Structure
Weekly-Mortality-Forecasting/
│
├── datos.csv                              # Raw dataset (INE mortality data)
├── PracticaAvaluable2-SeriesTemporals.pdf # Official project instructions
├── Entrega2ST1638272.pdf                  # Final project report (PDF)
├── CorrespondenciaNIUvsCCAAvsSEXO.xlsx    # Province/sex correspondence file
├── Code_ARIMA_GARCH.R                     # Main R script
├── LICENSE                                # MIT License
└── README.md                              # Documentation (this file)

🧩 Tools & Libraries

R (v4.x)

forecast – ARIMA modeling and forecasting

tseries – ADF test and time series diagnostics

TSA, lmtest – Statistical testing and residual analysis

fGarch – GARCH volatility models

ggplot2, zoo – Visualization and rolling means

📄 License

Distributed under the MIT License. Free for academic and research use with attribution.

💼 Tags

Data Science · Time Series · ARIMA · GARCH · Forecasting · R Programming · Predictive Analytics · Volatility Modeling · Statistical Modeling
