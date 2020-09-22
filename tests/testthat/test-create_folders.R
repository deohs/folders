test_that("create_folders works", {
  cleanup <- function(folders) {
    sapply(here::here(folders), unlink, recursive = TRUE)
    unlink(here::here('folders.yml'))
  }
  folders <- get_folders()
  cleanup(folders)
  result <- create_folders(folders)
  names(result) <- basename(names(result))
  result_default <- c(
    code = TRUE,
    data = TRUE,
    doc = TRUE,
    figures = TRUE,
    results = TRUE
  )
  cleanup(folders)
  expect_equal(result, result_default)
})
