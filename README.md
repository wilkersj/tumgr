<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/wilkersj/tumgr.svg?branch=master)](https://travis-ci.org/wilkersj/tumgr)

tumgr
=====

tumgr is a tool to obtain tumor growth rates from clinical trial patient data. Output includes individual and summary data for tumor growth rate estimates as well as optional plots of the observed and predicted tumor quantity over time. Tumor growth rates can be used to compare treatment efficacy and help predict overall survival in clinical trial datasets.

Shiny app
=========

View the app [here](https://wilkersj.shinyapps.io/tumgrShiny)

Installation
============

To install the CRAN version:

``` r
install.packages("tumgr")  
```

To install the latest developmental version on GitHub:

``` r
install.packages("devtools")
devtools::install_github("wilkersj/tumgr")
```

Usage
=====

``` r
# load library
library(tumgr)
```

    ## Loading required package: minpack.lm

``` r
# example data  
data(sampleData)
```

``` r
# generate some sample plots
par(mfrow=c(2, 3))
out <- gdrate(sampleData[18:67, ], 0.10, TRUE)
par(mfrow=c(1, 1))
```

![Fig 1](https://github.com/wilkersj/tumgr/blob/master/unnamed-chunk-3-1.png)

``` r
# generate results with plots set to off
out <- gdrate(sampleData, 0.10, FALSE)

# summary of cases
out$models
```

    ##      Group Analyzed                 Type  N Percentage
    ## 1 excluded       no 2 evals not 20% diff  1          1
    ## 2 excluded      yes              not fit  5          7
    ## 3 excluded       no          only 1 eval  5          7
    ## 4 included      yes                   dx 22         32
    ## 5 included      yes                   gd 25         37
    ## 6 included      yes                gdphi  6          9
    ## 7 included      yes                   gx  4          6

``` r
# descriptive statistics
out$sumstats
```

    ##   Parameter  N   Median                  IQR     Mean       SD
    ## 1         g 35 0.001414 (0.000856, 0.003975) 0.003258 0.003956
    ## 2         d 53 0.020427 (0.014466, 0.034447)    0.024 0.015579
    ## 3       phi  6 0.987381 (0.866022, 0.997283) 0.891717 0.180361
