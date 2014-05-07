ESM 505/ESR 605 : Data Management, Spring 2014

Module 13: Mapping in R 
====================

http://statacumen.com/teach/SC1/SC1_16_Maps.pdf

https://github.com/hadley/ggplot2/wiki/plotting-polygon-shapefiles

http://cran.r-project.org/web/views/Spatial.html

http://www.molecularecologist.com/2012/09/making-maps-with-r/

http://cameron.bracken.bz/finally-an-easy-way-to-fix-the-horizontal-lines-in-ggplot2-maps




```r
library(ggplot2)
map <- ggplot() + borders("world", fill = "gray") + borders("state") + theme_bw() + 
    coord_equal()
map
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-11.png) 

```r


xlim <- c(-130, -100)
ylim <- c(30, 60)

map + coord_equal(xlim = xlim, ylim = ylim)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-12.png) 




```r
library(PBSmapping)
```

```
## 
## -----------------------------------------------------------
## PBS Mapping 2.67.60 -- Copyright (C) 2003-2013 Fisheries and Oceans Canada
## 
## PBS Mapping comes with ABSOLUTELY NO WARRANTY;
## for details see the file COPYING.
## This is free software, and you are welcome to redistribute
## it under certain conditions, as outlined in the above file.
## 
## A complete user guide 'PBSmapping-UG.pdf' is located at 
## /home/stevesb/R/x86_64-pc-linux-gnu-library/3.1/PBSmapping/doc/PBSmapping-UG.pdf
## 
## Packaged on 2014-03-27
## Pacific Biological Station, Nanaimo
## 
## All available PBS packages can be found at
## http://code.google.com/p/pbs-software/
## 
## To see demos, type '.PBSfigs()'.
## -----------------------------------------------------------
```

```r
library(ggplot2)
library(maps)


# plot limits
xlim <- c(-140, -100)
ylim <- c(30, 50)

worldmap <- map_data("world")
names(worldmap) <- c("X", "Y", "PID", "POS", "region", "subregion")
worldmap2 <- clipPolys(worldmap, xlim = xlim, ylim = ylim, keepExtra = TRUE)

statemap <- map_data("state")
names(statemap) <- c("X", "Y", "PID", "POS", "region", "subregion")
statemap2 <- clipPolys(statemap, xlim = xlim, ylim = ylim, keepExtra = TRUE)

p <- ggplot() + coord_map(xlim = xlim, ylim = ylim) + geom_polygon(data = worldmap, 
    aes(X, Y, group = PID), fill = "darkseagreen", color = "grey50") + geom_polygon(data = statemap, 
    aes(X, Y, group = PID), fill = "darkseagreen", color = "grey50") + labs(y = "", 
    x = "") + theme_bw()
print(p)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-21.png) 

```r


p2 <- ggplot() + coord_map(xlim = xlim, ylim = ylim) + geom_polygon(data = worldmap2, 
    aes(X, Y, group = PID), fill = "darkseagreen", color = "grey50") + geom_polygon(data = statemap2, 
    aes(X, Y, group = PID), fill = "darkseagreen", color = "grey50") + labs(y = "", 
    x = "") + theme_bw()
print(p2)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-22.png) 

