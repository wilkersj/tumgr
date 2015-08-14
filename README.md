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

# generate sample plots
par(mfrow=c(2, 3))
out <- gdrate(sampleData[18:67, ], 0.10, TRUE)
```

![](README_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
par(mfrow=c(1, 1))

# generate results with plots set to off
#out <- gdrate(sampleData, 0.10, FALSE)

# summary of cases
out$models
```

    ##      Group Analyzed    Type N Percentage
    ## 1 excluded      yes not fit 1         14
    ## 2 included      yes      dx 1         14
    ## 3 included      yes      gd 4         57
    ## 4 included      yes   gdphi 1         14

``` r
# descriptive statistics
out$sumstats
```

    ##   Parameter N   Median                  IQR     Mean       SD
    ## 1         g 5  0.00119 (0.000493, 0.002723) 0.001852 0.001757
    ## 2         d 6 0.034822 (0.027979, 0.038055)  0.03679 0.022872
    ## 3       phi 1 0.549734 (0.549734, 0.549734) 0.549734     <NA>
