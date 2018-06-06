#' Propose solution: up
#'
#' Proposes an affordable new (or the same) solution with a single up move
#'
#' @param current_solution Current solution
#'
#' @inheritParams sa
#'
#' @return A solution
#' @export
up <- function(current_solution, max_solution, cost, ISO, budget, free){
  new_solution <- move_up(solution = current_solution, max_solution = max_solution)
  afford <- affordable(new_solution, cost, ISO, budget, free)
  if(identical(new_solution, max_solution)){
    stop("Maximum of all options is affordable: no need to optimise")
  }
  if(afford) {
    current_solution <- new_solution
  }
  return(current_solution)
}

#' Propose solution: up and down
#'
#' Proposes an affordable new (or the same) solution with a single up move
#' and a single down move
#'
#' @param current_solution Current solution
#'
#' @inheritParams sa
#'
#' @return A solution
#' @export
updown <- function(current_solution, max_solution, min_solution, cost, ISO, budget, free){
  new_solution <- move_up_down(current_solution, min_solution, max_solution)
  afford <- affordable(new_solution, cost, ISO, budget, free)
  if(afford) {
    current_solution <- new_solution
  }
  return(current_solution)
}
