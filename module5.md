ESM 505/ESR 605 : Data Management, Spring 2014

Module 5: Reshaping Data
====================

## Melting Data (from Wide to narrow)


```r
# loading a wide table
spdat <- read.csv("data/wk1spdat.csv")

spdat
```

```
##   Site       Date species1 species2 species3 species4
## 1    A 2009-03-10        1        0        0        4
## 2    B 2009-03-10        2        7        0        0
## 3    C 2009-03-10        0        2        2        0
## 4    A 2009-04-13        0        1        1        5
## 5    B 2009-04-13        0        2        1        2
## 6    C 2009-04-13        1        5        2        0
```




```r

# secret to reshaping data in R is the package 'reshape2'

library(reshape2)

# converting wide format to narrow format
spdat2 <- melt(spdat, id = c("Site", "Date"), variable.name = "Species", value.name = "Count")

spdat2
```

```
##    Site       Date  Species Count
## 1     A 2009-03-10 species1     1
## 2     B 2009-03-10 species1     2
## 3     C 2009-03-10 species1     0
## 4     A 2009-04-13 species1     0
## 5     B 2009-04-13 species1     0
## 6     C 2009-04-13 species1     1
## 7     A 2009-03-10 species2     0
## 8     B 2009-03-10 species2     7
## 9     C 2009-03-10 species2     2
## 10    A 2009-04-13 species2     1
## 11    B 2009-04-13 species2     2
## 12    C 2009-04-13 species2     5
## 13    A 2009-03-10 species3     0
## 14    B 2009-03-10 species3     0
## 15    C 2009-03-10 species3     2
## 16    A 2009-04-13 species3     1
## 17    B 2009-04-13 species3     1
## 18    C 2009-04-13 species3     2
## 19    A 2009-03-10 species4     4
## 20    B 2009-03-10 species4     0
## 21    C 2009-03-10 species4     0
## 22    A 2009-04-13 species4     5
## 23    B 2009-04-13 species4     2
## 24    C 2009-04-13 species4     0
```

```r

```



We can go a step further and clean this up a bit


```r

# removing data rows where species counts are 0
spdat2 <- spdat2[spdat2$Count > 0, ]

# order the data frame by Date, Site, then Species
spdat2[order(spdat2$Date, spdat2$Site, spdat2$Species), ]
```

```
##    Site       Date  Species Count
## 1     A 2009-03-10 species1     1
## 19    A 2009-03-10 species4     4
## 2     B 2009-03-10 species1     2
## 8     B 2009-03-10 species2     7
## 9     C 2009-03-10 species2     2
## 15    C 2009-03-10 species3     2
## 10    A 2009-04-13 species2     1
## 16    A 2009-04-13 species3     1
## 22    A 2009-04-13 species4     5
## 11    B 2009-04-13 species2     2
## 17    B 2009-04-13 species3     1
## 23    B 2009-04-13 species4     2
## 6     C 2009-04-13 species1     1
## 12    C 2009-04-13 species2     5
## 18    C 2009-04-13 species3     2
```

```r

# a cleaner way to order by multiple fields using the with() function.  It
# lets you specify columns without needing the full 'spdat2$' prefix on
# everything

spdat2 <- spdat2[with(spdat2, order(Site, Date, Species)), ]

spdat2
```

```
##    Site       Date  Species Count
## 1     A 2009-03-10 species1     1
## 19    A 2009-03-10 species4     4
## 10    A 2009-04-13 species2     1
## 16    A 2009-04-13 species3     1
## 22    A 2009-04-13 species4     5
## 2     B 2009-03-10 species1     2
## 8     B 2009-03-10 species2     7
## 11    B 2009-04-13 species2     2
## 17    B 2009-04-13 species3     1
## 23    B 2009-04-13 species4     2
## 9     C 2009-03-10 species2     2
## 15    C 2009-03-10 species3     2
## 6     C 2009-04-13 species1     1
## 12    C 2009-04-13 species2     5
## 18    C 2009-04-13 species3     2
```



