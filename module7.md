ESM 505/ESR 605 : Data Management, Spring 2014

Module 7: Split, Apply, Combine
====================

I originally developed this module using the "plyr" package.  However, in early 2014 the "dplyr" was released and I think it is much easier to understand and it also happens to be much faster.  Both packages were written by Hadley Wickham and you are welcome to explore the older plyr package on your own.  Here is a paper in the Journal of Statistical Software where the plyr package was introduced.

http://www.jstatsoft.org/v40/i01/paper

## A quick comparison between dplyr and plyr


```r

library(plyr, warn.conflict=FALSE)

# saving the baseball dataset from plyr to a local data frame.  Later we will detach the plyr library when we load dplyr and we'll loose the baseball data otherwise. 

my_baseball<-baseball


head(my_baseball)
```

```
##            id year stint team lg  g  ab  r  h X2b X3b hr rbi sb cs bb so
## 4   ansonca01 1871     1  RC1    25 120 29 39  11   3  0  16  6  2  2  1
## 44  forceda01 1871     1  WS3    32 162 45 45   9   4  0  29  8  0  4  0
## 68  mathebo01 1871     1  FW1    19  89 15 24   3   1  0  10  2  1  2  0
## 99  startjo01 1871     1  NY2    33 161 35 58   5   1  1  34  4  2  3  0
## 102 suttoez01 1871     1  CL1    29 128 35 45   3   7  3  23  3  1  1  0
## 106 whitede01 1871     1  CL1    29 146 40 47   6   5  1  21  2  2  4  1
##     ibb hbp sh sf gidp
## 4    NA  NA NA NA   NA
## 44   NA  NA NA NA   NA
## 68   NA  NA NA NA   NA
## 99   NA  NA NA NA   NA
## 102  NA  NA NA NA   NA
## 106  NA  NA NA NA   NA
```

```r

# Recording how long this will take
plyr_time<-system.time(
  
  # Using plyr ddply() function to summarise how long each player played baseball and how many teams he was on
  player_summaries<-ddply(my_baseball, "id", summarise, duration=max(year)-min(year), nteams=length(unique(team)))
  
  )

# Looking at the first 10 players' summaries
head(player_summaries, 10)
```

```
##           id duration nteams
## 1  aaronha01       22      3
## 2  abernte02       17      7
## 3  adairje01       12      4
## 4  adamsba01       20      2
## 5  adamsbo03       13      4
## 6  adcocjo01       16      5
## 7  agostju01       12      5
## 8  aguilri01       15      4
## 9  aguirha01       15      4
## 10 ainsmed01       14      5
```

```r

```




```r

# Because plyr and dplyr are so similar we actually need to detach the plyr package before we can load the dplyr package properly

detach("package:plyr", unload=TRUE)

library(dplyr, warn.conflict=FALSE)
```

```
## Warning: package 'dplyr' was built under R version 3.0.3
```

```r

my_baseball<-tbl_df(my_baseball)

players <- group_by(my_baseball, id)
player_summaries2 <- summarize(players, duration=max(year)-min(year), nteams=length(unique(team)))

player_summaries2
```

```
## Source: local data frame [1,228 x 3]
## 
##           id duration nteams
## 1  aaronha01       22      3
## 2  abernte02       17      7
## 3  adairje01       12      4
## 4  adamsba01       20      2
## 5  adamsbo03       13      4
## 6  adcocjo01       16      5
## 7  agostju01       12      5
## 8  aguilri01       15      4
## 9  aguirha01       15      4
## 10 ainsmed01       14      5
## ..       ...      ...    ...
```

```r

# You can nest these commands in dplyr but it gets messy

player_summaries3 <- summarize(group_by(my_baseball, id), duration=max(year)-min(year), nteams=length(unique(team)))

player_summaries3
```

