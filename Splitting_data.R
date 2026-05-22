# Example dataset

data <- read_csv("nearest_poi_distances.csv", show_col_types = FALSE)
set.seed(123) # For reproducibility
# Define train-test split ratio

train_ratio <- 0.7

# Create indices for the training set (70%)
train_indices <- sample(seq_len(nrow(data)), size = floor(train_ratio * nrow(data)))

# Split the data
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

# View train and test data
print("Training Data:")
print(train_data)

print("Testing Data:")
print(test_data)

# Save as CSV files
write.csv(train_data, "train_data.csv", row.names = FALSE)
write.csv(test_data, "test_data.csv", row.names = FALSE)

print("Train and test datasets saved as 'train_data.csv' and 'test_data.csv'.")