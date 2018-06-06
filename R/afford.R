

#' Afford
#'
#' Check a solution is affordable
#'
#' @param solution Proposed solution (vector of indices)
#' @inheritParams sa
#'
#' @return Boolean indicating if proposed solution is affordable or not
#' @export
affordable <- function(solution, cost, ISO, budget, free){
  overbudget <- sum(pmax(0, tapplysum.fast(cost[solution], ISO) - budget))
  overbudget <= free
}

#' Tapply sum fast
#'
#' Optimised group-sum (lifted from ecoreg package)
#'
#' @param x Values to be summed
#' @param groups Groups (numeric)
#'
#' @return Group sums
#' @export
tapplysum.fast <- function(x, groups){
  lastgrp <- !(groups == c(groups[-1], 0))
  cs <- cumsum(x)[lastgrp]
  diff(c(0, cs))
}
