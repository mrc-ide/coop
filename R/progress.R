#' @title
#' Pretty progress bar
#'
#' @description
#' A pretty progress bar to monitor progress.
#'
#' @param outer_iterations The number of temperature steps
#' @param counter The current temperature step
progress <- function(outer_iterations, counter){
  if(counter %% 1000 == 0){
    pattern1 <- c("*~~~", "~*~~", "~~*~", "~~~*", rep("~~~~", 4))
    pattern2 <- c(rep("~~~~", 4), "*~~~", "~*~~", "~~*~", "~~~*")
    pc <- round((counter / outer_iterations) * 100, 0)
    pi <- (pc %% 8) + 1
    cat("\r", pattern1[pi], "Progress = ", pc, "%", pattern2[pi])
  }
}

