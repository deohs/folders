---
title: "folders"
output: 
  html_document: 
    keep_md: yes
---

# folders

This R package supports the use of standardized folder names in R projects. The 
idea is to provide some functions to allow you to avoid using hardcoded paths 
and `setwd()` in your R scripts. 

Instead, you can use variables like `folders$data` to refer to folder paths. 
These paths can be standardized between projects. The folders can be created 
for you under the parent folder of your R project. 

Using the defaults, or some other standardized list of folder names, 
all of your projects can have the same general folder structure. This can help 
you write cleaner, more portable, and more reproducible code.

## Default Folders

The package defaults provide "code", "data", "doc", "figures" and 
"results" folders. You can specify alternatives in a YAML configuration file, 
which this package will read and use instead. See "Configuration file" below 
for more details.

You will note there is a "code" folder. If your scripts are in the "code" 
folder, your code will still be able to find the other folders, thanks 
to the *here* package.

## RStudio Projects

This package is intended to be used with RStudio Projects. 

A benefit of using RStudio Projects is, once you open the project in RStudio, 
you will be placed in the parent folder of your project (aka. "project root"). 
All of your work in the project will be relative to that location, especially if 
your project only uses files and subfolders within that parent folder. This the 
most portable way to work. Further, if you are working with a git repository, you 
will most likely want to clone this repository into an RStudio Project. 

## Other Supported Environments

This package will also work outside of RStudio Projects. For example, 
if you are working in a folder tracked by git, then the top level of the git 
repository will be identified as the "project root" folder. This behavior is 
determined by the *here* package.

If you are neither working in an RStudio project, nor in a folder tracked by a 
version control system (git or Subversion), nor an R package development 
folder, then the current working directory at the time the `here` package was 
loaded will be treated as the "project root" folder. 

Or you can force a folder to be the "project root" with a `.here` file. You 
can create one with the `here::set_here()` function. See the *here* package 
documentation for more information. However, if your goal is to write more 
reproducible code and follow best practices, you should really ask yourself why 
you are not using RStudio Projects or version control.

## Installation

You can install the development version from *GitHub* with:


```
# install.packages("devtools")
devtools::install_github("deohs/folders")
```

Or, if you prefer using *pacman*:


```
if (!requireNamespace("pacman", quietly = TRUE)) install.packages('pacman')
pacman::p_load_gh("deohs/folders")
```

## Basic Usage

The following code chunk can be used at the beginning of your scripts to make 
use of standardized folders in your projects.


```
# Load packages, installing as needed
if (!requireNamespace("pacman", quietly = TRUE)) install.packages('pacman')
pacman::p_load(here)
pacman::p_load_gh("deohs/folders")

# Get the list of standard folders and create any folders which are missing
conf <- here::here('folders.yml')
folders <- get_folders(conf)
result <- create_folders(folders)
```

Then, later in your scripts, you can refer to folders like this:


```
dir.exists(here(folders$data))
```

```
## [1] TRUE
```

Or you can add to the standard folder paths like this: 


```
file_path <- here(folders$data, "data.csv")
```

## Basic Usage Scenario

Here is an example of a script which will initialize the folders and then write 
a data file to the `folders$data` folder. You will see that there are no 
hardcoded paths for files or folders and no use of `setwd()`.


```
# Load packages, installing as needed
if (!requireNamespace("pacman", quietly = TRUE)) install.packages('pacman')
pacman::p_load(here)
pacman::p_load_gh("deohs/folders")

# Get the list of standard folders and create any folders which are missing
conf <- here::here('folders.yml')
folders <- get_folders(conf)
result <- create_folders(folders)

# Check to see that the data folder has been created
dir.exists(here(folders$data))
```

```
## [1] TRUE
```

```
# Create a dataset to use for writing a CSV file to the data folder
df <- data.frame(x = letters[1:3], y = 1:3)

# Confirm that the CSV file does not yet exist
file_path <- here(folders$data, "data.csv")
file.exists(file_path)
```

