#' elibrary: A Research Compendium
#' 
#' @author Nicolas Casajus \email{nicolas.casajus@gmail.com}
#' 
#' @date 2024/01/09



## Install Dependencies (listed in DESCRIPTION) ----

devtools::install_deps(upgrade = "never")


## Load Project Addins (R Functions and Packages) ----

devtools::load_all(here::here())


## Run Project ----

make_pages()
make_index()
