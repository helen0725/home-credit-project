# ============================================================
# Home Credit Default Risk - Data Preparation
# Author: Yutong He
#
# Purpose:
#   Reusable, production-style data preparation functions
#   for training and test data (no data leakage).
#
# Notes:
#   - Compute medians/bins/thresholds from TRAIN only (fit_* functions)
#   - Apply identical transformations to TRAIN and TEST (apply_* functions)
#   - Do not commit raw data files to GitHub (.gitignore should include *.csv)
# ============================================================

suppressPackageStartupMessages({
  library(tidyverse)
  library(janitor)
})

# -----------------------------
# 1) Fix known anomalies / basic transforms
# -----------------------------
fix_application_anomalies <- function(df) {
  df %>%
    mutate(
      # DAYS_EMPLOYED placeholder: 365243 indicates missing/unknown
      days_employed = if_else(days_employed == 365243, NA_real_, days_employed),

      # Convert negative day features to positive years
      age_years = -days_birth / 365,
      employed_years = -days_employed / 365
    )
}

# -----------------------------
# 2) Missing value handling (fit on TRAIN only)
# -----------------------------
fit_missing_values <- function(train_df) {
  list(
    ext_source_1_median = median(train_df$ext_source_1, na.rm = TRUE),
    ext_source_2_median = median(train_df$ext_source_2, na.rm = TRUE),
    ext_source_3_median = median(train_df$ext_source_3, na.rm = TRUE)
  )
}

apply_missing_values <- function(df, stats) {
  df %>%
    mutate(
      # Missing indicators
      ext_source_1_missing = is.na(ext_source_1),
      ext_source_2_missing = is.na(ext_source_2),
      ext_source_3_missing = is.na(ext_source_3),

      # Median imputation using TRAIN medians
      ext_source_1 = coalesce(ext_source_1, stats$ext_source_1_median),
      ext_source_2 = coalesce(ext_source_2, stats$ext_source_2_median),
      ext_source_3 = coalesce(ext_source_3, stats$ext_source_3_median)
    )
}

# -----------------------------
# 3) Feature engineering (deterministic)
# -----------------------------
engineer_application_features <- function(df) {
  df %>%
    mutate(
      # Financial ratios
      credit_income_ratio  = amt_credit / amt_income_total,
      annuity_income_ratio = amt_annuity / amt_income_total,
      credit_annuity_ratio = amt_credit / amt_annuity,

      # Household scaling
      income_per_person = amt_income_total / cnt_fam_members,

      # Simple binned variable
      age_group = cut(
        age_years,
        breaks = c(18, 30, 40, 50, 65, 100),
        include.lowest = TRUE
      )
    )
}

# -----------------------------
# 4) Supplementary aggregations (applicant level: SK_ID_CURR)
# -----------------------------
aggregate_bureau <- function(bureau_df) {
  bureau_df %>%
    group_by(sk_id_curr) %>%
    summarise(
      bureau_count      = n(),
      bureau_active     = sum(credit_active == "Active", na.rm = TRUE),
      bureau_closed     = sum(credit_active == "Closed", na.rm = TRUE),
      bureau_debt_sum   = sum(amt_credit_sum_debt, na.rm = TRUE),
      bureau_overdue_sum = sum(amt_credit_sum_overdue, na.rm = TRUE),
      .groups = "drop"
    )
}

aggregate_previous_application <- function(prev_df) {
  prev_df %>%
    group_by(sk_id_curr) %>%
    summarise(
      prev_app_count = n(),
      prev_approved_rate = mean(name_contract_status == "Approved", na.rm = TRUE),
      prev_refused_rate  = mean(name_contract_status == "Refused",  na.rm = TRUE),
      .groups = "drop"
    )
}

aggregate_installments_payments <- function(inst_df) {
  inst_df %>%
    mutate(
      days_late = days_entry_payment - days_instalment,
      pay_diff  = amt_payment - amt_instalment
    ) %>%
    group_by(sk_id_curr) %>%
    summarise(
      inst_count        = n(),
      late_payment_rate = mean(days_late > 0, na.rm = TRUE),
      avg_days_late     = mean(days_late, na.rm = TRUE),
      avg_pay_diff      = mean(pay_diff,  na.rm = TRUE),
      .groups = "drop"
    )
}

# -----------------------------
# 5) Full preparation pipeline
# -----------------------------
prepare_application_data <- function(app_df,
                                     stats,
                                     bureau_agg = NULL,
                                     prev_agg   = NULL,
                                     inst_agg   = NULL) {
  out <- app_df %>%
    fix_application_anomalies() %>%
    apply_missing_values(stats) %>%
    engineer_application_features()

  if (!is.null(bureau_agg)) out <- out %>% left_join(bureau_agg, by = "sk_id_curr")
  if (!is.null(prev_agg))   out <- out %>% left_join(prev_agg,   by = "sk_id_curr")
  if (!is.null(inst_agg))   out <- out %>% left_join(inst_agg,   by = "sk_id_curr")

  out
}

# ============================================================
# Example usage (optional): keep commented out for submission
# ============================================================
# data_dir <- "data"
# train <- readr::read_csv(file.path(data_dir, "application_train.csv")) |> janitor::clean_names()
# test  <- readr::read_csv(file.path(data_dir, "application_test.csv"))  |> janitor::clean_names()
#
# bureau <- readr::read_csv(file.path(data_dir, "bureau.csv")) |> janitor::clean_names()
# prev   <- readr::read_csv(file.path(data_dir, "previous_application.csv")) |> janitor::clean_names()
# inst   <- readr::read_csv(file.path(data_dir, "installments_payments.csv")) |> janitor::clean_names()
#
# stats <- fit_missing_values(train)
# bureau_agg <- aggregate_bureau(bureau)
# prev_agg   <- aggregate_previous_application(prev)
# inst_agg   <- aggregate_installments_payments(inst)
#
# train_prepped <- prepare_application_data(train, stats, bureau_agg, prev_agg, inst_agg)
# test_prepped  <- prepare_application_data(test,  stats, bureau_agg, prev_agg, inst_agg)
#
# # Train/Test consistency check (except TARGET):
# stopifnot(setequal(names(train_prepped) %>% setdiff("target"), names(test_prepped)))
