# Load necessary libraries
library(readr)
library(dplyr)
library(pROC)  # For ROC and AUC

# Load test data
test_data <- read_csv("NL_distances.csv", show_col_types = FALSE)  # 121 rows

# Impute missing values for numeric columns (mean imputation)
test_data <- test_data %>%
  mutate(across(where(is.numeric), ~ ifelse(is.infinite(.), NA, .))) %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))
total_inf <- sum(sapply(test_data, function(x) sum(is.infinite(x))))

# Count the total number of values in the dataset
total_values <- prod(dim(test_data))  # Number of rows * Number of columns

# Calculate the percentage of Inf values
percentage_inf <- (total_inf / total_values) * 100
cat("Percentage of Inf values in the dataset:", percentage_inf, "%\n")

summary(test_data)
# Train logistic regression model
logit_model <- glm(DependeVar ~ Eating + GasStation + Hospital + NSStation + 
                     BusTaxi + RoadNetwor + PowerNetwo + obsvalue,
                   data = test_data,
                   family = "binomial")

# Predict on the test set
test_data$pred_prob <- predict(logit_model, newdata = test_data, type = "response")
test_data$pred_class <- ifelse(test_data$pred_prob >= 0.5, 1, 0)

# Export predictions
write.csv(test_data[, c("ID_unque", "pred_prob", "pred_class")], 
          file = "test_predictions.csv", 
          row.names = FALSE)

# Evaluate model performance
# Accuracy
accuracy <- mean(test_data$pred_class == test_data$DependeVar)
cat("Accuracy:", accuracy, "\n")

# Confusion Matrix
confusion <- table(Predicted = test_data$pred_class, Actual = test_data$DependeVar)
print(confusion)

# Sensitivity and Specificity
TP <- confusion[2, 2]
TN <- confusion[1, 1]
FP <- confusion[2, 1]
FN <- confusion[1, 2]
sensitivity <- TP / (TP + FN)
specificity <- TN / (TN + FP)
cat("Sensitivity:", sensitivity, "\n")
cat("Specificity:", specificity, "\n")

# ROC and AUC
roc_obj <- roc(test_data$DependeVar, test_data$pred_prob)
plot(roc_obj, main = "ROC Curve")
auc_value <- auc(roc_obj)
cat("AUC:", auc_value, "\n")

# Save the full dataset with predictions
write_csv(test_data, "National_predictions.csv")
