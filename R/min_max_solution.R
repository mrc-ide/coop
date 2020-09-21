#' Minimum solution
#'
#' Extracts the index of minimum solutions
#'
#' @param input_data Input data
#' @param cl Country level
#'
#' @return Index of minimum solutions
#' @export
mins <- function(input_data, cl = FALSE){
  m1 <- c(1, which(diff(input_data$solution_block) != 0) + 1)
  return(m1)
}

#' Maximum solution
#'
#' Extracts the index of maximum solutions
#'
#' @param min_solution Minimum solution
#' @param n number of rows in input data
#'
#' @return Index of maximum solutions
#' @export
maxs <- function(min_solution, n){
  c((min_solution - 1)[-1], n)
}
