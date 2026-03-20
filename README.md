# Home Credit Default Risk Project

This project focuses on analyzing the Home Credit Default Risk dataset.
The goal is to explore the data and build models to predict loan default risk.
# home-credit-project
## Project Setup

This repository is connected to Posit and GitHub for version control and collaboration.


---

## Data Preparation

This project includes a reusable data preparation script (`data_preparation.R`)
that translates exploratory data analysis (EDA) findings into
production-ready feature engineering and data cleaning steps.

### What the script does

The data preparation script performs the following tasks:

- Fixes known data issues identified during EDA  
  - Replaces the placeholder value `DAYS_EMPLOYED = 365243` with missing values  
  - Converts negative day-based variables (e.g., age, employment duration) into years
- Handles missing values in the `EXT_SOURCE` variables  
  - Computes imputation statistics from the training data only  
  - Adds missing-value indicator features
- Creates engineered features  
  - Demographic features (age, employment duration)  
  - Financial ratios such as credit-to-income and annuity-to-income  
  - Simple binned variables (e.g., age groups)
- Aggregates supplementary datasets to the applicant level (`SK_ID_CURR`)  
  - Credit bureau history  
  - Previous loan applications  
  - Installment payment behavior
- Ensures identical transformations are applied to both training and test data,
  preventing data leakage

### How to use the script

1. Load the raw application and supplementary datasets.
2. Fit missing-value statistics using the training data:
   ```r
   stats <- fit_missing_values(train)
3.Aggregate supplementary datasets:
   ```r
   bureau_agg <- aggregate_bureau(bureau)
   prev_agg   <- aggregate_previous_application(previous_application)
   inst_agg   <- aggregate_installments_payments(installments)
4. Apply the preparation pipeline to both training and test data:
  ```r
   train_prepared <- prepare_application_data(train, stats, bureau_agg, prev_agg, inst_agg)
   test_prepared  <- prepare_application_data(test,  stats, bureau_agg, prev_agg, inst_agg)
```

---


## Model Card
This repository includes a model card documenting the Home Credit Default risk model.
The model card summerizes model design, evaluation metrics, threshold optimization, SHAP explainability, fairness analysis, and limitations for business stakeholders.
The model uses an XGBoost classifer trained on the Home Credit dataset and ealuates decision thresholds based on lending profit and loss assumptions.






# Home Credit Default Risk Project

## Project Overview

This project is based on the Home Credit Default Risk dataset from Kaggle.  
The goal of the project is to build a machine learning model that can predict whether a loan applicant will default.  
This type of model can help financial institutions make better lending decisions and reduce financial losses.

In this project, we used data analysis, feature engineering, and machine learning techniques to build a predictive model.  
The final model was evaluated using AUC and business metrics to make sure it is useful in real-world situations.

---

## Business Problem

Home Credit wants to provide loans to more customers, but they also need to control the risk of default.  
If the company approves too many risky customers, it will lose money.  
If the company rejects too many customers, it will lose business opportunities.

The business problem is to build a model that can predict the probability of default so the company can decide which applications to approve.

---

## Project Objective

The objective of this project is to:

- Predict the probability that a customer will default
- Build a model with good AUC performance
- Choose a decision threshold based on business value
- Explain the model using SHAP values
- Evaluate fairness across different groups

The final goal is not only to get a good score, but also to create a model that can be used in practice.

---

## Solution Approach

The project followed a typical machine learning workflow:

1. Exploratory Data Analysis (EDA)
2. Data cleaning and feature engineering
3. Model training using XGBoost
4. Hyperparameter tuning
5. Model evaluation using cross validation and Kaggle score
6. Threshold analysis based on business profit
7. Model explanation using SHAP
8. Fairness analysis across gender and education

The final model achieved a good AUC score and showed stable performance on validation data.

---

## My Contribution to the Project

In this project, I worked on several important parts of the modeling process.

My contributions include:

- Cleaning the dataset and handling missing values
- Creating new features from the original data
- Training machine learning models using XGBoost
- Running cross-validation to evaluate performance
- Performing threshold analysis to find the best cutoff
- Generating SHAP values to explain model predictions
- Writing the model card notebook
- Creating the final portfolio notebooks for GitHub

I focused on making sure the model is not only accurate, but also interpretable and useful for business decisions.

---

## Business Value of the Model

The model can help the company make better loan approval decisions.

Benefits include:

- Reduce losses from high-risk customers
- Approve more safe customers
- Improve overall profit
- Support decision making with data

By choosing the right threshold, the company can balance risk and profit.  
This shows that machine learning models should be evaluated using business metrics, not only AUC.

---

## Challenges During the Project

There were several challenges in this project.

- The dataset has many missing values
- Some variables have very large ranges
- The classes are imbalanced
- Feature engineering is time consuming
- SHAP calculation requires careful data preparation
- Choosing the best threshold depends on business assumptions

Another challenge was making sure the code runs correctly in notebooks and can be reproduced.

---

## What I Learned

From this project, I learned many useful skills.

- How to work with large real-world datasets
- How to build machine learning models in R
- How to evaluate models using AUC and business metrics
- How to explain models using SHAP values
- How to use GitHub to create a portfolio
- How to write clear notebooks for others to read

This project helped me understand how machine learning is used in real business situations.

---

## Notebooks in this Repository

This repository contains my individual work for the Home Credit project.

Examples of notebooks included:

- Exploratory data analysis
- Feature engineering
- Model training
- Model card notebook
- Threshold analysis
- SHAP explanation
- Fairness analysis

All notebooks are my own work and show my contribution to the project.

---

## Tools Used

- R
- tidymodels
- xgboost
- shap
- ggplot2
- quarto
- GitHub

---


