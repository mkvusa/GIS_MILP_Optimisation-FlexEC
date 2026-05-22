# Load packages
library(readr)
library(dplyr)

# Load training and test data
#train_data <- read_csv("train_data.csv")  # 282 rows
test_data <- read_csv("nearest_poi_distances.csv", show_col_types = FALSE)    # 121 rows#all my data (Test + train data)
# Impute missing values for numeric columns (mean imputation)
test_data_imputed <- test_data %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))

# Train model
logit_model <- glm(DependeVar ~ Eating + GasStation + Hospital + CarRental + NSStation + BusTaxi + RoadNetwor +	PowerNetwo + obsvalue,
                   data = test_data_imputed,
                   family = "binomial")

# Predict on test set
test_data_imputed$pred_prob <- predict(logit_model, newdata = test_data_imputed, type = "response")
test_data_imputed$pred_class <- ifelse(test_data_imputed$pred_prob >= 0.5, 1, 0)

# Export predictions with ID and probabilities
write.csv(test_data_imputed[, c("ID_unque", "pred_prob", "pred_class")], 
          file = "test_predictions.csv", 
          row.names = FALSE)
View(pred_prob)

# Evaluate
# Accuracy
accuracy <- mean(test_data_imputed$pred_class == test_data_imputed$DependeVar)
cat("Accuracy:", accuracy, "\n")

# Confusion Matrix
confusion <- table(Predicted = test_data_imputed$pred_class, Actual = test_data_imputed$DependeVar)
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
roc_obj <- roc(test_data_imputed$DependeVar, test_data_imputed$pred_prob)
plot(roc_obj, main = "ROC Curve")
auc_value <- auc(roc_obj)
cat("AUC:", auc_value, "\n")

png("roc_curve.png", width = 3000, height = 2400, res = 400)
plot(roc_obj, main = "ROC Curve")
dev.off()

# Save results
#write_csv(test_data_imputed, "test_data_with_predictions.csv")