#' Prepare data
#'
#' Prepares data for SA
#'
#' @param input_data_raw Raw input data
#'
#' @return Sorted, non-dominated data
#' @export
prepare <- function(input_data_raw){
  stopifnot(all(c("ISO", "DIDE_CODE", "cost", "y") %in% colnames(input_data_raw)))

  prepped_data <- input_data_raw %>%
    dplyr::arrange(ISO, DIDE_CODE, cost) %>%
    non_dominated()

  return(prepped_data)
}

#' Prepare data country
#'
#' Prepares data for SA (country-level)
#'
#' @param input_data_raw Raw input data
#'
#' @return Sorted, non-dominated data
#' @export
prepare_country <- function(input_data_raw){
  stopifnot(all(c("ISO", "cost", "y") %in% colnames(input_data_raw)))

  prepped_data <- input_data_raw %>%
    dplyr::arrange(ISO, cost) %>%
    non_dominated_country()

  return(prepped_data)
}
