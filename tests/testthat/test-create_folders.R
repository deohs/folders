test_that("create_folders works", {
  conf_file <- tempfile("folders.yml")
  folders <- get_folders(conf_file)
  folders <- lapply(folders, function(x) file.path(tempdir(), x))
  cleanup_result <- cleanup_folders(folders, conf_file, keep_conf = FALSE)
  result <- create_folders(folders)
  names(result) <- basename(names(result))
  result_default <- c(
    code = TRUE,
    conf = TRUE,
    data = TRUE,
    doc = TRUE,
    figures = TRUE,
    results = TRUE
  )
  cleanup_result <- cleanup_folders(folders, conf_file, keep_conf = FALSE)
  expect_equal(result, result_default)
})
