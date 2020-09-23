#' Accept
#'
#' Accept or reject a new solution at a given temperature
#'
#' @param cur_y Current objective
#' @param new_y Proposed objective
#' @param temp temperature
#'
#' @importFrom stats runif
#'
#' @return Boolean accepting or rejecting proposal
#' @export
accept_reject <- function(cur_y, new_y, temp){
  random_prob <- runif(1)
  (new_y < cur_y || (exp((cur_y - new_y) / temp) > random_prob))
}
