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
                               current_solution, max_solution, min_solution,
                               cost, ISO, budget, free){

  message("Searching for starting temperature")
  temp <- 1
  repeat{
    accepted <- 0
    for(i in 1:500){
      try_solution <- updown(cur_solution, max_solution, solution, cost, ISO, budget, free)
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
