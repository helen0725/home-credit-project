# Home Credit Default Risk Project

## Project Overview

This project is based on the Home Credit Default Risk dataset from Kaggle.  
The goal of the project is to build a machine learning model that predicts whether a loan applicant will default.  
This type of model can help financial institutions make better lending decisions and reduce financial losses.

The project includes data preparation, feature engineering, model training, threshold analysis, and model explanation.  
The final model is evaluated using AUC and business metrics to make sure it is useful in real-world situations.

---

## Business Problem

Home Credit wants to approve more customers while controlling the risk of default.  
Approving too many risky customers will cause financial loss, but rejecting too many customers reduces business opportunities.

The business problem is to build a model that predicts default probability so the company can make better loan approval decisions.

---

## Project Objective

The objective of this project is to:

- Predict the probability of default
- Build a model with strong AUC performance
- Choose a decision threshold based on business profit
- Explain model predictions using SHAP values
- Evaluate fairness across different customer groups

The goal is to create a model that is both accurate and useful for business decisions.

---

## Solution Approach

The project followed a standard machine learning workflow:

1. Data cleaning and preparation
2. Aggregating supplementary datasets
3. Feature engineering
4. Model training using XGBoost
5. Model evaluation using cross-validation and Kaggle score
6. Threshold optimization based on profit
7. Model explanation using SHAP
8. Fairness analysis

The final model achieved good performance and stable validation results.

---

## My Contribution

My individual work in this project includes:

- Writing the data preparation pipeline
- Aggregating bureau, previous application, and installment datasets
- Creating features and handling missing values
- Training machine learning models
- Performing threshold analysis
- Generating SHAP explanations
- Writing the model card notebook
- Preparing notebooks for GitHub portfolio

I focused on making the model reproducible, interpretable, and useful for business decisions.

---

## Business Value

This model can help the company:

- Reduce losses from high-risk customers
- Approve more safe customers
- Improve overall lending profit
- Support decision making with data

By selecting the correct decision threshold, the company can balance risk and return instead of using only accuracy or AUC.

---

## Challenges

This project had several challenges:

- Large dataset with many missing values
- Imbalanced target variable
- Complex feature engineering
- SHAP calculation requires correct feature alignment
- Choosing the best threshold depends on business assumptions
- Making sure notebooks run reproducibly

Solving these problems helped improve both technical skills and understanding of real business modeling.

---

## What I Learned

From this project, I learned:

- How to work with real-world financial data
- How to build machine learning models in R
- How to evaluate models using both AUC and business metrics
- How to explain models using SHAP
- How to use GitHub to create a professional portfolio
- How to document analytics work clearly

This project helped me understand how machine learning is used in real business applications.

---

## Files in this Repository

This repository contains my individual work for the Home Credit project.

- data_preparation.R — data cleaning and feature preparation pipeline
- Model card notebook — model documentation and evaluation
- Portfolio notebooks — individual modeling work

All files show my own work and contribution to the project.

---

## Tools Used

- R
- tidymodels
- xgboost
- dplyr
- ggplot2
- shap
- quarto
- GitHub
