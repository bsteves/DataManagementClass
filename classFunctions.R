knitsDoc <- function(name) {
  library(knitr)
  knit(paste0(name, ".Rmd"), encoding = "utf-8")
  system(paste0("pandoc -o ", name, ".docx ", name, ".md"))
}

knitsPDF <- function(name) {
  library(knitr)
  knit(paste0(name, ".Rmd"), encoding = "utf-8")
  system(paste0("pandoc -V geometry:margin=0.75in -o", name, ".pdf ", name, ".md"))
}


normVarNames<-function (vars, sep = "_") {
  require(stringr)
  if (sep == ".") 
    sep <- "\\."
  pat <- "_|\\.| "
  rep <- sep
  vars <- str_replace_all(vars, pat, rep)
  pat <- perl("(?<![[:upper:]])([[:upper:]])([[:upper:]]*)")
  rep <- "\\1\\L\\2"
  vars <- str_replace_all(vars, pat, rep)
  pat <- perl("(?<!^)([[:upper:]])")
  rep <- paste0(sep, "\\L\\1")
  vars <- str_replace_all(vars, pat, rep)
  pat <- perl(paste0("(?<![", sep, "[[:digit:]]])([[:digit:]]+)"))
  rep <- paste0(sep, "\\1")
  vars <- str_replace_all(vars, pat, rep)
  vars <- str_replace(vars, "^_+", "")
  vars <- str_replace(vars, "_+$", "")
  vars <- str_replace(vars, "__+", "_")
  vars <- tolower(vars)
  pat <- paste0(sep, "+")
  rep <- sep
  vars <- str_replace_all(vars, pat, rep)
  return(vars)
}