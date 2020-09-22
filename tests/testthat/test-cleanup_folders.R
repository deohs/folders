test_that("cleanup_folders works", {
  folders <- get_folders()
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
})