```
## Source: local data frame [1,228 x 3]
## 
##           id duration nteams
## 1  aaronha01       22      3
## 2  abernte02       17      7
## 3  adairje01       12      4
## 4  adamsba01       20      2
## 5  adamsbo03       13      4
## 6  adcocjo01       16      5
## 7  agostju01       12      5
## 8  aguilri01       15      4
## 9  aguirha01       15      4
## 10 ainsmed01       14      5
## ..       ...      ...    ...
```

```r

# However, with dplyr we can combine steps using the `%.%` operator.  When using the `%.%` operator you don't need to include the name of the data table inside the function call.  (i.e.   "mydata %.% filter(x==10)"  is the same as "filter(mydata, x==10)".  

dplyr_time <- system.time(
  
  player_summaries4 <- my_baseball %.% 
    group_by(id) %.% 
    summarize(duration = max(year) - min(year), nteams = length(unique(team)))
  
  )

player_summaries4
```

```
## Source: local data frame [1,228 x 3]
## 
##           id duration nteams
## 1  aaronha01       22      3
## 2  abernte02       17      7
## 3  adairje01       12      4
## 4  adamsba01       20      2
## 5  adamsbo03       13      4
## 6  adcocjo01       16      5
## 7  agostju01       12      5
## 8  aguilri01       15      4
## 9  aguirha01       15      4
## 10 ainsmed01       14      5
## ..       ...      ...    ...
```

```r

# combare speed of plyr vs dplyr

plyr_time
```

```
##    user  system elapsed 
##    0.69    0.00    0.69
```

```r
dplyr_time
```

```
##    user  system elapsed 
##    0.02    0.00    0.02
```

In other words dplyr was 34.5 times faster than plyr in this case. It really didn't matter in this case, but that difference can be huge if you are using very large datasets.

## dplyr verbs

The dplyr package provides a lot of methods (verbs) for helping to work with data.

### filter()

filter() is equivalent to subset()


```r
# select players from the Seattle Mariniers in 1990
my_baseball %.% filter(team == "SEA" & year == 1990)
```

```
## Source: local data frame [11 x 22]
## 
##           id year stint team lg   g  ab  r   h X2b X3b hr rbi sb cs bb so
## 1  buhneja01 1990     1  SEA AL  51 163 16  45  12   0  7  33  2  2 17 50
## 2  burbada01 1990     1  SEA AL   6   0  0   0   0   0  0   0  0  0  0  0
## 3  colesda01 1990     1  SEA AL  37 107  9  23   5   1  2  16  0  0  4 17
## 4  griffke01 1990     2  SEA AL  21  77 13  29   2   0  3  18  0  0 10  3
## 5  griffke02 1990     1  SEA AL 155 597 91 179  28   7 22  80 16 11 63 81
## 6  jacksmi02 1990     1  SEA AL  63   0  0   0   0   0  0   0  0  0  0  0
## 7  johnsra05 1990     1  SEA AL  33   0  0   0   0   0  0   0  0  0  0  0
## 8  leonaje01 1990     1  SEA AL 134 478 39 120  20   0 10  75  4  2 37 97
## 9  martied01 1990     1  SEA AL 144 487 71 147  27   2 11  49  1  4 74 62
## 10 martiti02 1990     1  SEA AL  24  68  4  15   4   0  0   5  0  0  9  9
## 11 vizquom01 1990     1  SEA AL  81 255 19  63   3   2  2  18  4  1 18 22
## Variables not shown: ibb (int), hbp (int), sh (int), sf (int), gidp (int)
```



### arrange()

arrange() allows you to reorder the data



```r

# order data by team then year then by descending number of runs (r)
my_baseball %.% arrange(team, year, desc(r))
```

