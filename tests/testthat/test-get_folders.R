test_that("get_folders works", {
  conf <- tempfile("folders.yml")
  folders <- get_folders(conf)
  expect_equal(file.exists(conf), TRUE)
  folders_default <- list(
    code = 'code',
    data = 'data',
    doc = 'doc',
    figures = 'figures',
    results = 'results'
  )
  unlink(conf)
  expect_equal(folders, folders_default)
})
