#' Minimum solution
#'
#' Extracts the index of minimum solutions for each admin
#'
#' @param DIDE_CODE vector of DIDE_CODEs
#'
#' @return Index of minimum solutions
#' @export
mins <- function(DIDE_CODE){
  c(1, which(diff(DIDE_CODE) != 0) + 1)
}

#' Maximum solution
#'
#' Extracts the index of maximum solutions for each admin
#'
#' @param min_solution Minimum solution
#' @param n number of rows in input data
#'
#' @return Index of maximum solutions
#' @export
maxs <- function(min_solution, n){
  c((min_solution - 1)[-1], n)
}
