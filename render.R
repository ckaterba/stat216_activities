library(tidyverse)
activities <- list.files()[str_detect(list.files(), ".Rmd")]

for(act in activities ){
  file_dest <- str_c( "docs/"
                      , str_remove(act, ".Rmd")
                      , ".html")
  rmarkdown::render(act, output_file = file_dest)
}

