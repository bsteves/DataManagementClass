ESM 505/ESR 605 : Data Management, Spring 2014

Module 4: Filtering and Subsetting Data
====================

We briefly discussed selecting data within an object in Module 2.  Here we will discuss more advanced methods to subsetting data. Because most of the data we will be using in R will be in the form of data frames we will concentrate on data frame methods for filtering and subsetting.


##  Determining the structure of an object

In order to understand how to select portions of a data object, you will need to know details about the structure of that object first.  The str() function accomplishes that.


```r
# Create a series of equally sized vectors
sites <- c("Site A", "Site B")
dates <- as.Date(c("12Mar2013", "04Apr2013"), "%d%b%Y")
lat = c(45, 47)
lon = c(-124, -125)
treatment = c(T, F)

# Combine the vectors into a data frame
dat <- data.frame(sites, dates, lat, lon, treatment)

# Use str() on some of the vectors and the data frame
str(sites)
```

```
##  chr [1:2] "Site A" "Site B"
```

```r
str(lat)
```

```
##  num [1:2] 45 47
```

```r
str(dat)
```

```
## 'data.frame':	2 obs. of  5 variables:
##  $ sites    : Factor w/ 2 levels "Site A","Site B": 1 2
##  $ dates    : Date, format: "2013-03-12" "2013-04-04"
##  $ lat      : num  45 47
##  $ lon      : num  -124 -125
##  $ treatment: logi  TRUE FALSE
```

```r

# The name() function is similar but only provides the names of the various
# data frame columns
names(dat)
```

```
## [1] "sites"     "dates"     "lat"       "lon"       "treatment"
```

```r


# You can also use name() to reassign the names of the data frame columns

names(dat) <- c("SiteName", "VisitDate", "Latitude", "Longitude", "TreatmentApplied")

str(dat)
```

```
## 'data.frame':	2 obs. of  5 variables:
##  $ SiteName        : Factor w/ 2 levels "Site A","Site B": 1 2
##  $ VisitDate       : Date, format: "2013-03-12" "2013-04-04"
##  $ Latitude        : num  45 47
##  $ Longitude       : num  -124 -125
##  $ TreatmentApplied: logi  TRUE FALSE
```


##  Selecting Variables (data frame columns)

### Selecting Single columns


```r

# By index
dat[1]
```

```
##   SiteName
## 1   Site A
## 2   Site B
```

```r

# By Name
dat["SiteName"]
```

```
##   SiteName
## 1   Site A
## 2   Site B
```

```r

# Using the $ operator

dat$SiteName
```

```
## [1] Site A Site B
## Levels: Site A Site B
```

```r

```


### By Name


```r

dat[c("SiteName", "TreatmentApplied")]
```

```
##   SiteName TreatmentApplied
## 1   Site A             TRUE
## 2   Site B            FALSE
```

```r

# Alternatively you can use matrix R,C notation

dat[, c("SiteName", "TreatmentApplied")]
```

```
##   SiteName TreatmentApplied
## 1   Site A             TRUE
## 2   Site B            FALSE
```


### By column number like a matrix


```r

dat[, c(1, 5)]
```

```
##   SiteName TreatmentApplied
## 1   Site A             TRUE
## 2   Site B            FALSE
```


### By Logical Assignment


```r
dat[c(T, F, F, F, T)]
```

```
##   SiteName TreatmentApplied
## 1   Site A             TRUE
## 2   Site B            FALSE
```


##  Droping Variables

### Excluding Variables


```r

# we can use negative indexes

dat[c(-1, -4)]
```

```
##    VisitDate Latitude TreatmentApplied
## 1 2013-03-12       45             TRUE
## 2 2013-04-04       47            FALSE
```

```r

# or we can use logical assignment

dropcols <- names(dat) %in% c("Latitude", "Longitude")
dropcols
```

```
## [1] FALSE FALSE  TRUE  TRUE FALSE
```

```r

dropcols2 <- c("Latitude", "Longitude")

# this is the similar to a logical assignment for selecting columns but
# instead a 'True' is a column we want to drop
dat[c(F, F, T, T, F)]
```

```
##   Latitude Longitude
## 1       45      -124
## 2       47      -125
```

```r

# We use the ! to denote a logical negation or 'not' Here we specify that we
# want to select 'not the dropcols'
dat[!dropcols]
```

```
##   SiteName  VisitDate TreatmentApplied
## 1   Site A 2013-03-12             TRUE
## 2   Site B 2013-04-04            FALSE
```



