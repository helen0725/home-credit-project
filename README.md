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