```
## Source: local data frame [21,699 x 22]
## 
##           id year stint team lg   g  ab  r   h X2b X3b hr rbi sb cs bb so
## 1  smithge01 1884     1  ALT UA  25 108  9  34   8   1  0  NA  0 NA  1 NA
## 2  edmonji01 1997     1  ANA AL 133 502 82 146  27   0 26  80  5  7 60 80
## 3  phillto02 1997     2  ANA AL 105 405 73 107  28   2  6  48  9  9 73 89
## 4  leyriji01 1997     1  ANA AL  84 294 47  81   7   0 11  50  1  1 37 56
## 5  henderi01 1997     2  ANA AL  32 115 21  21   3   0  2   7 16  4 26 23
## 6  kreutch01 1997     2  ANA AL  70 218 19  51   7   1  4  18  0  2 21 57
## 7  murraed02 1997     1  ANA AL  46 160 13  35   7   0  3  15  1  0 13 24
## 8  finlech01 1997     1  ANA AL   2   6  1   0   0   0  0   0  0  0  0  2
## 9  grosske01 1997     1  ANA AL   1   1  0   0   0   0  0   0  0  0  0  1
## 10  hillke01 1997     2  ANA AL   1   2  0   1   1   0  0   2  0  0  0  1
## ..       ...  ...   ...  ... .. ... ... .. ... ... ... .. ... .. .. .. ..
## Variables not shown: ibb (int), hbp (int), sh (int), sf (int), gidp (int)
```


### select()

select() lets you specify which columns you want to return



```r
# select id, year, team and r only
my_baseball %.% select(id, year, team, r)
```

```
## Source: local data frame [21,699 x 4]
## 
##            id year team  r
## 4   ansonca01 1871  RC1 29
## 44  forceda01 1871  WS3 45
## 68  mathebo01 1871  FW1 15
## 99  startjo01 1871  NY2 35
## 102 suttoez01 1871  CL1 35
## 106 whitede01 1871  CL1 40
## 113  yorkto01 1871  TRO 36
## 121 ansonca01 1872  PH1 60
## 143 burdoja01 1872  BR2 26
## 167 forceda01 1872  TRO 40
## ..        ...  ...  ... ..
```

```r


# select everything but year and team
my_baseball %.% select(-c(year, team))
```

```
## Source: local data frame [21,699 x 20]
## 
##            id stint lg  g  ab  r  h X2b X3b hr rbi sb cs bb so ibb hbp sh
## 4   ansonca01     1    25 120 29 39  11   3  0  16  6  2  2  1  NA  NA NA
## 44  forceda01     1    32 162 45 45   9   4  0  29  8  0  4  0  NA  NA NA
## 68  mathebo01     1    19  89 15 24   3   1  0  10  2  1  2  0  NA  NA NA
## 99  startjo01     1    33 161 35 58   5   1  1  34  4  2  3  0  NA  NA NA
## 102 suttoez01     1    29 128 35 45   3   7  3  23  3  1  1  0  NA  NA NA
## 106 whitede01     1    29 146 40 47   6   5  1  21  2  2  4  1  NA  NA NA
## 113  yorkto01     1    29 145 36 37   5   7  2  23  2  2  9  1  NA  NA NA
## 121 ansonca01     1    46 217 60 90  10   7  0  50  6  6 16  3  NA  NA NA
## 143 burdoja01     1    37 174 26 46   3   0  0  15  0  1  1  1  NA  NA NA
## 167 forceda01     1    25 130 40 53  11   0  0  16  2  2  1  0  NA  NA NA
## ..        ...   ... .. .. ... .. .. ... ... .. ... .. .. .. .. ... ... ..
## Variables not shown: sf (int), gidp (int)
```

```r


# select id through team
my_baseball %.% select(id:team)
```

```
## Source: local data frame [21,699 x 4]
## 
##            id year stint team
## 4   ansonca01 1871     1  RC1
## 44  forceda01 1871     1  WS3
## 68  mathebo01 1871     1  FW1
## 99  startjo01 1871     1  NY2
## 102 suttoez01 1871     1  CL1
## 106 whitede01 1871     1  CL1
## 113  yorkto01 1871     1  TRO
## 121 ansonca01 1872     1  PH1
## 143 burdoja01 1872     1  BR2
## 167 forceda01 1872     1  TRO
## ..        ...  ...   ...  ...
```