### Dropping Variables permentantly


```r

# One option is reassignment

dat <- dat[!dropcols]

# rebuild the data frame
dat <- data.frame(sites, dates, lat, lon, treatment)
names(dat) <- c("SiteName", "VisitDate", "Latitude", "Longitude", "TreatmentApplied")

# the other option is to set some columns to null

dat$TreatmentApplied <- NULL
dat
```

```
##   SiteName  VisitDate Latitude Longitude
## 1   Site A 2013-03-12       45      -124
## 2   Site B 2013-04-04       47      -125
```

```r
# But you can't do this with more than one column at a time

dat[c("Latitude", "Longitude")] <- NULL
```

```
## Error: replacement has 0 items, need 4
```

```r

# However you can chain these

dat$Latitude <- dat$Longitude <- NULL
dat
```

```
##   SiteName  VisitDate
## 1   Site A 2013-03-12
## 2   Site B 2013-04-04
```

```r

```


##  Selecting Observations (data frame rows)


```r
# loading some real data with lots of records

data2 <- read.csv("data/wk1samples.csv")

str(data2)
```

```
## 'data.frame':	5 obs. of  6 variables:
##  $ sampleID: int  1 2 3 4 5
##  $ siteID  : int  1 1 1 2 2
##  $ date    : Factor w/ 3 levels "2008-02-22","2008-02-26",..: 1 2 3 1 2
##  $ sampler : Factor w/ 1 level "BPS": 1 1 1 1 1
##  $ temp_C  : num  9 9.2 10 8.9 9.1
##  $ fish    : int  0 3 0 11 14
```


### By index


```r

# select first two records
data2[1:2, ]
```

```
##   sampleID siteID       date sampler temp_C fish
## 1        1      1 2008-02-22     BPS    9.0    0
## 2        2      1 2008-02-26     BPS    9.2    3
```

```r

# selecting second and fourth records
data2[c(2, 4), ]
```

```
##   sampleID siteID       date sampler temp_C fish
## 2        2      1 2008-02-26     BPS    9.2    3
## 4        4      2 2008-02-22     BPS    8.9   11
```

```r

# selecting not the third and fifth record
data2[c(-3, -5), ]
```

```
##   sampleID siteID       date sampler temp_C fish
## 1        1      1 2008-02-22     BPS    9.0    0
## 2        2      1 2008-02-26     BPS    9.2    3
## 4        4      2 2008-02-22     BPS    8.9   11
```


### By value


```r

# Selecting data2 where there weren't any fish
data2[data2$fish == 0, ]
```

```
##   sampleID siteID       date sampler temp_C fish
## 1        1      1 2008-02-22     BPS      9    0
## 3        3      1 2008-03-01     BPS     10    0
```

```r

# Using & to combine conditions
data2[data2$fish > 9 & data2$siteID == 2, ]
```

```
##   sampleID siteID       date sampler temp_C fish
## 4        4      2 2008-02-22     BPS    8.9   11
## 5        5      2 2008-02-26     BPS    9.1   14
```


##  Selecting Observations and Variables


```r
# Sites and dates where we collected zero fish

data2[data2$fish == 0, c("siteID", "date")]
```

```
##   siteID       date
## 1      1 2008-02-22
## 3      1 2008-03-01
```

```r

# sample IDs where zero fish were collected
data2[data2$fish == 0, ]$sampleID
```

```
## [1] 1 3
```


##  Subset Function

The subset() function is a shortcut to selecting observations and variables


```r
# this isn't any shorter than the previous method of finding the sites and
# dates where we collected zero fish, but it's a bit more readable.

subset(data2, fish == 0, select = c(siteID, date))
```

```
##   siteID       date
## 1      1 2008-02-22
## 3      1 2008-03-01
```

```r

# we can also drop columns using the select option

subset(data2, fish == 0, select = c(-siteID, -date))
```

```
##   sampleID sampler temp_C fish
## 1        1     BPS      9    0
## 3        3     BPS     10    0
```

```r

# Subset makes it easier to combine multiple conditions

subset(data2, fish == 0 & siteID == 1 & date == "2008-03-01")
```

```
##   sampleID siteID       date sampler temp_C fish
## 3        3      1 2008-03-01     BPS     10    0
```

```r

# You can even do 'OR' conditions using the '|' operator here we are
# selecting where fish collection was less than or equal to 3 or greater
# than 11

subset(data2, fish <= 3 | fish > 11)
```

