<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/wilkersj/tumgr.svg?branch=master)](https://travis-ci.org/wilkersj/tumgr)

tumgr
=====

tumgr is a tool to obtain tumor growth rates from clinical trial patient data. Output includes individual and summary data for tumor growth rate estimates as well as optional plots of the observed and predicted tumor quantity over time. Tumor growth rates can be used to compare treatment efficacy and help predict overall survival in clinical trial datasets.

Installation
============

To install the CRAN version:

``` r
install.packages("tumgr")  
```

    ## Installing package into 'C:/Users/Julia/Documents/R/win-library/3.2'
    ## (as 'lib' is unspecified)

    ## package 'tumgr' successfully unpacked and MD5 sums checked
    ## 
    ## The downloaded binary packages are in
    ##  C:\Users\Julia\AppData\Local\Temp\RtmpgxW46a\downloaded_packages

To install the latest developmental version on GitHub:

``` r
#install.packages("devtools")
#devtools::install_github("wilkersj/tumgr")
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
#par(mfrow=c(2, 3))
#out <- gdrate(sampleData, 0.10, TRUE)
#par(mfrow=c(1, 1))

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
    ## 5 included      yes                   gd 26         38
    ## 6 included      yes                gdphi  5          7
    ## 7 included      yes                   gx  4          6

``` r
# descriptive statistics
out$sumstats
```

    ##   Parameter  N   Median                  IQR     Mean       SD
    ## 1         g 35  0.00137 (0.000779, 0.003975) 0.003234  0.00397
    ## 2         d 53 0.020427 (0.014466, 0.034447) 0.024021 0.015576
    ## 3       phi  5 0.982854 (0.827078, 0.999075) 0.871678 0.194039
