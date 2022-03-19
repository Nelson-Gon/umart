umart generates umap art
================

<!-- badges: start -->

[![CRAN_Status_Badge](https://r-pkg.org/badges/version/umart)](https://cran.r-project.org/package=umart)
[![CRAN_Release_Badge](https://www.r-pkg.org/badges/version-ago/umart)](https://CRAN.R-project.org/package=umart)
[![Codecov test
coverage](https://codecov.io/gh/Nelson-Gon/umart/branch/main/graph/badge.svg)](https://codecov.io/gh/Nelson-Gon/umart?branch=main)
[![R-CMD-check](https://github.com/Nelson-Gon/umart/actions/workflows/devel-check.yaml/badge.svg)](https://github.com/Nelson-Gon/umart/actions/workflows/devel-check.yaml)
![test-coverage](https://github.com/Nelson-Gon/umart/workflows/test-coverage/badge.svg)
[![Project
Status](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![license](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![GitHub last
commit](https://img.shields.io/github/last-commit/Nelson-Gon/umart.svg)](https://github.com/Nelson-Gon/umart/commits/main)
[![GitHub
issues](https://img.shields.io/github/issues/Nelson-Gon/umart.svg)](https://GitHub.com/Nelson-Gon/umart/issues/)
[![GitHub
issues-closed](https://img.shields.io/github/issues-closed/Nelson-Gon/umart.svg)](https://GitHub.com/Nelson-Gon/umart/issues?q=is%3Aissue+is%3Aclosed)
[![PRs
Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://makeapullrequest.com)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Nelson-Gon/umart/graphs/commit-activity)
<!-- badges: end -->

# Installation

``` r
devtools::install_github("Nelson-Gon/umart")
```

# Load library

``` r
library(umart)
```

    ## Loading required package: ggplot2

# Data Generation

``` r
r_x <- generate_data(mean = 233, sd = 0.0233)
r_y <- generate_data(mean = 520, sd = 0.0520)
df <- data.frame(x = r_x, y=r_y, group = rep(paste0("grp_", 1:5), 10))
```

# Run UMAP

``` r
umap_df <- run_umap(df[, -3],neighbors = 20, seed = 520)
```

# Generate umart

``` r
generate_umart(umap_df, group_col = df$group)
```

![](README_files/figure-gfm/generate_art-1.png)<!-- -->

# Many neighbors

``` r
umaps <- run_umap(df[, -3],neighbors = 2:7, seed = 233520)
groups <- rep(paste0("g_", 1:5), 60)

generate_umart(umaps, group_col = groups, opacity = 0.12) 
```

![](README_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

------------------------------------------------------------------------

Please note that the `umart` project is released with a [Contributor
Code of
Conduct](https://github.com/Nelson-Gon/umart/blob/main/.github/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.

For further exploration, please `browseVignettes("umart")`.

To raise an issue, please do so
[here](https://github.com/Nelson-Gon/umart/issues)

Thank you, feedback is always welcome :)
