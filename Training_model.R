
library(caret)
library(pROC)
data <- read.csv("DependVar.csv")
set.seed(123)  # For reproducibility
train_indices <- sample(seq_len(nrow(data)), size = 0.7 * nrow(data))
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]
#export test data set
write.csv(test_data, "test_data.csv", row.names = FALSE)
view(test_data)
View(test_data)
#export test data set
write.csv(test_data, "test_data.csv", row.names = FALSE)
# Step 2: Load your dataset
data <- read.csv("test_data.csv")  # Update with your actual file path
data <- read.csv("CS_R.csv")
set.seed(123)  # For reproducibility
train_indices <- sample(seq_len(nrow(data)), size = 0.7 * nrow(data))
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]
#export test data set
write.csv(test_data, "test_data.csv", row.names = FALSE)
write.csv(train_data, "train_data.csv", row.names = FALSE)