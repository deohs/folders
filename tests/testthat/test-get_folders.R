test_that("get_folders works", {
  conf_file <- tempfile("folders.yml")
  folders <- get_folders(conf_file)
  folders <- lapply(folders, function(x) file.path(tempdir(), x))
  expect_equal(file.exists(conf_file), TRUE)
  folders_default <- list(
    code = 'code',
    conf = 'conf',
    data = 'data',
    doc = 'doc',
    figures = 'figures',
    results = 'results'
  )
  folders_default <- lapply(folders_default, function(x) file.path(tempdir(), x))
  unlink(conf_file)
  expect_equal(folders, folders_default)
})
