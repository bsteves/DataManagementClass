Title
========================================================




```r
library(dismo)
```

```
## Loading required package: raster
## Loading required package: sp
```

```r
OR_map <- gmap("United States")
```

```
## Loading required package: rgdal
## rgdal: version: 0.8-16, (SVN revision 498)
## Geospatial Data Abstraction Library extensions to R successfully loaded
## Loaded GDAL runtime: GDAL 1.9.0, released 2011/12/29
## Path to GDAL shared files: /usr/share/gdal/1.9
## Loaded PROJ.4 runtime: Rel. 4.8.0, 6 March 2012, [PJ_VERSION: 480]
## Path to PROJ.4 shared files: (autodetected)
## Loading required package: XML
```

```r
plot(OR_map, interpolate = TRUE, main = "Map of Oregon")
```

![plot of chunk dismo](figure/dismo1.png) ![plot of chunk dismo](figure/dismo2.png) 

