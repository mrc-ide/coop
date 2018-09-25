
<!-- README.md is generated from README.Rmd. Please edit that file -->
<img src="https://github.com/pwinskill/coop/blob/master/coop_logo.jpg" alt="Drawing" align="centre" style="width: 200px; border: 0;"/>

coop
====

Coop is a generalised approach to budget constrained optimisations using simulated annealing. You can use coop to find optimal combinations of scenarios (e.g. intervention mixes across districts) which minimise a target outcome (e.g. malaria cases). Optimal outcomes can be budget constrained at multiple levels (e.g. the solution must comply with global, regional and country budgets).

Installation
------------

You can install coop from github with:

``` r
# install.packages("devtools")
devtools::install_github("pwinskill/coop")
```

Example
-------

### The raw data

The raw data must be provided in a dataframe consisting of three columns: `block`, `cost` and `y`. The `block` column is a grouping variable, grouping solutions that belong to the same place (e.g. all intervention packages for an administrative unit), blocks are therefore the lowest spatial unit in the analysis. The `cost` column provides the cost of that package, and the `y` column the outcome (e.g. cases).

Blocks must be continuously numbered starting from 0. An simple, 4 block example of this data is shown here:

    #>    block cost        y
    #> 1      0  512 4.938348
    #> 2      0  256 5.026522
    #> 3      0  128 7.131918
    #> 4      0 2048 1.230885
    #> 5      0 1024 1.826239
    #> 6      1  256 5.839737
    #> 7      1  512 3.687364
    #> 8      1 1024 3.033178
    #> 9      1  128 5.201323
    #> 10     1 2048 3.112601
    #> 11     2  128 5.090996
    #> 12     2  256 5.291721
    #> 13     2 1024 2.487554
    #> 14     2  512 3.263467
    #> 15     2 2048 1.963562
    #> 16     3  128 7.005446
    #> 17     3  512 3.612986
    #> 18     3 2048 2.559667
    #> 19     3 1024 4.122333
    #> 20     3  256 5.980944

Given the raw data, we go through a preparatory step, whereby the dominated solutions (i.e. solutions where identical or better results can be achieved for lower cost) are removed. This step also formatted the data (order, unique index column), for the following steps.

``` r
formatted_data <- non_dominated(raw_data)
```

The formatted data now looks like:

    #>    id block cost        y
    #> 1   1     0  128 7.131918
    #> 2   2     0  256 5.026522
    #> 3   3     0  512 4.938348
    #> 4   4     0 1024 1.826239
    #> 5   5     0 2048 1.230885
    #> 6   6     1  128 5.201323
    #> 7   7     1  512 3.687364
    #> 8   8     1 1024 3.033178
    #> 9   9     2  128 5.090996
    #> 10 10     2  512 3.263467
    #> 11 11     2 1024 2.487554
    #> 12 12     2 2048 1.963562
    #> 13 13     3  128 7.005446
    #> 14 14     3  256 5.980944
    #> 15 15     3  512 3.612986
    #> 16 16     3 2048 2.559667

Notice that four dominated solutions have been removed, blocks have been ordered by increasing cost and a unique id column has been added.

There are two other inputs that must be specified by the user. The `Budget_groups` and the `Budgets`. The budget groups is a matrix with rows = number of unique block. Each column represents a different grouping level (e.g. global, country). The `Budgets` is a list, with one level for every column in `Budget_groups` detailing the budget.

Let's continue with our simple example, 3 blocks (districts), and a single global budget of 1000 dollars. In this case the `Budget_groups` matrix would be one column, all 0s (all blocks belong to budget group 0). The `Budgets` will be a list of length one:

``` r
budget_groups <- matrix(rep(0, 4), ncol = 1)
budget_groups
#>      [,1]
#> [1,]    0
#> [2,]    0
#> [3,]    0
#> [4,]    0

Budgets <- list(1000)
Budgets
#> [[1]]
#> [1] 1000
```

If we wanted to add country-level budgets (e.g. for two countries, with two districts each) the we add a second column to the matrix, with five 0s and five 1s, to group blocks be country. We add a corresponding level to `Budgets` detailing the country level budgets, which in this case are 800 and 200 dollars:

``` r
budget_groups2 <- matrix(c(rep(0, 4), rep(0:1, each=2)), ncol =2)
budget_groups2
#>      [,1] [,2]
#> [1,]    0    0
#> [2,]    0    0
#> [3,]    0    1
#> [4,]    0    1

Budgets2 <- list(1000, c(800, 200))
Budgets2
#> [[1]]
#> [1] 1000
#> 
#> [[2]]
#> [1] 800 200
```

Given, the `formatted_data`, `Budget_groups` and `Budgets`, we are now ready to optimise:

``` r
simmulated_annealing(input_data = formatted_data, budget_groups = Budget_groups, budget_max = Budgets,
                            inner_iterations = 10, inner_accepted = 5,
                            outer_iterations = 10000, proportion_greedy = 0.15)
```

The extra arguments are detailed in `?simmulated_annealing`. It is advisable to read this in detail. The algorithm is very sensitive to the tuning parameters. Don't expect to find optimal solutions out of the box, be prepared to fine tune the parameters.
