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
#' FALSE value for that folder.
#' @examples
#' # Create list of standard folder names and store in a configuration file
#' conf_file <- tempfile("folders.yml")     # Using tempfile() for testing only
#' folders <- get_folders(conf_file)
#' 
#' # Testing only: Append folder names to parent folder path --
#' #               This would NOT be needed or desired in normal usage
#' folders <- lapply(folders, function(x) file.path(tempdir(), x))
#' 
#' # Create a folder for each item in "folders" list
#' result <- create_folders(folders)
#' 
#' # Check results
#' file.exists(conf_file)
#' sapply(folders, dir.exists)
#' 
#' # Create a data file and confirm that it exists
#' df <- data.frame(x = letters[1:3], y = 1:3)
#' file_path <- here::here(folders$data, "data.csv")
#' write.csv(df, file_path, row.names = FALSE)
#' file.exists(file_path)
#' @export
create_folders <- function(folders, showWarnings = FALSE, recursive = TRUE) {
  sapply(here::here(unlist(folders)),
         dir.create,
         showWarnings = showWarnings,
         recursive = recursive)
}