## Casting Data from Narrow to Wide


```r
# Use dcast() function.  Value.var is the column to aggregate by and
# fun.aggregate is the function to aggregate with.  In this case we want the
# sum of the counts.

spdat3 <- dcast(spdat2, Site + Date ~ Species, value.var = "Count", fun.aggregate = sum)

spdat3
```

```
##   Site       Date species1 species2 species3 species4
## 1    A 2009-03-10        1        0        0        4
## 2    A 2009-04-13        0        1        1        5
## 3    B 2009-03-10        2        7        0        0
## 4    B 2009-04-13        0        2        1        2
## 5    C 2009-03-10        0        2        2        0
## 6    C 2009-04-13        1        5        2        0
```

```r

# It just so happens that the dcast() function would have guessed those last
# two options by defualt and the same result could be made with this
# simpiler bit of code but we get a warning message and some NA's instead of
# 0's.

spdat3 <- dcast(spdat2, Site + Date ~ Species)
```

```
## Using Count as value column: use value.var to override.
```

```r
spdat3
```

```
##   Site       Date species1 species2 species3 species4
## 1    A 2009-03-10        1       NA       NA        4
## 2    A 2009-04-13       NA        1        1        5
## 3    B 2009-03-10        2        7       NA       NA
## 4    B 2009-04-13       NA        2        1        2
## 5    C 2009-03-10       NA        2        2       NA
## 6    C 2009-04-13        1        5        2       NA
```

```r

# We can fix the NA's using a subset with assingment based on is.na()

spdat3[is.na(spdat3)] <- 0
spdat3
```

```
##   Site       Date species1 species2 species3 species4
## 1    A 2009-03-10        1        0        0        4
## 2    A 2009-04-13        0        1        1        5
## 3    B 2009-03-10        2        7        0        0
## 4    B 2009-04-13        0        2        1        2
## 5    C 2009-03-10        0        2        2        0
## 6    C 2009-04-13        1        5        2        0
```

```r


# Our new spdat3 data frame is the same as our original spdat data frame
# with the exception of the order of the data which isn't really a big deal.
```


Other aggregation functions can be used like min, mean, max, nrow, length, etc..


```r
# how many records per site, date, species combination
dcast(spdat2, Site + Date ~ Species, length)
```

```
## Using Count as value column: use value.var to override.
```

```
##   Site       Date species1 species2 species3 species4
## 1    A 2009-03-10        1        0        0        1
## 2    A 2009-04-13        0        1        1        1
## 3    B 2009-03-10        1        1        0        0
## 4    B 2009-04-13        0        1        1        1
## 5    C 2009-03-10        0        1        1        0
## 6    C 2009-04-13        1        1        1        0
```

```r

# mean number of records per site
dcast(spdat2, Site ~ Species, mean)
```

```
## Using Count as value column: use value.var to override.
```

```
##   Site species1 species2 species3 species4
## 1    A        1      1.0        1      4.5
## 2    B        2      4.5        1      2.0
## 3    C        1      3.5        2      NaN
```




Sometimes you might want some row and column summaries added to your wide data format, particularly if this data is going to eventually become a table.  You set the margins option to TRUE to return all of the summary margins (row and column grand summaries)


```r

# sum of all species observations combined by site with grand totals
dcast(spdat2, Site ~ Species, sum, margins = TRUE)
```

```
## Using Count as value column: use value.var to override.
```

```
##    Site species1 species2 species3 species4 (all)
## 1     A        1        1        1        9    12
## 2     B        2        9        1        2    14
## 3     C        1        7        4        0    12
## 4 (all)        4       17        6       11    38
```



## Homework

Determine if your data set(s) are narrow or wide.  Use reshape2's melt() and cast() functions to transform your data.

For example, if your data is narrow, transform a subset of your data into a more useful and more readable wide table.

Likewise, if your data is wide, transform it to narrow format

1.) Upload to this module's dropbox your data and data transformation script.


