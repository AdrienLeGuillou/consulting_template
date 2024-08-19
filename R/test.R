source("./R/_packages.R")
source("./R/_functions.R")

targets::tar_load("d_data")
d_data

options(browser = "firefox")
d_data |> DT::datatable()
