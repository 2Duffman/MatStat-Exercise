# Load the data
load("titanic_data.RData")

#task a
# Perform linear regression of survived on class
class_model <- lm(survived ~ class)
print(coef(class_model))

#task b
# include age, gender and the interaction between them
adjusted_model <- lm(survived ~ class + age + gender + age:gender)
print(coef(adjusted_model))

#task c
# the age coefficient only gives the difference for women (gender = 0)
# for men we also have to include the interaction
adult_effect_women <- coef(adjusted_model)["age"]
adult_effect_men <- coef(adjusted_model)["age"] +
  coef(adjusted_model)["age:gender"]

print(c(
  adult_effect_women = adult_effect_women,
  adult_effect_men = adult_effect_men
))

# Show the predicted survival probability for all combinations
passenger_groups <- expand.grid(
  class = c(0, 1),
  age = c(0, 1),
  gender = c(0, 1)
)
passenger_groups$predicted_survival <- predict(
  adjusted_model,
  newdata = passenger_groups
)

print(passenger_groups)
