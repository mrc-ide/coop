
<!-- README.md is generated from README.Rmd. Please edit that file -->

<img src="https://github.com/pwinskill/coop/blob/master/coop_logo.jpg" alt="Drawing" align="centre" style="width: 10px; border: 0;"/>

# coop

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![R build
status](https://github.com/pwinskill/coop/workflows/R-CMD-check/badge.svg)](https://github.com/pwinskill/coop/actions)
[![codecov](https://codecov.io/gh/mrc-ide/nimue/branch/master/graph/badge.svg)](https://codecov.io/gh/pwinskill/coop)
<!-- badges: end -->

Coop is a generalised approach to budget constrained optimisations using
simulated annealing. You can use coop to find optimal combinations of
scenarios (e.g. intervention mixes across districts) which minimise a
target outcome (e.g. malaria cases). Optimal outcomes can be budget
constrained at multiple levels (e.g. the solution must comply with
global, regional and country budgets).

## Installation

You can install coop from github with:

``` r
# install.packages("remotes")
remotes::install_github("pwinskill/coop")
```
