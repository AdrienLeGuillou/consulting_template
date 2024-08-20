library(targets)

## Uncomment to finish the pipeline even if some part errors
# tar_option_set(error = NULL)
## Must also comment the `crew` part

library(crew)
tar_option_set(
  controller = crew_controller_local(workers = 4)
)

source("R/_packages.R")  # Load your packages, e.g. library(drake).
source("R/_functions.R") # Define your custom code as a bunch of functions.

list(
  tar_target(
    d_file_path,
    "./data/input/file.xlsx",
    format = "file"
    ),
  tar_target(
    d_data,
    dm_data(d_file_path)
  ),
# Ungrouped descriptions
  tar_target(
   briefing_pats,
    briefr::brf_describe(
      d_data,
      groupings = NULL,
      na.rm = FALSE,
      output_dir = "data/output",
      output_filename = paste0("description.html")
    )
  ),
  tar_target(
    exp_cols,
    c(
      "a_var",
      "another"
    )
  ),
# Grouped descriptions
  tar_target(
    briefings,
    briefr::brf_describe(
      d_data,
      groupings = exp_cols,
      non_grouped = FALSE,
      na.rm = FALSE,
      output_dir = "data/output",
      output_filename = paste0("description__", exp_cols, ".html")
    ),
    pattern = map(exp_cols),
  ),
# Stat tests
  tarchetypes::tar_render_rep(
    md_tests,
    "./Rmd/tests.Rmd",
    params = data.frame(
      exp_var = exp_cols,
      output_file = paste0("tests__", exp_cols, ".html")
    ),
    output_dir = "data/output"
  ),
# render a random Rmd
  # tarchetypes::tar_render(
  #   md_perfs,
  #   "./Rmd/perf.Rmd",
  #   output_dir = "data/output",
  #   output_file = "perf.html"
  # ),
  tar_target(last_line, TRUE)
)