```
##   sampleID siteID       date sampler temp_C fish
## 1        1      1 2008-02-22     BPS    9.0    0
## 2        2      1 2008-02-26     BPS    9.2    3
## 3        3      1 2008-03-01     BPS   10.0    0
## 5        5      2 2008-02-26     BPS    9.1   14
```

```r

```

 Remember you can combine a series of logical operators ( "|" and "&")
 it helps if you know some logic to help simply your expressions
 for example...
 
 !(a & b) is the same as !a | !b
 !(a | b) is the same as !a & !b 


```r

subset(data2, !(fish == 3 & siteID == 1))
```

```
##   sampleID siteID       date sampler temp_C fish
## 1        1      1 2008-02-22     BPS    9.0    0
## 3        3      1 2008-03-01     BPS   10.0    0
## 4        4      2 2008-02-22     BPS    8.9   11
## 5        5      2 2008-02-26     BPS    9.1   14
```

```r

# is the same as

subset(data2, !fish == 3 | !siteID == 1)
```

```
##   sampleID siteID       date sampler temp_C fish
## 1        1      1 2008-02-22     BPS    9.0    0
## 3        3      1 2008-03-01     BPS   10.0    0
## 4        4      2 2008-02-22     BPS    8.9   11
## 5        5      2 2008-02-26     BPS    9.1   14
```

```r

# and

subset(data2, !(fish == 3 | siteID == 2))
```

```
##   sampleID siteID       date sampler temp_C fish
## 1        1      1 2008-02-22     BPS      9    0
## 3        3      1 2008-03-01     BPS     10    0
```

```r

# is the same as

subset(data2, !fish == 3 & !siteID == 2)
```

```
##   sampleID siteID       date sampler temp_C fish
## 1        1      1 2008-02-22     BPS      9    0
## 3        3      1 2008-03-01     BPS     10    0
```

```r

```


You can also use the %in% operator to match multiple values at once.


```r

dates_of_interest <- c("2008-02-22", "2008-03-01")
subset(data2, date %in% dates_of_interest)
```

```
##   sampleID siteID       date sampler temp_C fish
## 1        1      1 2008-02-22     BPS    9.0    0
## 3        3      1 2008-03-01     BPS   10.0    0
## 4        4      2 2008-02-22     BPS    8.9   11
```

```r

# is the same as
subset(data2, date == "2008-02-22" | date == "2008-03-01")
```

```
##   sampleID siteID       date sampler temp_C fish
## 1        1      1 2008-02-22     BPS    9.0    0
## 3        3      1 2008-03-01     BPS   10.0    0
## 4        4      2 2008-02-22     BPS    8.9   11
```

```r

```




##  Random samples
Sometimes you will want a random subset of your data.  To do this, use the sample() function without replacement.


```r

# first determine how many rows of data you have
rowcount <- nrow(data2)

# select two random rows
randomrows <- sample(rowcount, 2)

# use the 'randomrows' to select those rows from the data frame
data2[randomrows, ]
```

```
##   sampleID siteID       date sampler temp_C fish
## 2        2      1 2008-02-26     BPS    9.2    3
## 1        1      1 2008-02-22     BPS    9.0    0
```

```r

```


## Head and Tail

Large data frames take a long time to print out to the screen.  Because of this, sometimes you just want to view the first portion (the head) or the last portion (the tail) of a data frame.  To get a sense of what the data looks like.   


```r

# load a rather large dataset
load("data/WSA_data.Rdata")

# How many rows of data using nrow()
nrow(data)
```

```
## [1] 332633
```

```r

# To make my tables neat lets select just the 5 columns of data
data <- data[, 1:5]

# The head (beginning) of the data
head(data)
```

```
##   NVMC_ID NBIC_Vessel Nrt Vessel_Type Transit_Type
## 1 1978995     8875384 762       Other    Coastwise
## 2 1979680     8875384 762       Other    Coastwise
## 3 1984838     8875384 762       Other    Coastwise
## 4 2102657     8875384 762       Other    Coastwise
## 5 2104970     8875384 762       Other    Coastwise
## 6 2107169     8875384 762       Other    Coastwise
```

```r


# The tail (end) of the data
tail(data)
```

