#' Sample x
#'
#' Samples x, return x if length(x) = 1, else a single sample from x
#'
#' @param x A vector
#'
#' @return single sample from the x
#' @export
sample1 <- function(x){
  if(length(x) == 1){
    return(x)
  } else {
    return(sample(x, 1))
  }
}

#' Move up
#'
#' Moves the solution for a single admin unit randomly up
#'
#' @param solution Proposed solution (vector of indices)
#' @inheritParams sa
#'
#' @return Solution with one up move
#' @export
move_up <- function(solution, max_solution){
  i1 <- sample((1:length(solution))[solution != max_solution], 1)
  solution[i1] <- sample1((solution[i1] + 1):max_solution[i1])
  return(solution)
}

#' Move up and down
#'
#' Moves the solution for a single admin unit randomly up and for a different single
#' admin unit randomly down
#'
#' @param solution Proposed solution (vector of indices)
#' @inheritParams sa
#'
#' @return Solution with one up and one down move
#' @export
#'
move_up_down <- function(solution, min_solution, max_solution){
  a <- 1:length(solution)
  i1 <- sample(a[solution != min_solution], 1)
  i2 <- sample(a[solution != max_solution & a != i1], 1)

  solution[i1] <- sample1(min_solution[i1]:(solution[i1] - 1))
  solution[i2] <- sample1((solution[i2] + 1):max_solution[i2])
  return(solution)
}


