# Exercise 1
## (c)
p-values:
| (Intercept) |    XX_i2    |    XX_i3    |    XX_i4    |
|-------------|-------------|-------------|-------------|
| 4.541374e-106| 6.130779e-25| 0.000000e+00| 0.000000e+00|

these look very good, all close to zero (which makes sense given their betas are all not zero)

Confidence Intervals:
|            | 0.5 %     | 99.5 %    |
|------------|-----------|-----------|
| Intercept  | 0.4380938 | 0.5498806 |
| XX_i1      | NA        | NA        |
| XX_i2      | -0.3940948| -0.2376296|
| XX_i3      | 0.7662640 | 0.8519288 |
| XX_i4      | -1.2180883| -1.1599601|

These also look good. the true values of our beta all are in their respective confidence intervals. It is weird that we included an intercept column since R seems to automatically create one when using lm().
## (d)
| (Intercept) |    X_i2    |    X_i3    |
|-------------|------------|------------|
| 1.818131e-27| 1.591066e-06| 1.452147e-09|

The p-values are still small but noticably larger than for the first regression

|            | 0.5 %     | 99.5 %    |
|------------|-----------|-----------|
| Intercept  | 0.3948024 | 0.6373870 |
| X_i1       | NA        | NA        |
| X_i2       | -0.4865511| -0.1469960|
| X_i3       | 0.1181976 | 0.2927255 |

The true value for beta_3 (0.8) is very far outside this confidence interval. This is because X_i3 is highly correlated (0.5) with X_i4 and when ommiting X_i4 our model will not be able to predict the coefficient of X_i3 correctly. I also think that the confidence interval is too low because beta_4 is negative (-1.2).