```r

```


### mutate()
mutate() allows you to add new columns

```r
# add a runs per game column and select only the id and runs_per_game column
# for return
my_baseball %.% mutate(runs_per_game = r/g) %.% select(id, runs_per_game)
```

```
## Source: local data frame [21,699 x 2]
## 
##           id runs_per_game
## 1  ansonca01        1.1600
## 2  forceda01        1.4062
## 3  mathebo01        0.7895
## 4  startjo01        1.0606
## 5  suttoez01        1.2069
## 6  whitede01        1.3793
## 7   yorkto01        1.2414
## 8  ansonca01        1.3043
## 9  burdoja01        0.7027
## 10 forceda01        1.6000
## ..       ...           ...
```

```r

```

### summarise()
We already showed an example of summarise().  It really needs to be used in conjunction with group_by() to be of much use.  Without group_by() with out it, summarise() returns a single row of results


```r
# calculate the mean number of games played per year across all players
my_baseball %.% summarise(mean_g = mean(g))
```

```
## Source: local data frame [1 x 1]
## 
##   mean_g
## 1  72.82
```


### grouped_by()

Select() and arrange() aren't affected by group_by() but filter(), mutate(), and summarise() are.

For example can group by team and then summarise


```r

my_baseball %.% group_by(team) %.% summarise(mean_g = mean(g))
```

```
## Source: local data frame [132 x 2]
## 
##    team mean_g
## 1   ALT  25.00
## 2   ANA  28.29
## 3   ARI  71.65
## 4   ATL  71.20
## 5   BAL  70.55
## 6   BFN  76.56
## 7   BFP 122.00
## 8   BL1  39.86
## 9   BL2  73.58
## 10  BL3  69.75
## ..  ...    ...
```


## join
If you need to combine data from two tables based on a common field you can use the various join functions. The basic format is like the following...


```r
inner_join(players, player_summaries, by = "id")
```

```
## Source: local data frame [21,699 x 24]
## Groups: id
## 
##           id year stint team lg   g  ab   r   h X2b X3b hr rbi sb cs bb so
## 1  aaronha01 1954     1  ML1 NL 122 468  58 131  27   6 13  69  2  2 28 39
## 2  aaronha01 1955     1  ML1 NL 153 602 105 189  37   9 27 106  3  1 49 61
## 3  aaronha01 1956     1  ML1 NL 153 609 106 200  34  14 26  92  2  4 37 54
## 4  aaronha01 1957     1  ML1 NL 151 615 118 198  27   6 44 132  1  1 57 58
## 5  aaronha01 1958     1  ML1 NL 153 601 109 196  34   4 30  95  4  1 59 49
## 6  aaronha01 1959     1  ML1 NL 154 629 116 223  46   7 39 123  8  0 51 54
## 7  aaronha01 1960     1  ML1 NL 153 590 102 172  20  11 40 126 16  7 60 63
## 8  aaronha01 1961     1  ML1 NL 155 603 115 197  39  10 34 120 21  9 56 64
## 9  aaronha01 1962     1  ML1 NL 156 592 127 191  28   6 45 128 15  7 66 73
## 10 aaronha01 1963     1  ML1 NL 161 631 121 201  29   4 44 130 31  5 78 94
## ..       ...  ...   ...  ... .. ... ... ... ... ... ... .. ... .. .. .. ..
## Variables not shown: ibb (int), hbp (int), sh (int), sf (int), gidp (int),
##   duration (int), nteams (int)
```

```r

# alternatively you can chain this.

players %.% inner_join(player_summaries, by = "id")
```

