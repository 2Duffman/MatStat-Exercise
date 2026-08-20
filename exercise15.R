# Load required libraries
library(lme4)
library(lattice)

#task a
#plot the measurements for each subject
graph <- xyplot(
  Reaction ~ Days | Subject,
  sleepstudy,
  type = c("p", "r"),
  xlab = "Days of sleep deprivation",
  ylab = "Average reaction time (ms)",
  aspect = "xy"
)
print(graph)

#task b
#linear model with only the days as covariate
linear_model <- lm(Reaction ~ Days, data = sleepstudy)
print(summary(linear_model))

#task c
#random intercept model
mixed_model <- lmer(Reaction ~ Days + (1 | Subject), data = sleepstudy)
print(summary(mixed_model))

#task d
#compare the coefficients and look at the random intercepts
print(coef(linear_model))
print(fixef(mixed_model))
print(VarCorr(mixed_model))
