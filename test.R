myFavoritePlot <- function(data,x,y){
  require(ggplot2)
  p <- ggplot(data)
  p <- geom_point(aes(x,y))
  print(p)
}