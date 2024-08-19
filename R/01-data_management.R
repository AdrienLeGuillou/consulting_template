dm_data <- function(file_path) {
  d <- readxl::read_xlsx(file_path, sheet = "Data", skip = 0)

  names(d) <- alg_make_clean_names(names(d))

  # logicals characters to logicals
  lgcls <- vapply(d, alg_is_char_logical, logical(1))
  d[lgcls] <- lapply(d[lgcls], alg_as_logical_char_logical)

  quali_vals <- c()

  d <- d |> # convert factors
    mutate(across(any_of(quali_vals), as.factor))

  # # removes the ID and the observation column
  # d <- select(d, -length(d), -num)

  # d <- d |>
  #   mutate()

  d
}

