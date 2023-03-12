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
  expect_equal(file.exists(here::here('folders.yml')), TRUE)
  expect_equal(unlink(here::here('folders.yml')), 0)
})

test_that("cleanup_folders works with configuration file removal", {
  folders <- get_folders()
  expect_equal(file.exists(here::here('folders.yml')), TRUE)
  result <- create_folders(folders)
  cleanup_result <- cleanup_folders(folders, keep_conf = FALSE)
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
  expect_equal(file.exists(here::here('folders.yml')), FALSE)
})

test_that("cleanup_folders works with non-empty folders", {
  folders <- get_folders()
  result <- create_folders(folders)
  file_path <- here::here(folders$data, 'data.csv')
  write.csv(data.frame(x = 1:3), file_path)
  cleanup_result <- cleanup_folders(folders)
  names(cleanup_result) <- basename(names(cleanup_result))
  cleanup_result_default <- list(
    code = 0,
    data = NULL,
    doc = 0,
    figures = 0,
    results = 0
  )
  expect_equal(cleanup_result, cleanup_result_default)
  expect_equal(file.exists(here::here('folders.yml')), TRUE)
  expect_equal(file.exists(file_path), TRUE)
  unlink(here::here('folders.yml'))
  unlink(file_path)
  unlink(here::here(folders$data), recursive = TRUE)
  expect_equal(file.exists(here::here('folders.yml')), FALSE)
  expect_equal(dir.exists(here::here(folders$data)), FALSE)
  expect_equal(file.exists(file_path), FALSE)
})
