# Exercise 13

## (c)

The p-values are:

| X_i1          | X_i2         | X_i3 | X_i4 |
|---------------|--------------|------|------|
| 4.541374e-106 | 6.130779e-25 | 0    | 0    |

These are all very close to zero, which makes sense given that none of the true betas are zero.

The true values of beta are also in their respective 99% confidence intervals, so the estimation looks good.

|      | 0.5%       | 99.5%      |
|------|-----------:|------------:|
| X_i1 | 0.4380938  | 0.5498806   |
| X_i2 | -0.3940948 | -0.2376296  |
| X_i3 | 0.7639381  | 0.8565075   |
| X_i4 | -1.2219501 | -1.1590052  |

I used `-1` in `lm()` because `X_i1` is already our intercept column. R normally creates an intercept automatically, which was why I previously got an extra `NA` coefficient.

## (d)

The results when leaving out `X_i4` are:

|      | p-value      | 0.5%       | 99.5%      |
|------|-------------:|-----------:|------------:|
| X_i1 | 1.624217e-30 | 0.4000493  | 0.62834936  |
| X_i2 | 3.275299e-07 | -0.4770772 | -0.15751697 |
| X_i3 | 4.580482e-02 | -0.1454188 | 0.01841622  |

The estimated coefficient for `X_i3` changes a lot and its confidence interval does not contain the true value 0.8 anymore. Its p-value is also only just below 0.05, compared to practically zero in the full model.

This happens because `X_i3` and `X_i4` are correlated and we omitted `X_i4`. Since beta 4 is negative, some of its effect ends up in the estimate for beta 3.

So small p-values do not necessarily mean that the estimated coefficients are close to the true beta values.

## (e)

| X_i1       | X_i2       | X_i3       | X_i4       |
|------------|------------|------------|------------|
| 0.02168538 | 0.03035246 | 0.01795741 | 0.01221060 |

The manually calculated standard errors are exactly the same as the ones from `summary(model)`. In the old calculation I accidentally took the square root of the estimated error variance too early.

# Exercise 14

## (a)

| Intercept | class     |
|-----------|-----------|
| 0.2707889 | 0.3538265 |

Passengers in first class had a survival probability which was about 0.354 higher than for passengers in second or third class.

This should not be interpreted causally. Class was not randomly assigned and other variables can influence both which class someone was in and whether they survived. For example, the number of women and children might be different between classes.

## (b)

| Intercept  | class      | age        | gender      | age:gender  |
|------------|------------|------------|-------------|-------------|
| 0.61725327 | 0.22360284 | 0.05051424 | -0.18159724 | -0.30688442 |

The coefficient for class is smaller than in (a), so some of the difference was connected to age and gender. This regression is probably better, but I still would not say that it definitely gives a causal effect because there could be more variables we did not account for.

## (c)

The positive coefficient for age does not mean that adults generally had a higher survival probability.

- `gender = 0` means woman, so the age coefficient only compares adult women to female children.
- For men we also have to add the interaction: `0.0505 - 0.3069 = -0.2564`.
- We are also holding class constant in this comparison.

Therefore we cannot look at the age coefficient alone because its meaning depends on gender.

# Exercise 15

## (a)

There are ten observations for every subject, so the observations are not really independent. The graph also shows that the subjects start at quite different reaction times.

I would use:

- `Days` as a fixed effect, since we want to estimate the general effect of more days without enough sleep.
- A random intercept for `Subject`, since every person has a different starting reaction time.

## (b)

The linear model gives approximately:

| Intercept | Days  |
|-----------|-------|
| 251.41    | 10.47 |

So the reaction time increases by about 10.47 ms for each extra day of sleep deprivation.

## (c)

I used the following random intercept model:

```r
lmer(Reaction ~ Days + (1 | Subject), data = sleepstudy)
```

The overall intercept and coefficient for `Days` are almost the same as in the linear model. The model also estimates how much the intercept varies between subjects. The standard deviation of the random intercepts is about 37 ms, so the differences between people are fairly large.

## (d)

- Both models estimate an increase of about 10.47 ms per day.
- The linear model acts as if all 180 measurements were independent.
- The mixed model takes into account that groups of ten measurements belong to the same person.
- It also lets every subject have a different intercept.
- The estimated coefficients are almost identical, but their standard errors change. For `Days` the standard error goes from about 1.24 in the linear model to 0.80 in the mixed model.

I would prefer the mixed model because it fits the way the data was collected better.
