Module 9: Creating Plots
========================================================
author: Brian Steves 
date: 
autosize: true

Base Plot Function plot()
=========================================================

```r
xdat <- seq(1,10,by=0.1)
ydat <- sin(xdat)
plot(xdat, ydat)
```

![plot of chunk basic_plot](Module9-figure/basic_plot-1.png)

Alternate method using forumula y~x
=======================================

```r
plot(ydat~xdat)  
```

![plot of chunk unnamed-chunk-1](Module9-figure/unnamed-chunk-1-1.png)

lines()
=========================================================


```r
plot(xdat,ydat)
lines(xdat,ydat)
```

![plot of chunk basic_plot_with_lines](Module9-figure/basic_plot_with_lines-1.png)

Barplot() plots a bar plot.
=========================================================

```r
barplot(VADeaths)  # stacked
```

![plot of chunk barplot](Module9-figure/barplot-1.png)
***

```r
barplot(VADeaths, beside=TRUE)
```

![plot of chunk unnamed-chunk-2](Module9-figure/unnamed-chunk-2-1.png)
hist()
=========================================================

```r
# 1000 normally random points with a mean of 0 and a SD of 1
x <- rnorm(1000)
hist(x)
```

![plot of chunk histogram](Module9-figure/histogram-1.png)

You can specify the number of breaks.
=========================================================

```r
hist(x,breaks = 5)
```

![plot of chunk histogram2](Module9-figure/histogram2-1.png)
***

```r
hist(x, breaks = 50)
```

![plot of chunk unnamed-chunk-3](Module9-figure/unnamed-chunk-3-1.png)


hierarchical clustering (hclust).
====================================

```r
hc <- hclust(dist(USArrests), "ave")
plot(hc)
```

![plot of chunk hcluster](Module9-figure/hcluster-1.png)

par()
============================
pch = symbol, col = color, cex = size.

```r
plot(xdat,ydat, col="red", pch=6, cex=5)
```

![plot of chunk basic_with_par](Module9-figure/basic_with_par-1.png)

Titles and axis labels
==============================

```r
plot(xdat,ydat, main="Sine curve",xlab="X Values",ylab="Y Values")
```

![plot of chunk basic_with_labels](Module9-figure/basic_with_labels-1.png)



ggplot2 package
===============================
The ggplot2 package introduces an entirely different way to plot using the "grammar of graphics".  


Simple gglot() example
================================

```r
library(ggplot2)
dat <- data.frame(xdat, ydat)
p <- ggplot(dat, aes(x=xdat, y=ydat))
p <- p + geom_line()
print(p)
```

![plot of chunk ggplot_sine_curve](Module9-figure/ggplot_sine_curve-1.png)
Complicated ggplot() example
=================================

```r
p <- ggplot(diamonds) # using built in diamond dataset
p + geom_point(aes(x=carat, y=price))
```

![plot of chunk ggplot_diamonds](Module9-figure/ggplot_diamonds-1.png)
***

```r
p + geom_point(aes(x=carat, y=price, colour = clarity))
```

![plot of chunk unnamed-chunk-4](Module9-figure/unnamed-chunk-4-1.png)
***

```r
p + geom_point(aes(x=carat, y=price, colour = clarity), alpha = 0.5)
```

![plot of chunk unnamed-chunk-5](Module9-figure/unnamed-chunk-5-1.png)

Adding a trend line
=======================

```r
p <- ggplot(mpg, aes(x=displ, y=hwy))
p + geom_point() + geom_smooth(method=lm)
```

![plot of chunk ggplot_smooth](Module9-figure/ggplot_smooth-1.png)

Multiple plots using facet_wrap()
====================================


```r
p <- ggplot(mpg, aes(x=displ, y=hwy)) 
p <- p + geom_point(aes(col=class)) + facet_wrap(~manufacturer)
p
```

![plot of chunk ggplot_facet_wrap](Module9-figure/ggplot_facet_wrap-1.png)

ggplot2 themes
=================================

```r
p + theme_bw()
```

![plot of chunk unnamed-chunk-6](Module9-figure/unnamed-chunk-6-1.png)

There are several preset themes and you can even create your own.


Additional Resources
==============================
A ggplot2 cheat sheet  
https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

ggplot2 documentation site  
http://docs.ggplot2.org/current/index.html

Homework
================================
Make two plots from your data, one using the base plotting and another using ggplot2.  Upload your R script to the d2l dropbox for this module.



