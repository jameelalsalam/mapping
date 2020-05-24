
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
capitals  <- c("Paris", "Berlin", "Rome")

eu_caps <- mapping(countries, capitals)
eu_caps
#> <mapping[3]>
#> [1] Paris  Berlin Rome
```

Display:

Apply the mapping:

``` r
eu_caps(countries)
#> [1] "Paris"  "Berlin" "Rome"
```

The keys, values, and keyvalues can be retrieved, queried, and modified:

In future, it will go inside a tibble:

``` r
# tibble(
#  kv = eu_caps
# )
```

``` r
# data.frame(
#   kv = eu_caps
# )
```

Compose mappings:
