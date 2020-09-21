
# The basic admin unit
admin <- data.frame(cost = c(1:4, 4.1, 1000), y = c(10:7, 2, 1))

cd <- function(n_countries, admins_per_country){
  countries <- data.frame(budget_block = rep(letters[1:n_countries], each = admins_per_country),
                          stringsAsFactors = FALSE) %>%
    dplyr::mutate(solution_block  = 1:n())

  # All data
  data_list <- list()
  for(i in 1:nrow(countries)){
    td <- admin %>%
      dplyr::mutate(budget_block = countries[i, "budget_block"],
             solution_block = countries[i, "solution_block"])
    data_list[[i]] <- td
  }
  dplyr::bind_rows(data_list)
}

cb <- function(n_countries, admins_per_country){
  data.frame(budget_block = letters[1:n_countries],
             budget = admins_per_country * 4.2,
             stringsAsFactors = FALSE)
}


##### Small dataset
small_data <- cd(4, 4)
small_data_budget <- cb(4, 4)
usethis::use_data(small_data, overwrite = TRUE)
usethis::use_data(small_data_budget, overwrite = TRUE)

##### Large dataset
large_data <- cd(26, 10)
large_data_budget <- cb(26, 10)
dim(large_data)
usethis:::use_data(large_data, overwrite = TRUE)
usethis::use_data(large_data_budget, overwrite = TRUE)
