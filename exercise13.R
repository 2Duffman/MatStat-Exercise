# Load required library
library(MASS)

# Set the seed for reproducibility
set.seed(42)

# Create X_i,1 with only ones
X_i1 <- rep(1, 3000)

# Create X_i,2 from exponential distribution
X_i2 <- rexp(3000, rate = 2)

# Create X_i,3 and X_i,4 from multivariate normal distribution with mean 0 and variances 1 and 2
# the covariance matrix looks like:
#    1  0.5
#   0.5  2
mu <- c(0, 0)  # mean
Sigma <- matrix(c(1, 0.5, 0.5, 2), nrow = 2)  # covariance matrix
X_i34 <- mvrnorm(3000, mu, Sigma)
colnames(X_i34) <- c("X_i3", "X_i4")

# Combine all covariates into a matrix
X <- cbind(X_i1, X_i2, X_i34)

# Define beta_0
beta_0 <- c(0.5, -0.3, 0.8, -1.2)

# Generate epsilon_i
epsilon_i <- rnorm(3000, mean = 0, sd = sqrt(0.7))

# Create observations Y_i
Y_i <- X %*% beta_0 + epsilon_i # %*% is the matrix multiplication operator

# Perform linear regression
model <- lm(Y_i ~ X)

# Get summary of the model to obtain p-values
model_summary <- summary(model)
p_values <- model_summary$coefficients[, "Pr(>|t|)"]

# Get 99% confidence intervals
conf_intervals <- confint(model, level = 0.99)

# Print p-values and confidence intervals
print(p_values)
print(conf_intervals)

#task d
# Subset X to include only the first three columns
X_subset <- X[, 1:3]

# Perform linear regression
model_subset <- lm(Y_i ~ ., data = as.data.frame(X_subset))

# Get summary of the model to obtain p-values
model_summary_subset <- summary(model_subset)
p_values_subset <- model_summary_subset$coefficients[, "Pr(>|t|)"]

# Get 99% confidence intervals
conf_intervals_subset <- confint(model_subset, level = 0.99)

# Print p-values and confidence intervals
#print(p_values_subset)
#print(conf_intervals_subset)