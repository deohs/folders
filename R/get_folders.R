#' Get Folders
#'
#' Return a named list of standard folder names. Save a config file if missing.
#' @param conf_file (character) Configuration file to read/write.
#'     See: config::get(). (Default: here::here("folders.yml"))
#' @param conf_name (character) Name of configuration to read.
#'     See: config::get(). (Default: Sys.getenv("R_CONFIG_NAME"))
#' @param save_conf (boolean) Whether or not to save new configuration file.
#'     (Default: TRUE)
#' @return (list) The named folders for a standard file structure, will be
#'     returned as a list.
#' @keywords reproducibility, portability, configuration, folders, structure
#' @section Details:
#' The list of folders can be used to create any which are missing or to
#' refer to a folder path by name to avoid hardcoding paths in scripts.
#' You can refer to folders in this way to avoid the use of setwd() in scripts.
#'
#' Ideally the folder paths will be subfolders relative to the parent folder
#' and will be standard names used in several projects for consistency.
#'
#' If there is a configuration file, then it will be read with config::get().
#' Otherwise a built-in default list will be returned. If you want to use a
#' list from a non-default section of the configuration file, set the name of
#' the section with the "conf_name" parameter.
#' @examples
#' \dontrun{
#' folders <- get_folders()
#' folders <- get_folders(conf_name = "custom") # For a custom list from a file.
#' Sys.setenv(R_CONFIG_NAME = "custom")         # Or set this in the environment.
#' folders <- get_folders()
#' }
#' @export
get_folders <- function(conf_file = here::here('folders.yml'),
                        conf_name = Sys.getenv('R_CONFIG_NAME'),
                        save_conf = TRUE) {
  if(file.exists(conf_file)) {
    conf_name <- ifelse(conf_name == '', 'default', conf_name)
    folders <- config::get(config = conf_name, file = conf_file)
  } else {
    folders <- list(
      code = 'code',
      data = 'data',
      doc = 'doc',
      figures = 'figures',
      results = 'results'
    )
    if (save_conf) yaml::write_yaml(list(default = folders), file = conf_file)
  }
  return(folders)
}
