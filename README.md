
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mappers

<!-- badges: start -->

<!-- badges: end -->

The goal of mappers is to provide a {vctrs} compatible key-value type,
coercible with rlang::as\_mapper

## Installation

You can install the released version of mappers from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("mappers")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(tibble)
library(mappers)
## basic example code

countries <- c("FR", "GR", "IT")
capitals  <- c("pa", "be", "ro")

eu_caps <- keyvalue(countries, capitals)
eu_caps
#> <keyvalue[3]>
#> [1] FR->pa GR->be IT->ro
```

Check status:

``` r
is_keyvalue(eu_caps)
#> [1] TRUE
```

It can go inside a tibble:

``` r
tibble(
  kv = eu_caps
)
#> # A tibble: 3 x 1
#>       kv
#>     <kv>
#> 1 FR->pa
#> 2 GR->be
#> 3 IT->ro
```

``` r
data.frame(
  kv = eu_caps
)
#>       kv
#> 1 FR->pa
#> 2 GR->be
#> 3 IT->ro
```

You can also embed plots, for example:

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub\!
