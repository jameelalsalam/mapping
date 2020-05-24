
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mappers

<!-- badges: start -->

[![R build
status](https://github.com/jameelalsalam/mapping/workflows/R-CMD-check/badge.svg)](https://github.com/jameelalsalam/mapping/actions)
<!-- badges: end -->

The goal of mapping is to provide callable key-value tables that can be
manipulated as {vctrs}.

## Installation

``` r
install.packages("jameelalsalam/mapping")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(tibble)
library(mapping)
## basic example code

countries <- c("FR", "GR", "IT")
capitals  <- c("pa", "be", "ro")

# eu_caps <- keyvalue(countries, capitals)
# eu_caps
```

Check status:

``` r
# is_keyvalue(eu_caps)
```

It can go inside a tibble: (although doesn’t show up right in Rstudio
notebook)

``` r
# tibble(
#   kv = eu_caps
# )
```

``` r
# data.frame(
#   kv = eu_caps
# )
```

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub\!
