ESM 505/ESR 605 : Data Management, Spring 2014

Week 1: Introduction 
====================

## Course Description and Objectives
This course is designed to explore the concept of reproducible research for environmental sciences. We will cover proper data storage and the use of the R statistical computing environment to manipulate that data for statistical and graphical analysis. A background in a computer language and statistics is a plus but not required.

### What is "Reproducible Research"?
In a very general sense, reproducible research is one of the fundamental aims of science.  When we write a paper we include methods and results sections so that, in theory, other researchers can potentially reproduce and confirm our results.

Lately, the term "Reproducible Research" has been used to really mean "Reproducible Data Analysis".  Every step of data analysis (often in the form of code) is prodvided.. 
* Import, manipulate and transform raw data and meta-data into processed data.   
* Run statistical analysis.
* Create plots and tables.
* Incorporate analysis and plots into a report.

### Benefits of "Reproducible Research".

Many journals currently have data sharing and code sharing policies in place and that number has been increasing in recent years (Stodden et al 2013).  

Even if you aren't planning on publishing in a journal with such policies, there is much to be said about being able to reproduce your own data analysis in as little effort as possible.

#### Example of non-reproducible data analysis
1. Enter raw data into Excel
2. Hand edit data for QA/QC
3. Copy and paste data subsets of data into new worksheet as "processed data" 
4. Do analysis in Excel or export/import data into other analysis software (R, SAS, Sigmaplot, etc..)
5. Point-n-click your way through your analysis
6. Save formatted plots and table output
7. Insert formatted plots and tables into Word Document

**What happens if you obtain new data or find an error in your raw data?**

You start over from step 1  or 2 and spend potentially just as much time as you initially did running your analysis.

#### Example of reproducible data analysis
1. Enter raw data into database, Excel, or CSV files
2. Use R to assist QA/QC
3. Use R to process your data for further analysis
4. Use R to preform statistical and graphical analysis
5. Use R markdown script to incorporate plots and tables into final report
6. Use Pandoc command to convert R markdown into a final report in html, word doc, PDF, etc..
7. Create a master script that combines all of these steps into one.

**What happens now if you get more data or need to change something?**

You edit your data and scripts as needed and rerun the master script.   Yes, you spent a bit more time setting things up initially but now rerunning analyses is trivial.


For an overview of R packages for Reproducible Research see the following CRAN R task view..

[CRAN Task View: Reproducible Research] (http://cran.r-project.org/web/views/ReproducibleResearch.html)


## Data Storage

### Spreadsheets
Microsoft Excel and other spreadsheets (such as Google Speadsheets or Open Office) are probably the most common method for data entry and data sharing.  However, many people use spreadsheets in a way that makes the data practially unusable to others software.

![Example of a bad spreadsheet design](figure/badspreadsheet.jpg)

In this example the spreadsheet is formatted like a data entry sheet and/or reporting table which is fine, unless you need to share the raw data with other software.

A proper data spreadsheet should look more like a database tabale with unique data as rows and variables as columns with the column headers listing those variables.

One other complication to using spreadsheets in this fashion is that there can be incompatibilites based on which version of the spreadsheet software is being used.

### Databases (Microsoft Access, MySQL, PostgreSQL, etc..)
Sometimes data is too big and too complicated to store in a simple spreadsheet.  When this happens databases are needed.   



### CSV (comma seperated values)
Almost every spreadsheet and database can export properly formatted data into CSV files.  Likewise, just about every program used for data analysis can import CSV files.  Because CSV files are simple text files, they are the *lingua franca* of data formats.  However, large amounts of data in text format can take awhile to load.

The following code shows who long it takes to load a 44.6 Mb file with 332,633 rows of data and 13 variables.  


```r
csv_speed <- system.time(data <- read.csv("~/WSA/Data/WSA_data.csv"))
print(csv_speed)
```

```
##    user  system elapsed 
##  19.585   0.316  20.057
```


Here I've wrapped the 'system.time' function call around the 'read.csv' function that loads the data file so that I can time it. This can be useful if you ever want to know how long a particular part of your analysis takes.

### Binary Files (e.g. '.Rdata')
One option to speed this process up in R is to save the data in a binary Rdata file.  This file format compresses the data in such a way that it can be reopened at least 10 times faster then .


```r
save(data, file = "WSA_data.Rdata")
binary_speed <- system.time(load(file = "WSA_data.Rdata"))
print(binary_speed)
```

```
##    user  system elapsed 
##   0.368   0.040   0.422
```


The loading of the binary data file was over 48 times faster than loading the csv file!


### Data Types

#### Vectors
#### Matrices
#### Arrays
#### Data Frames
#### Lists
#### Factors


#### Numeric
#### Iteger
#### Character
#### Date


### Data Format (Wide vs Narrow)

Most people are familiar with the "wide" data format where each row represents an observation and each column represents all the various attributes for that observation.



```r
# loading a useful package for creating formatted tables
library(xtable)
```

```
## Error: there is no package called 'xtable'
```

```r
spdat <- read.csv("wk1spdat.csv")
print(xtable(spdat), type = "html")
```

```
## Error: could not find function "xtable"
```




```r
# loading a package for reshaping data between wide and narrow formats
library(reshape2)

# converting wide format to narrow format
spdat2 <- melt(spdat, id = c("Site", "Date"), variable.name = "Speices", value.name = "Count")
# removing data rows where species counts are 0
spdat2 <- spdat2[spdat2$Count > 0, ]
print(xtable(spdat2), type = "html")
```

```
## Error: could not find function "xtable"
```




### Meta-data






### Citations

[1] Stodden V, Guo P, Ma Z (2013) Toward Reproducible Computational Research: An Empirical Analysis of Data and Code Policy Adoption by Journals. PLoS ONE 8(6): e67111. doi:10.1371/journal.pone.0067111  [link] (http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0067111)






This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **Help** toolbar button for more details on using R Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist    
##  Min.   : 4.0   Min.   :  2  
##  1st Qu.:12.0   1st Qu.: 26  
##  Median :15.0   Median : 36  
##  Mean   :15.4   Mean   : 43  
##  3rd Qu.:19.0   3rd Qu.: 56  
##  Max.   :25.0   Max.   :120
```


You can also embed plots, for example:


```r
plot(cars)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 



```r
x <- 1:10
y <- round(rnorm(10, x, 1), 2)
df <- data.frame(x, y)
df
```

```
##     x     y
## 1   1  1.33
## 2   2  2.38
## 3   3  2.03
## 4   4  4.44
## 5   5  3.28
## 6   6  5.93
## 7   7  5.77
## 8   8  8.65
## 9   9 10.41
## 10 10  8.52
```

## R Code chunk features
### Create Markdown code from R
The following code hides the command input (i.e., `echo=FALSE`), and outputs the content directly as code (i.e., `results=asis`, which is similar to `results=tex` in Sweave).
 
 
    
    ```r
    cat("Here are some dot points\n\n")
    cat(paste("* The value of y[", 1:3, "] is ", y[1:3], sep = "", collapse = "\n"))
    ```

 
Here are some dot points

* The value of y[1] is 1.33
* The value of y[2] is 2.38
* The value of y[3] is 2.03

1, 3, 5, 7, 9
hello

 

 