```
## [1] FALSE
```

```
# Write the CSV file
write.csv(df, file_path, row.names = FALSE)

# Verify that the file was written
file.exists(file_path)
```

```
## [1] TRUE
```

```
# Cleanup unused (empty) folders (Optional, as you may prefer to keep them)
result <- cleanup_folders(folders, conf)

# Verify that the data folder and CSV file still exist after cleanup
file.exists(file_path)
```

```
## [1] TRUE
```

```
# Verify that the configuration file still exists after cleanup
file.exists(conf)
```

```
## [1] TRUE
```

## Working with subfolders

You can refer to subfolders relative to the paths in your `folders` list using
`here()`. For example, if you had a folder called "raw" under your data folder, 
just refer to that folder with `here(folders$data, "raw")`:


```
conf <- here::here('folders.yml')
folders <- get_folders(conf)
raw_df <- here(folders$data, "raw", "file.csv")
```

If you want to create a subfolder hierarchy under all of your main folders, 
you can use `lapply()` or `purrr::map()` to create that hierarchy. For example,
we can create a "phase" folder under each folder in `folders` and then a "01" 
folder under each "phase" folder:


```
conf <- here::here('folders.yml')
folders <- lapply(get_folders(conf), here, "phase", "01")
res <- create_folders(folders) 
```

You can place that near the top of each of your scripts, adjusting for the 
project phase the script is used for, then you can then use `folders$data` to 
refer to a path like `data/phase/01` within the parent folder. This way, your 
scripts can always refer to the appropriate data, results, etc., folder for 
that project phase using the same variables, e.g., `folders$data`, 
`folders$results`, etc.


```
df <- read.csv(here(folders$data, "data.csv"))
```

## Configuration file

The configuration file, if not already present, will be written by `get_folders()` 
to a YAML file called `folders.yml`, stored in the parent folder of your R 
project. This file will be read by `config::get()` on subsequent executions of 
`get_folders()`. This behavior can be modified by function parameters.

The default configuration file looks like:

```
default:
  code: code
  data: data
  doc: doc
  figures: figures
  results: results
```

Once this file has been created, you can edit it to modify the default 
folder paths. However, we advise you to stick to the defaults to maintain 
maximum consistency between your projects. If you do wish to edit it, you can
do so with any text editor or with R as shown below.


```
# Load packages, installing as needed
if (!requireNamespace("pacman", quietly = TRUE)) install.packages('pacman')
pacman::p_load(here, yaml)
pacman::p_load_gh("deohs/folders")

# Get the list of standard folders, creating the configuration file if missing
conf <- here::here('folders.yml')
folders <- get_folders(conf)

# Replace a default with a custom folder path
folders$data <- "data_folder"

# Edit the default configuration file to save the modification
write_yaml(list(default = folders), file = conf)
```

### Handling platform-dependent paths

You can add other configuration names besides "default". For example, if you
had a path that would be operating system dependent, you could edit your 
configuration file like this (abbreviated here to show only the data path):

```
default:
  data: data
Windows:
  data: //server/path/to/data
Linux:
  data: /path/to/data
Darwin:
  data: /Volumes/path/to/data
```

And then you can read in the appropriate paths for the system you are using:


```
conf <- here::here('folders.yml')
folders <- get_folders(conf, conf_name = Sys.info()[['sysname']])
data_folder <- folders$data
```

... so that your script can still be platform independent even though the data
path is not. If your specified `conf_name` does not exist in the configuration 
file, then the defaults are used instead. 

## Dependencies

When you install this package, the following dependencies should be installed 
for you: [config](https://CRAN.R-project.org/package=config), [here](https://CRAN.R-project.org/package=here), 
[yaml](https://CRAN.R-project.org/package=yaml).

You will need to load the *here* package with your scripts to make the most use 
of the *folders* package, as seen in the Basic Usage examples above.
