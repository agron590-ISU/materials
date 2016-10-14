file <- list.files(pattern="slides.*Rmd")
category <- strsplit(strsplit(file, split = "_")[[1]][2], ".Rmd")[[1]]

knitr::purl(file, paste0("script_", category, ".R"))
