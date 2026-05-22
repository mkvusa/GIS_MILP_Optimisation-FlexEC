# Load necessary libraries
library(readr)
library(dplyr)
library(pROC)
library(car)

# Read dataset
train_data <- read_csv("train_data.csv", show_col_types = FALSE)

# Impute missing values for numeric columns (mean imputation)
train_data_imputed <- train_data %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))

# Train the logistic regression model
logit_model <- glm(DependeVar ~ Eating + GasStation + Hospital + CarRental + NSStation + BusTaxi + RoadNetwor + PowerNetwo + obsvalue,
                   data = train_data_imputed,
                   family = "binomial")
summary(logit_model)

# Get predictions for the imputed data
train_data_imputed$pred_prob <- predict(logit_model, newdata = train_data_imputed, type = "response")

# ROC and AUC calculation
roc_obj_train <- roc(train_data_imputed$DependeVar, train_data_imputed$pred_prob)
auc_train <- auc(roc_obj_train)
cat("Training AUC:", auc_train, "\n")

# Plot ROC curve
#plot(roc_obj_train, main = paste("ROC Curve (AUC =", round(auc_train, 2), ")"), 
     #col = "blue", lwd = 2)

# Save high-resolution PNG ROC
png("ROC.png", width = 3000, height = 2400, res = 470)

#plot(roc_obj_train,
#     main = paste("ROC Curve (AUC =", round(auc_train, 2), ")"),
#     col = "blue",
#     lwd = 2,
#     cex.main =0.1,   # title size
#     cex.lab  = 1.5, # axis label size
#     cex.axis = 1.5  # tick label size
#)
plot(roc_obj_train,
     main = "",
     col = "blue",
     lwd = 2,
     cex.lab  = 1.7,
     cex.axis = 1.7)

dev.off()

######################################
#png("Roc.ng", width = 3000, height = 2400, res = 400)

#plot(roc_obj_train,
     #legacy.axes = TRUE,   # <- important for publication style
     #main = paste("ROC Curve (AUC =", round(auc_train, 2), ")"),
     #col = "blue",
     #lwd = 3)

#dev.off()