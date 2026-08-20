# Load required library
library(MASS)

# Set the seed for reproducibility
set.seed(42)

#set dimension of the data
n <- 3000

# Create X_i,1 with only ones
X_i1 <- rep(1, n)

# Create X_i,2 from exponential distribution
X_i2 <- rexp(n, rate = 2)

# Create X_i,3 and X_i,4 from multivariate normal distribution
# the covariance matrix looks like:
#    1       0.7071
#    0.7071  2
mu <- c(0, 0)
correlation <- 0.5
covariance <- correlation * sqrt(1 * 2)
Sigma <- matrix(c(1, covariance, covariance, 2), nrow = 2)
X_i34 <- mvrnorm(n, mu, Sigma)
colnames(X_i34) <- c("X_i3", "X_i4")

# Combine all covariates into a matrix
X <- cbind(X_i1, X_i2, X_i34)

# Define beta_0
beta_0 <- c(0.5, -0.3, 0.8, -1.2)

# Generate epsilon_i
epsilon_i <- rnorm(n, mean = 0, sd = sqrt(0.7))

# Create observations Y_i
Y_i <- X %*% beta_0 + epsilon_i

#task c
# Perform linear regression
# -1 tells lm not to add another intercept since X_i1 is already all ones
model <- lm(Y_i ~ X - 1)
model_summary <- summary(model)
p_values <- model_summary$coefficients[, "Pr(>|t|)"]
conf_intervals <- confint(model, level = 0.99)

print(p_values)
print(conf_intervals)

#task d
# Subset X to include only the first three columns
X_subset <- X[, 1:3]
model_subset <- lm(Y_i ~ X_subset - 1)
model_summary_subset <- summary(model_subset)
p_values_subset <- model_summary_subset$coefficients[, "Pr(>|t|)"]
conf_intervals_subset <- confint(model_subset, level = 0.99)

print(p_values_subset)
print(conf_intervals_subset)

#task e
#Calculate the standard errors of the coefficients
beta_hat <- coef(model)
epsilon_hat <- Y_i - X %*% beta_hat
sigma_epsilon_sq_hat <- sum(epsilon_hat^2) / (n - ncol(X))
sigma_beta_hat <- sigma_epsilon_sq_hat * solve(t(X) %*% X)
std_error <- sqrt(diag(sigma_beta_hat))

print(std_error)

# Compare them to the standard errors from lm()
print(model_summary$coefficients[, "Std. Error"])
