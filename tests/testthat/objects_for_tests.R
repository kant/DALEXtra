library(DALEX)
library(reticulate)

# helper function to skip tests if we don't have the 'shap' module
skip_if_no_conda <- function() {
  tryCatch(conda_binary(),
           error = function(e){
             skip("conda is necessery for tests")
           })
}
skip_if_windows <- function() {
  if (.Platform$OS.type == "windows")
    skip("Test with unix")
}

skip_if_no_mljar <- function() {
  if (!"MLJAR_TOKEN" %in% names(Sys.getenv())) {
    skip("MLJAR_TOKEN entry needed for tests")
  }
}
