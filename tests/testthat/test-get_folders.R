test_that("get_folders works", {
  folders <- get_folders()
  expect_equal(file.exists(here::here('folders.yml')), TRUE)
  folders_default <- list(
    code = 'code',
    data = 'data',
    doc = 'doc',
    figures = 'figures',
    results = 'results'
  )
  unlink(here::here('folders.yml'))
  expect_equal(folders, folders_default)
})
