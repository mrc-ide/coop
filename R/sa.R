#' Simmulated Annealing
#'
#' SA algorithm
#'
#' @param input_data Data: must contain ISO, DIDE_CODE cost and y columns
#' @param input_budget  Data: must contain ISO and budget column
#' @param outer  Outer (temperature step) iterations
#' @param inner Inner interations
#' @param proportion_greedy Set temperature decay
#' @param frozen Number of attempts with no improvement in final frozen search
#' @param free Free funds
#' @param cl Country level (default is FALSE)
#'
#' @return A list with the solution index and trace
#' @export
sa <- function(input_data, input_budget, outer, inner, proportion_greedy = 0.8, frozen = 5000, free = 0, cl = FALSE){

  # Isolate vectors from dataframe
  cost <- input_data$cost
  y <- input_data$y

  # Estimate min and max solution indices
  min_solution <- mins(input_data, cl)
  max_solution <- maxs(min_solution, nrow(input_data))

  # Extract corresponding ISOs and budgets
  ISO <- input_data$ISO[min_solution]

  budget <- unlist(input_budget[match(unique(ISO), input_budget$ISO), "budget"])
  #budget <- unlist(input_budget[which(input_budget$ISO == unique(ISO)),"budget"])
  # Convert ISO to numeric index for optimisation
  ISO <- as.numeric(factor(ISO))

  if(!affordable(min_solution, cost, ISO, budget, free)){
    stop("Minimum solution not affordable")
  }

  # Set starting solution with up moves
  cur_solution  <- min_solution
  for(i in 1:1000){
    cur_solution <- up(current_solution = cur_solution, max_solution = max_solution,
                       cost = cost, ISO = ISO, budget = budget, free = free)
  }
  cur_y <- sum(y[cur_solution])

  # Estimate starting temperature
  temp <- find_starting_temp(target_acceptance = 0.9,
                             current_solution = cur_solution, cur_y = cur_y,
                             max_solution = max_solution, min_solution = min_solution,
                             y = y, cost = cost, ISO = ISO, budget = budget, free = free)
  # Calculate temperature decay
  temperature_decay <- decay(starting_temperature = temp,
                             outer_iterations = outer,
                             proportion_greedy = proportion_greedy)
  message("Decay set as: ", temperature_decay)

  # Set counters and tracing vectors
  solution_counter <- 1
  outer_steps_counter <- 1
  trace <- rep(NA, inner * outer)

  # Outer (temperature step) loop
  while(outer_steps_counter <= outer){
    progress(outer, outer_steps_counter)
    inner_steps_counter <- 0
    inner_accepted_counter <- 0

    # Inner loop
    while(inner_steps_counter <= inner){

      # Propose
      try_solution <- updown(cur_solution, max_solution, min_solution, cost, ISO, budget, free)
      try_y <- sum(y[try_solution])
      # Accept or Reject
      if(accept_reject(cur_y, try_y, temp)){
        cur_solution <- try_solution
        cur_y <- try_y
        trace[solution_counter] <- cur_y
        solution_counter <- solution_counter + 1
        inner_accepted_counter <- inner_accepted_counter + 1
      }
      inner_steps_counter <- inner_steps_counter + 1
    }
    # Decrease temperature
    temp <- temp * temperature_decay
    outer_steps_counter <- outer_steps_counter + 1
  }

  # Run up move only for final X iterations (These will all be better if data is sorted correctly)
  message("")
  message("Frozen search started")
  repeat{
    cur_solution <- up(cur_solution, max_solution, cost, ISO, budget, free)
    cur_y <- sum(y[cur_solution])
    trace[solution_counter] <- cur_y
    solution_counter <- solution_counter + 1
    m0 <- mean(diff(tail(trace[!is.na(trace)], frozen)) == 0)
    cat("\r", "Frozen search progress = ", round(m0 *100), "%")
    if(all(diff(tail(trace[!is.na(trace)], frozen)) == 0)) break
  }

  trace <- trace[!is.na(trace)]
  return(list(solution = input_data[cur_solution, ], trace = data.frame(x = 1:length(trace), y = trace)))
}

