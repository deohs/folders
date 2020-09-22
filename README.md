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

The package defaults provide "code", "data", "doc", "figures" and 
"results" folders. You can specify alternatives in a YAML configuration file, 
which this package will read and use instead.

## Installation

You can install the development version from [GitHub](https://github.com/deohs/folders) with:


```r
# install.packages("devtools")
devtools::install_github("deohs/folders")
```

Or, if you prefer using [pacman](https://github.com/trinker/pacman):


```r
pacman::p_load_gh("deohs/folders")
```

## Usage

Here is an example of a script which will initialize the folders and then write 
a data file to the `folders$data` folder. You will see that there are no 
hardcoded paths for files or folders and no use of `setwd()`.


```r
# Load packages.
library(here)
library(folders)

# Or use pacman:
# pacman::p_load(here)
# pacman::p_load_gh("deohs/folders")

# Get the list of standard folders and create any folders which are missing.
folders <- folders::get_folders()
result <- create_folders(folders)

# Check to see that the data folder has been created.
dir.exists(here::here(folders$data))
```

```
## [1] TRUE
```

```r
# Get a dataset to use for writing a CSV file to the data folder.
library(datasets)
data(iris)

# Confirm that the CSV file does not yet exist.
file_path <- here::here(folders$data, "iris.csv")
file.exists(file_path)
```

```
## [1] FALSE
```

```r
# Write the CSV file.
write.csv(iris, file_path, row.names = FALSE)

# Verify that the file was written.
file.exists(file_path)
```

```
## [1] TRUE
```

```r
list.files(dirname(file_path))
```

```
## [1] "iris.csv"
```

## Configuration file

The configuration file, if not already present, will be written by `get_folders()` 
to a YAML file called `folders.yml`, stored in the parent folder of your R 
project. This file will be read by `config::get()` on subsequent executions of 
`get_folders()`. This behavior can be modified by function parameters.

The default `folders.yml` file looks like:

```
default:
  code: code
  data: data
  doc: doc
  figures: figures
  results: results
```

You will note there is a "code" folder. If your scripts are in the "code" 
folder, your code will still be able to find the other folders, thanks 
to the [here](https://cran.r-project.org/web/packages/here/index.html) 
package.

## Dependencies

When you install this package, the following dependencies should be installed 
for you.

- [config](https://cran.r-project.org/web/packages/config/index.html)
- [here](https://cran.r-project.org/web/packages/here/index.html)
- [yaml](https://cran.r-project.org/web/packages/yaml/index.html)

You will need to load the *here* package with your scripts to make the most use 
of the *folders* package, as seen in the example above.
