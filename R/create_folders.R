#' Create Folders
#'
#' Create a standardized set of folders under a parent folder of an R project.
#' @param folders (list) A named list of standard folders for an R project.
#' @param showWarnings (boolean) Show warnings. See: base::dir.create().
#'     (Default: FALSE)
#' @param recursive (boolean) Support recursive folder creation. 
#'     See: base::dir.create(). (Default: TRUE)
#' @return (vector) A named vector for the results of "dir.create" operations. 
#' @keywords consistency
#' @section Details:
#' For each folder in the "folders" list, here::here() and base::dir.create() are 
#' used to create a subfolder under the parent folder. Warnings are silenced in 
#' case the folder already exists. Recursive folder creation is supported. These
#' two features can be controlled with the "showWarnings" and "recursive"
#' parameters. A TRUE value in the returned vector means the folder was created 
#' by dir.create(). If a folder already exists, the returned vector will have a 
#' FALSE value for that folder. You can test the existence of the folders with
#' base::dir.exists() as shown in the examples below.
#' @examples
#' conf <- tempfile("folders.yml")
#' folders <- get_folders(conf)
#' folders <- lapply(folders, function(x) file.path(tempdir(), x))
#' result <- create_folders(folders)
#' 
#' dir.exists(conf)
#' sapply(folders, dir.exists)
#' 
#' df <- data.frame(x = letters[1:3], y = 1:3)
#' file_path <- file.path(folders$data, "data.csv")
#' write.csv(df, file_path, row.names = FALSE)
#' file.exists(file_path)
#' @export
create_folders <- function(folders, showWarnings = FALSE, recursive = TRUE) {
  sapply(here::here(unlist(folders)),
         dir.create,
         showWarnings = showWarnings,
         recursive = recursive)
}
