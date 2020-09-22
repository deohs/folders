test_that("get_folders works", {
  cleanup <- function(folders) {
    sapply(here::here(folders), unlink, recursive = TRUE)
    unlink(here::here('folders.yml'))
  }
  folders <- get_folders()
  folders_default <- list(
    code = 'code',
    data = 'data',
    doc = 'doc',
    figures = 'figures',
    results = 'results'
  )
  cleanup(folders)
  expect_equal(folders, folders_default)
})
