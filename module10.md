Module 10: Writing Functions
========================================================
author: Brian Steves
date: April 29, 2016
autosize: true

Hello world!
========================================================


```r
hello <- function() {
    msg <- "Hello world!"
    return(msg)
}


hello()
```

```
[1] "Hello world!"
```

Hello <your name here>!
========================================================

Let's modify the function to accept an argument.


```r
hello <- function(name) {
    msg <- paste("Hello ", name, "!", sep = "")
    return(msg)
}

hello("Brian")
```

```
[1] "Hello Brian!"
```

Defualt values
========================================================
We can assign a defualt value to the argument.


```r
hello <- function(name = "World") {
    msg <- paste("Hello ", name, "!", sep = "")
    return(msg)
}

hello("Brian")
```

```
[1] "Hello Brian!"
```

```r
hello()
```

```
[1] "Hello World!"
```


A second argument, a bit of logic, and time
==================================================


```r
hello <- function(name, gender) {
    if (gender == "F") { formal <- " ma'am"}
    if (gender == "M") { formal <- " sir"}
    if (gender != "F" & gender != "M") {formal <- ""}
    hour <- as.numeric(format(Sys.time(), "%H"))
    if (hour > 0 & hour < 12) {daypart <- " morning"}
    if (hour >= 12 & hour < 18) {daypart <- " afternoon"}
    if (hour >= 18) {daypart <- " evening"}
    msg <- paste("Hello ", name, "! Nice to see you this", daypart, formal, 
        ".", sep = "")
    return(msg)
}
hello("Brian","M")
```

```
[1] "Hello Brian! Nice to see you this morning sir."
```

An example with math
=========================================


```r
BMI <- function(weight_lbs, height_inches) {

    BMI <- weight_lbs * 703/(height_inches)^2
    return(BMI)
}

BMI(185, 72)
```

```
[1] 25.08777
```

A Standard Error Function
======================================

```r
x <- c(1, 2, 3, 2, 1, 2, 3, 2, 3, 4, 5, 3, 3, 2, 1)
length(x)
```

```
[1] 15
```

```r
mean(x)
```

```
[1] 2.466667
```

```r
sd(x)
```

```
[1] 1.125463
```
R doens't have a built in standard error function.

Custom Standard Error Function
======================================

```r
se <- function(x) {
    se <- sd(x)/sqrt(length(x))
    return(se)
}

se(x)
```

```
[1] 0.2905933
```

Dealing with NA's
======================================

```r
x <- c(12, 23, 41, 23, 19, 16, NA)
se(x)
```

```
[1] NA
```
***

```r
se <- function(x) {
    x <- x[!is.na(x)]
    se <- sd(x)/sqrt(length(x))
    return(se)
}
se(x)
```

```
[1] 4.112312
```
na.rm=TRUE
======================================

```r
se <- function(x, na.rm = FALSE) {
    if (na.rm == TRUE) {
        x <- x[!is.na(x)]
    }
    se <- sd(x)/sqrt(length(x))
    return(se)
}

se(x)
```

```
[1] NA
```

```r
se(x, na.rm=TRUE)
```

```
[1] 4.112312
```

Plotting Functions
======================================

```r
myFavPlot <- function(dat, x, y, title) {
    require(ggplot2)
    p <- ggplot(data = dat, aes_string(x = x, y = y))
    p <- p + geom_point(color = "red") + stat_smooth(color = "red")
    p <- p + theme_bw()
    p <- p + labs(title = title)
    print(p)
}
```

Plot the 'cars' data with our function
======================================

```r
myFavPlot(cars, "speed", "dist", "Some car data plotted.")
```

![plot of chunk unnamed-chunk-12](Module10-figure/unnamed-chunk-12-1.png)

Plot the 'iris' data with our function
======================================

```r
myFavPlot(iris, "Sepal.Length", "Petal.Length", "Some iris data plotted.")
```

![plot of chunk unnamed-chunk-13](Module10-figure/unnamed-chunk-13-1.png)
