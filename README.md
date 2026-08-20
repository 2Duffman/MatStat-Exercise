# Mathematical Statistics Exercises

This repository contains some exercises from my Mathematical Statistics course at Universität Leipzig (summer semester 2024). I used them to get some more practice with R and statistical models.

## Exercises

- **Exercise 13:** simulation and linear regression, confidence intervals, omitted variables and manual standard errors
- **Exercise 14:** linear probability models using Titanic passenger data and a short discussion of causal interpretation
- **Exercise 15:** comparison of a linear model and a linear mixed model using the `sleepstudy` data

The questions are in `blatt4.pdf`, the R code is in the three exercise scripts and my written results are in `answers.md`.

## Running the code

Install [R](https://cran.r-project.org/) and, optionally, RStudio. Open the repository as your working directory and run this once if packages are missing:

```r
source("install_libraries.R")
```

Then run the exercises separately:

```r
source("exercise13.R")
source("exercise14.R")
source("exercise15.R")
```

Exercise 14 expects `titanic_data.RData` to be in the repository root. Exercise 15 uses the `sleepstudy` dataset included with `lme4`.
