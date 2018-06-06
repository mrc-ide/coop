#' Prepare data
#'
#' Prepares data for SA
#'
#' @param input_data_raw Raw input data
#'
#' @return Sorted, non-dominated data
prepare <- function(input_data_raw){
  stopifnot(all(c("ISO", "DIDE_CODE", "cost", "y") %in% colnames(input_data_raw)))

  prepped_data <- input_data_raw %>%
    dplyr::arrange(ISO, DIDE_CODE, cost) %>%
    non_dominated()

  return(prepped_data)
}
