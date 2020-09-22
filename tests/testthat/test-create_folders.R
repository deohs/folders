test_that("create_folders works", {
  folders <- get_folders()
  cleanup_result <- cleanup_folders(folders, keep_conf = FALSE)
  result <- create_folders(folders)
  names(result) <- basename(names(result))
  result_default <- c(
    code = TRUE,
    data = TRUE,
    doc = TRUE,
    figures = TRUE,
    results = TRUE
  )
  cleanup_result <- cleanup_folders(folders, keep_conf = FALSE)
  expect_equal(result, result_default)
})
