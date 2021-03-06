#' Cleanup Folders
#'
#' Remove empty folders from the folders list as well as the configuration file.
#' @param folders (list) A named list of standard folders for an R project.
#'     (Default: folders::get_folders())
#' @param conf_file (character) Configuration file to read/write.
#'     See: config::get(). (Default: here::here("folders.yml"))
#' @param keep_conf (boolean) Keep the "folders.yml" file if TRUE. (Default: TRUE)
#' @return (integer) A vector of results: 0 for success; 1 for failure; NULL for skipped.
#' @keywords reproducibility, portability, configuration, folders, structure
#' @section Details:
#' Each non-empty folder in the list of folders will be removed. The configuration  
#' file will also be removed if keep_conf is set to FALSE.
#' @examples
#' \dontrun{
#' folders <- get_folders()
#' result <- create_folders(folders)
#' result <- cleanup_folders(folders)
#' }
#' @export
cleanup_folders <- function(folders = folders::get_folders(), 
			    conf_file = here::here('folders.yml'),
			    keep_conf = TRUE) {
  result1 <- sapply(here::here(folders), function(x) {
    if (length(dir(x)) == 0) unlink(x, recursive = TRUE) else NULL
  })

  result2 <- if (keep_conf == FALSE) unlink(conf_file) else NULL

  return(c(result1, conf_file = result2))
}
