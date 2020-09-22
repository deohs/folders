test_that("get_folders works", {
  folders <- get_folders()
  folders_default <- list(
    code = 'code',
    data = 'data',
    doc = 'doc',
    figures = 'figures',
    results = 'results'
  )
  cleanup_result <- cleanup_folders(folders, keep_conf = FALSE)
  expect_equal(folders, folders_default)
})
