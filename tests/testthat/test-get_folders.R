test_that("get_folders works", {
  conf <- tempfile("folders.yml")
  folders <- get_folders(conf)
  folders <- lapply(folders, function(x) file.path(tempdir(), x))
  expect_equal(file.exists(conf), TRUE)
  folders_default <- list(
    code = 'code',
    data = 'data',
    doc = 'doc',
    figures = 'figures',
    results = 'results'
  )
  folders_default <- lapply(folders_default, function(x) file.path(tempdir(), x))
  unlink(conf)
  expect_equal(folders, folders_default)
})
