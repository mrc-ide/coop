#' Minimum solution
#'
#' Extracts the index of minimum solutions for each admin
#'
#' @param DIDE_CODE vector of DIDE_CODEs
#' @param cl Country level
#'
#' @return Index of minimum solutions
#' @export
mins <- function(DIDE_CODE, cl = FALSE){
  if(cl){
    x <- c(1, 1 + cumsum(as.vector(table(input_data$ISO))))
    m1 <- x[-length(x)]
  } else {
    m1 <- c(1, which(diff(DIDE_CODE) != 0) + 1)
  }
  return(m1)
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
