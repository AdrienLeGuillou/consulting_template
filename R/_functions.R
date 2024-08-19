# run all scripts in <here>/R/ matching "R/utils-[^/]*\\.R"
# exemple "R/utils-descriptions.R" but not "R/_functions.R"
utilities <- dir("R", pattern = "utils-[^/]*\\.R")
if (length(utilities) > 0) {
  lapply(
    paste0("R/", utilities),
    source
  )
}

# run all scripts in <here>/R/ matching "R/[0-9]{2}-[^/.]*\\.R"
# exemple "R/01-data_management.R" but not "R/_functions.R"
scripts <- dir("R", pattern = "[0-9]{2}-[^/]*\\.R")
if (length(scripts) > 0) {
  lapply(
    paste0("R/", scripts),
    source
  )
}

