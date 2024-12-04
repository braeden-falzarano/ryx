
# ryx

![](man/figures/cor_image.png)

`ryx` is an R package designed to analyze correlations between a dependent variable (`y`) and multiple independent variables (`x`). It provides convenient methods to print, summarize, and visualize these correlations.

## Installation

You can install the development version of ryx like so:


``` r
devtools::install_github("braeden-falzarano/ryx")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(ryx)
library(MASS)

# Analyze correlations
result <- ryx(Boston, y = "medv")

# Print results
print(result)

# Summarize results
summary(result)

# Plot results
plot(result)
```

## Features
- Correlation Analysis: Automatically identifies numeric variables and computes correlations.
- Custom Print, Summary, and Plot Functions: Simplifies result interpretation.
- Vignette: A comprehensive guide for using the package.

