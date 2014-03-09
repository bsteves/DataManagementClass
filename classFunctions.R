knitsDoc <- function(name) {
  library(knitr)
  knit(paste0(name, ".Rmd"), encoding = "utf-8")
  system(paste0("pandoc -o ", name, ".docx ", name, ".md"))
}

knitsPDF <- function(name) {
  library(knitr)
  knit(paste0(name, ".Rmd"), encoding = "utf-8")
  system(paste0("pandoc -o ", name, ".pdf ", name, ".md"))
}