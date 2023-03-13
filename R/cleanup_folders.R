#' Cleanup Folders
#'
#' Remove empty folders from the folders list as well as the configuration file.
#' @param folders (list) A named list of standard folders for an R project.
#'     (Default: folders::get_folders())
#' @param conf_file (character) Configuration file to read/write. 
#'     See: config::get().
#' @param keep_conf (boolean) Keep the configuration file if TRUE. (Default: TRUE)
#' @return (integer) A vector of results: 0 for success; 1 for failure; NULL for skipped.
#' @keywords consistency
#' @section Details:
#' Each non-empty folder in the list of folders will be removed. The configuration  
#' file will also be removed if keep_conf is set to FALSE.
#' @examples
#' conf <- tempfile("folders.yml")
#' folders <- get_folders(conf)
#' folders <- lapply(folders, function(x) file.path(tempdir(), x))
#' result <- create_folders(folders)
#' result <- cleanup_folders(folders, conf)
#' @export
cleanup_folders <- function(folders, conf_file, keep_conf = TRUE) {
  result1 <- sapply(here::here(unlist(folders)), function(x) {
    if (length(dir(x)) == 0) unlink(x, recursive = TRUE) else NULL
  })

  result2 <- if (keep_conf == FALSE) unlink(conf_file) else NULL

  return(c(result1, conf_file = result2))
}
