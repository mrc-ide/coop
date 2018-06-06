#' Starting temperature
#'
#' Increases starting temperature until the acceptence rate over 500 iterations is
#' greater than the target acceptance rate
#'
#' @inheritParams sa
#'
#' @return A starting temperature
#' @export
find_starting_temp <- function(target_acceptance,
                               current_solution,  cur_y, max_solution, min_solution,
                               y, cost, ISO, budget, free){

  message("Searching for starting temperature")
  temp <- 1
  repeat{
    accepted <- 0
    for(i in 1:500){
      try_solution <- updown(current_solution, max_solution, min_solution, cost, ISO, budget, free)
      try_y <- sum(y[try_solution])
      if(accept_reject(cur_y, try_y, temp)){
        accepted <- accepted + 1
      }
    }
    if((accepted / 500) > target_acceptance){
      message("Starting temperature set at: ", temp)
      return(temp)
    }
    # Increase temperature
    temp <- temp * 2
    if(temp > 2^20){
      stop("Starting temperature search too hot (2^20) - check inputs")
    }
  }
}

#' @title
#' Estimate the temperature decay
#'
#' @description
#' For a given starting temp and final proportion of greedy moves, calculate the
#' temperature decay such that the temperature is sufficiently low to ensure
#' greddy search for the requested final proportion of the algorithm
#'
#' @param starting_temperature The algorithm starting temperature
#' @param outer_iterations The number of temperature steps
#' @param proportion_greedy The final proportion of the run to be greedy
#'
#' @return The temperature decay
#' @export
decay <- function(starting_temperature, outer_iterations, proportion_greedy){
  exp((log(0.1) - log(starting_temperature)) / (outer_iterations * (1 - proportion_greedy)))
}