```
##        NVMC_ID NBIC_Vessel   Nrt Vessel_Type Transit_Type
## 332628 2080568     8811792 24121      Bulker     Overseas
## 332629 2119831     8811792 24121      Bulker     Overseas
## 332630 1879279     8811792 24121      Bulker     Overseas
## 332631 1908368     8811792 24121      Bulker     Overseas
## 332632 1951666     8811792 24121      Bulker     Overseas
## 332633 1968302     8811792 24121      Bulker     Overseas
```

```r

# the defualt is 6 rows of data, but you can change this by specifing an n
# value

head(data, n = 20)
```

```
##    NVMC_ID NBIC_Vessel Nrt Vessel_Type Transit_Type
## 1  1978995     8875384 762       Other    Coastwise
## 2  1979680     8875384 762       Other    Coastwise
## 3  1984838     8875384 762       Other    Coastwise
## 4  2102657     8875384 762       Other    Coastwise
## 5  2104970     8875384 762       Other    Coastwise
## 6  2107169     8875384 762       Other    Coastwise
## 7  1987800     8875384 762       Other    Coastwise
## 8  1994186     8875384 762       Other    Coastwise
## 9  1998928     8875384 762       Other    Coastwise
## 10 2006655     8875384 762       Other    Coastwise
## 11 2011014     8875384 762       Other    Coastwise
## 12 2014870     8875384 762       Other    Coastwise
## 13 2018644     8875384 762       Other    Coastwise
## 14 2025054     8875384 762       Other    Coastwise
## 15 2025702     8875384 762       Other    Coastwise
## 16 2028666     8875384 762       Other    Coastwise
## 17 2035679     8875384 762       Other    Coastwise
## 18 2041133     8875384 762       Other    Coastwise
## 19 2043794     8875384 762       Other    Coastwise
## 20 2046698     8875384 762       Other    Coastwise
```

```r

```

##  Assigning and Subsetting

Sometimes you want to select data so that you can reassign values in the data frame. This is useful when you are cleaning up your data.


```r

# for example, sometimes you want to replace NA values with 0's

data3 <- data.frame(site = c(1, 1, 1, 2, 2, 2), count = c(2, 4, 3, NA, 5, NA))
data3
```

```
##   site count
## 1    1     2
## 2    1     4
## 3    1     3
## 4    2    NA
## 5    2     5
## 6    2    NA
```

```r

# to select rows where count is NA you can use the is.na() function

data3[is.na(data3$count), ]
```

```
##   site count
## 4    2    NA
## 6    2    NA
```

```r

# to set count to zero where count was NA

data3[is.na(data3$count), ]$count <- 0

data3
```

```
##   site count
## 1    1     2
## 2    1     4
## 3    1     3
## 4    2     0
## 5    2     5
## 6    2     0
```


##  Ordering

While not exactly a form of subsetting, ordering of data frames is a related action.  We can use the order() and sort() functions to accomplish this.


```r

# A simple ordering of a vector
x <- c(2, 3, 5, 3, 2, 1)
order(x)
```

```
## [1] 6 1 5 2 4 3
```

```r

# Well that's now what we want. What is happening here?  The order function
# returns the values of the vector index in order of the values we
# specified.  In this case the 6th value was the lowest (first) and the 3rd
# value was the highest (last).  To get the results we wanted we need to use
# order in a slightly different way.

x[order(x)]
```

```
## [1] 1 2 2 3 3 5
```

```r


# Using sort() gives us what we probably were expecting.

sort(x)
```

```
## [1] 1 2 2 3 3 5
```

```r



# Then why bother with order().  Well, sort() doesn't work on data frames.

data3
```

```
##   site count
## 1    1     2
## 2    1     4
## 3    1     3
## 4    2     0
## 5    2     5
## 6    2     0
```

```r

# to sort the data3 data frame by count

data3[order(data3$count), ]
```

```
##   site count
## 4    2     0
## 6    2     0
## 1    1     2
## 3    1     3
## 2    1     4
## 5    2     5
```

```r

```



## Bonus Material

The following PDF is a 6 page cheat sheet for many of the basic operators, functions, and other important bits of R.  I try to keep a copy handy when I'm coding in R in case I need a reminder on which function I might need for a particular job.

http://cran.r-project.org/doc/contrib/Baggott-refcard-v2.pdf


## Homework

Using the data set you found for Module 2 and imported in Module 3 write a script to create 3 interesting subsets of data that you might want to use for later analysis.  Use which ever methods make the most sense to you but be sure to assign these subsets to new variables with meaningful names. Remember to add code from Module 3 regarding how to import this data into the beginning of your new script.

1.) Upload your data and script to this module's dropbox on d2l.




