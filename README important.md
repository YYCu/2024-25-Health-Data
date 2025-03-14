# Heart Disease Prediction: Regression Models & Machine Learning Models

## Project Overview
This repository contains data and code for analyzing heart disease risk factors using statistical and machine learning models. The primary focus is on the **2015 dataset**, with additional years (2017, 2019, 2021, and 2023) used for extended research exploring the impact of **COVID-19 on heart disease factors**.

## Data Files
- `2015.zip` to `2023.zip`: Contain health data for different years.
- **Main analysis is based on `2015.zip`**, while later years are used for extended research.

## Main Reports
The core analysis is documented in the following R Markdown files:

### 2015 Data Analysis
- **Baseline & Statistical Model**: [`project 2015 for baseline model and statistical model.Rmd`]
  - Implements **baseline models** and **statistically-based models** as described in the report.
  - Includes **data cleaning** and **preprocessing**.

-  **Literature-Based & Machine Learning Model**: [`project 2015 for literature model and machine learning.Rmd`]
  - Implements **literature-based models** and **machine learning algorithms**.
  - Also includes **data cleaning and preprocessing**.

**Important Note:**  
If you have already executed `project 2015 for baseline model and statistical model.Rmd` and want to run only the **machine learning section** of `project 2015 for literature model and machine learning.Rmd`, **make sure to reset `train_data$y_numeric` before proceeding**:

```{r}
train_data$y_numeric <- NULL
```
