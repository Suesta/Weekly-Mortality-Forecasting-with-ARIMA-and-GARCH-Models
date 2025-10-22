# 🧠 Weekly Mortality Forecasting with ARIMA and GARCH Models

**Author:** Víctor Suesta Arribas
**Program:** MSc in Data Science, Universitat Autònoma de Barcelona
**Course:** Time Series Analysis (Practical Assignment 2, 2024/25)

---

## 📘 Project Overview

This project applies **advanced Data Science and statistical modeling techniques** to analyze and forecast **weekly mortality data** from Spain between 2010 and 2024.
The study uses official data from the **Spanish National Statistics Institute (INE)** and focuses on identifying **trends, seasonal structures, and volatility patterns** in mortality behavior, while also quantifying the **impact of the COVID-19 pandemic**.

The analysis is conducted entirely in **R**, following a complete **data science workflow**: data preprocessing, exploratory visualization, model fitting (ARIMA and GARCH), forecast generation, and diagnostic validation.

---

## 🧩 Dataset

* **Source:** [INE – Weekly Estimated Deaths (Spain)](https://www.ine.es/dyngs/INEbase/es/operacion.htm?c=Estadistica_C&cid=1254736176990&menu=ultiDatos&idp=1254735576863)
* **Variable:** Estimated weekly deaths by province and gender
* **Period:** 2010–2024 (first 52 weeks per year)
* **Frequency:** Weekly (52 observations per year)
* **Encoding:** ISO-8859-1; decimal separator “,”
* **Associated metadata:** `CorrespondenciaNIUvsCCAAvsSEXO (1).xlsx`

---

## ⚙️ Methodology

### 1️⃣ Exploratory and Descriptive Analysis

* Filtered the dataset to retain **52 weeks per year (2010–2023)**.
* Calculated **global mean** and **52-week moving average** to identify trends.
* Detected a **significant upward trend** confirmed by linear regression (β ≈ 3.98, p < 0.01).

### 2️⃣ Seasonality and COVID-19 Effect

* Seasonal decomposition and **weekly season plots** confirmed recurring annual cycles.
* Introduced a **COVID dummy variable** (2020–2021 = 1) → significant positive effect (β ≈ 42.8, p < 0.01).

### 3️⃣ Stationarity and Differencing

* Applied **first differencing** and **seasonal differencing (lag = 52)** to remove trend and stabilize variance.
* Verified **stationarity** using the Augmented Dickey–Fuller (ADF) test (p < 0.01).

### 4️⃣ ARIMA Modeling

* Selected model by `auto.arima()`: **ARIMA(0,1,1)**.
* Captures short-term dependencies and non-stationary patterns efficiently.
* Produced forecasts for 2024, consistent with real data and within confidence intervals.

### 5️⃣ Residual Diagnostics

* Ljung–Box tests on residuals and squared residuals show **no autocorrelation**.
* Confirms model adequacy before modeling volatility.

### 6️⃣ GARCH Modeling

* Fitted **GARCH(1,0)**, **GARCH(1,1)**, and **GARCH(2,1)** to model conditional variance.
* Selected **GARCH(1,1)** based on the lowest AIC (≈120.5).
* The model captures volatility clustering and heteroskedasticity effectively.

---

## 📈 Key Results

| Model        | Description            |  AIC  | Notes                                                  |
| :----------- | :--------------------- | :---: | :----------------------------------------------------- |
| ARIMA(0,1,1) | Main forecasting model | 780.1 | Captures temporal structure and short-term correlation |
| GARCH(1,1)   | Volatility model       | 120.5 | Best representation of conditional variance            |

**Summary of insights:**

* Weekly mortality displays **trend + seasonal patterns** pre-COVID.
* COVID introduced a **structural disruption** (2020–2021).
* The ARIMA–GARCH framework models both **mean dynamics** and **variance volatility** effectively.

---

## 🧮 Data Science Workflow

1. **Data preprocessing** → filtering, cleaning, encoding normalization.
2. **Exploratory analysis** → visualization, trend and seasonal decomposition.
3. **Feature engineering** → creation of COVID indicator variable.
4. **Model fitting** → ARIMA for mean dynamics; GARCH for volatility.
5. **Forecasting** → out-of-sample predictions for 2024.
6. **Evaluation** → AIC selection and residual diagnostics.
7. **Communication** → synthesis of results in the PDF report.

---

## 🧠 Key Data Science Competencies

* Time Series Forecasting (ARIMA, GARCH)
* Statistical Inference and Hypothesis Testing
* Volatility Modeling and Risk Analysis
* Feature Engineering with Exogenous Variables
* Model Selection (AIC, Residual Diagnostics)
* Visualization with ggplot2
* Reproducible Workflows in R

---

## 🗂️ Repository Structure

```
Weekly-Mortality-Forecasting-with-ARIMA-and-GARCH-Models/
│
├── datos.csv                                # INE raw dataset (weekly deaths)
├── CorrespondenciaNIUvsCCAAvsSEXO (1).xlsx  # Province/gender mapping file
├── Entrega2ST1638272.R                      # Full R code (ARIMA & GARCH models)
├── Entrega2ST1638272.pdf                    # Final report (results and discussion)
├── PracticaAvaluable2 - SeriesTemporals (2).pdf # Official assignment statement
├── LICENSE                                  # MIT License
└── README.md                                # Project documentation (this file)
```

---

## 🧩 Tools & Libraries

* **R** (v4.x)
* `forecast` – ARIMA modeling and forecasting
* `tseries` – Stationarity and ADF test
* `TSA`, `lmtest` – Regression and statistical tests
* `fGarch` – GARCH volatility models
* `ggplot2`, `zoo` – Visualization and moving averages

---

## 📄 License

Distributed under the **MIT License**.
Free to use, reproduce, and adapt with attribution.

---

## 💼 Tags

`Data Science` · `Time Series` · `ARIMA` · `GARCH` · `Forecasting` · `R Programming` · `Predictive Analytics` · `Volatility Modeling` · `Statistical Modeling`

