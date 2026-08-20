# Use the personal R library so administrator rights are not needed on Windows
r_version <- paste(
  R.version$major,
  strsplit(R.version$minor, "\\.")[[1]][1],
  sep = "."
)

if (.Platform$OS.type == "windows") {
  # Do not use R_LIBS_USER here because it can still point to an older R version
  user_library <- file.path(
    Sys.getenv("LOCALAPPDATA"),
    "R",
    "win-library",
    r_version
  )
} else {
  user_library <- Sys.getenv("R_LIBS_USER")
}

if (!dir.exists(user_library)) {
  dir.create(user_library, recursive = TRUE)
}

.libPaths(c(user_library, .libPaths()))
message("Using personal library: ", user_library)

# Install Matrix and lme4 into the same library so their versions work together
required_packages <- c("Matrix", "lme4")
packages_in_user_library <- rownames(installed.packages(lib.loc = user_library))
missing_packages <- setdiff(required_packages, packages_in_user_library)

if (length(missing_packages) > 0) {
  install.packages(
    missing_packages,
    lib = user_library,
    repos = "https://cloud.r-project.org"
  )
} else {
  message("All required packages are already installed.")
}
