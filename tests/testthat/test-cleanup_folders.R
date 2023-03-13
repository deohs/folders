test_that("cleanup_folders works with defaults", {
  conf <- tempfile("folders.yml")
  folders <- get_folders(conf)
  expect_equal(file.exists(conf), TRUE)
  result <- create_folders(folders)
  cleanup_result <- cleanup_folders(folders, conf)
  names(cleanup_result) <- basename(names(cleanup_result))
  cleanup_result_default <- c(
    code = 0,
    data = 0,
    doc = 0,
    figures = 0,
    results = 0
  )
  expect_equal(cleanup_result, cleanup_result_default)
  expect_equal(file.exists(conf), TRUE)
  expect_equal(unlink(conf), 0)
})

test_that("cleanup_folders works with configuration file removal", {
  conf <- tempfile("folders.yml")
  folders <- get_folders(conf)
  folders <- lapply(folders, function(x) file.path(tempdir(), x))
  expect_equal(file.exists(conf), TRUE)
  result <- create_folders(folders)
  cleanup_result <- cleanup_folders(folders, conf, keep_conf = FALSE)
  names(cleanup_result) <- basename(names(cleanup_result))
  cleanup_result_default <- c(
    code = 0,
    data = 0,
    doc = 0,
    figures = 0,
    results = 0,
    conf_file = 0
  )
  expect_equal(cleanup_result, cleanup_result_default)
  expect_equal(file.exists(conf), FALSE)
})

test_that("cleanup_folders works with non-empty folders", {
  conf <- tempfile("folders.yml")
  folders <- get_folders(conf)
  folders <- lapply(folders, function(x) file.path(tempdir(), x))
  result <- create_folders(folders)
  file_path <- file.path(folders$data, 'data.csv')
  write.csv(data.frame(x = 1:3), file_path)
  cleanup_result <- cleanup_folders(folders, conf)
  names(cleanup_result) <- basename(names(cleanup_result))
  cleanup_result_default <- list(
    code = 0,
    data = NULL,
    doc = 0,
    figures = 0,
    results = 0
  )
  expect_equal(cleanup_result, cleanup_result_default)
  expect_equal(file.exists(conf), TRUE)
  expect_equal(file.exists(file_path), TRUE)
  unlink(conf)
  unlink(file_path)
  unlink(file.path(folders$data), recursive = TRUE)
  expect_equal(file.exists(conf), FALSE)
  expect_equal(dir.exists(file.path(folders$data)), FALSE)
  expect_equal(file.exists(file_path), FALSE)
})
