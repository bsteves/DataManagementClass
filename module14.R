list.of.packages <- c("ggplot2", "tidyr", "maptools")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

lapply(list.of.packages, library, character.only=TRUE)


a <- 1:1000

save(a, file="test.Rdata")