```
## Source: local data frame [21,699 x 24]
## Groups: id
## 
##           id year stint team lg   g  ab   r   h X2b X3b hr rbi sb cs bb so
## 1  aaronha01 1954     1  ML1 NL 122 468  58 131  27   6 13  69  2  2 28 39
## 2  aaronha01 1955     1  ML1 NL 153 602 105 189  37   9 27 106  3  1 49 61
## 3  aaronha01 1956     1  ML1 NL 153 609 106 200  34  14 26  92  2  4 37 54
## 4  aaronha01 1957     1  ML1 NL 151 615 118 198  27   6 44 132  1  1 57 58
## 5  aaronha01 1958     1  ML1 NL 153 601 109 196  34   4 30  95  4  1 59 49
## 6  aaronha01 1959     1  ML1 NL 154 629 116 223  46   7 39 123  8  0 51 54
## 7  aaronha01 1960     1  ML1 NL 153 590 102 172  20  11 40 126 16  7 60 63
## 8  aaronha01 1961     1  ML1 NL 155 603 115 197  39  10 34 120 21  9 56 64
## 9  aaronha01 1962     1  ML1 NL 156 592 127 191  28   6 45 128 15  7 66 73
## 10 aaronha01 1963     1  ML1 NL 161 631 121 201  29   4 44 130 31  5 78 94
## ..       ...  ...   ...  ... .. ... ... ... ... ... ... .. ... .. .. .. ..
## Variables not shown: ibb (int), hbp (int), sh (int), sf (int), gidp (int),
##   duration (int), nteams (int)
```


If you don't specify a "by" then dplyr will match based on common column names


```r
# two small data frames for the following examples
x <- data.frame(id = c(1, 2, 3, 4, 5, 6), name = c("Fred", "Bob", "Jim", "Ted", 
    "Jane", "Sue"))
y <- data.frame(id = c(1, 2, 5, 6, 7, 8), score = c(78, 84, 92, 83, 45, 93))
```



### inner_join()
inner_join() returns all columns from where the two data frames have matching records.


```r

inner_join(x, y, by = "id")
```

```
##   id name score
## 1  1 Fred    78
## 2  2  Bob    84
## 3  5 Jane    92
## 4  6  Sue    83
```


### left_join()
left_join() returns all columns from the two data frames.  But it returns all the records from the first data frame (the left one) and only those from the second data frame where there is a match


```r

left_join(x, y, by = "id")
```

```
##   id name score
## 1  1 Fred    78
## 2  2  Bob    84
## 3  3  Jim    NA
## 4  4  Ted    NA
## 5  5 Jane    92
## 6  6  Sue    83
```


### semi_join()
semi_join() returns all rows from the first data frame where there are matching values in the second data frame and it only keeps the columns from the first data frame.


```r

semi_join(x, y, by = "id")
```

```
##   id name
## 1  1 Fred
## 2  2  Bob
## 3  5 Jane
## 4  6  Sue
```

### anti_join()
anti_join() returns all the rows from the first data frame where there are no matches in the second data frame and it only keeps the columns in the first data frame.


```r

anti_join(x, y, by = "id")
```

```
##   id name
## 1  4  Ted
## 2  3  Jim
```


## do()

The do() function allows you to apply a function to a table

For example, you can use group_by and then use a plot call within do() to make a plot for each group.



```r


mtcars %.% group_by(gear) %.% do(function(x) {
    qplot(x$wt, x$mpg) + labs(title = paste(min(x$gear), "Gears"))
})
```

```
## Error: could not find function "qplot"
```

I find it easier to create the function first and then call it with do()


```r
car_plot <- function(x) {
    plot(x$wt, x$mpg)
    title(paste(first(x$gear), "Gears"))
}

mtcars %.% group_by(gear) %.% do(car_plot)
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-161.png) ![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-162.png) ![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-163.png) 

```
## [[1]]
## NULL
```




## Homework

Using dplyr, write an R script that imports your data and then manipulate that data using the filter(), group_by(), select(), arrange() and summarise() functions.  Upload the R file to the module's dropbox.




