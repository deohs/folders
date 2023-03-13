test_that("create_folders works", {
  conf <- tempfile("folders.yml")
  folders <- get_folders(conf_file = conf)
  folders <- lapply(folders, function(x) file.path(tempdir(), x))
  cleanup_result <- cleanup_folders(folders, conf, keep_conf = FALSE)
  result <- create_folders(folders)
  names(result) <- basename(names(result))
  result_default <- c(
    code = TRUE,
    data = TRUE,
    doc = TRUE,
    figures = TRUE,
    results = TRUE
  )
  cleanup_result <- cleanup_folders(folders, conf, keep_conf = FALSE)
  expect_equal(result, result_default)
})
