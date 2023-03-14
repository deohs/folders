#' Cleanup Folders
#'
#' Remove empty folders from the folders list as well as the configuration file.
#' @param folders (list) A named list of standard folders for an R project.
#' @param conf_file (character) Configuration file to read/write. 
#'     See: config::get(). (Default: NULL)
#' @param keep_conf (boolean) Keep the configuration file if TRUE. (Default: TRUE)
#' @param recursive (boolean) Cleanup subfolders recursively if TRUE. (Default: FALSE)
#' @return (integer) A vector of results: 0 for success; 1 for failure; NULL for skipped.
#' @keywords consistency
#' @section Details:
#' Each empty folder in the list of folders will be removed. If recursive is
#' set to TRUE, then empty subfolders will be removed first. The configuration  
#' file will be removed if keep_conf is set to FALSE.
#' @examples
#' conf_file <- tempfile("folders.yml")
#' folders <- get_folders(conf_file)
#' folders <- lapply(folders, function(x) file.path(tempdir(), x))
#' result <- create_folders(folders)
#' result <- cleanup_folders(folders, conf_file)
#' @export
cleanup_folders <- function(folders, conf_file = NULL, 
                            keep_conf = TRUE, recursive = FALSE) {
  result1 <- if (!is.null(conf_file) && keep_conf == FALSE) {
    unlink(conf_file)
  } else {
    NULL
  }
  
  if (recursive) {
    dirs <- sort(list.dirs(unlist(lapply(folders, here::here))), 
                 decreasing = TRUE)
  } else {
    dirs <- here::here(unlist(folders))
  }
  
  result2 <- sapply(dirs, function(x) {
    if (length(dir(x)) == 0) unlink(x, recursive = TRUE) else NULL
  })

  return(c(result2, conf_file = result1))
}
