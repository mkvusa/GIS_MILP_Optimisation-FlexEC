# Load required libraries
library(readr)
library(dplyr)
library(pROC)
library(caret)

# Load dataset (282 rows)
train_data <- read_csv("train_data.csv", show_col_types = FALSE)

# Impute missing numeric values
train_data_imputed <- train_data %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))

# Define model formula
formula <- DependeVar ~ Eating + GasStation + Hospital + CarRental +
  NSStation + BusTaxi + RoadNetwor + PowerNetwo + obsvalue

# Set 10-fold CV
set.seed(123)
folds <- createFolds(train_data_imputed$DependeVar, k = 10, list = TRUE)

auc_values <- c()

# Loop through the 10 folds
for (i in 1:10) {
  test_idx <- folds[[i]]
  train_fold <- train_data_imputed[-test_idx, ]
  test_fold  <- train_data_imputed[test_idx, ]
  
  # Fit model on training fold
  model_cv <- glm(formula, data = train_fold, family = "binomial")
  
  # Predict on test fold
  pred_prob <- predict(model_cv, newdata = test_fold, type = "response")
  
  # Compute AUC
  roc_obj <- roc(test_fold$DependeVar, pred_prob)
  auc_values[i] <- auc(roc_obj)
}

# Report average AUC across the 10 folds
cv_auc_mean <- mean(auc_values)
cv_auc_sd   <- sd(auc_values)

cat("10-fold CV AUC (mean):", cv_auc_mean, "\n")
cat("Standard deviation:", cv_auc_sd, "\n")
cat("AUC values per fold:", auc_values, "\n")
