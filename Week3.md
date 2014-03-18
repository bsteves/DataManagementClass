ESM 505/ESR 605 : Data Management, Spring 2014

Week 3: Creating, Importing, & Exporting Data
====================

## 1 Creating Data

### 1.1 Vectors

To create a vector of values in R you use the concatenate "c" function.


```r
# numeric vector
nv <- c(2, 3, 4, 2)
print(nv)
```

```
## [1] 2 3 4 2
```

```r

# character vector
cv <- c("put", "some", "words", "here")
print(cv)
```

```
## [1] "put"   "some"  "words" "here"
```

```r

# logical vector
lv <- c(T, F, F, T)
print(lv)
```

```
## [1]  TRUE FALSE FALSE  TRUE
```


### 1.2 Matrices
The main methods to create matrices are the "matrix" function and the use of the "cbind" or "rbind" functions.

The matrix function takes a vector (creatd with the "c" function) and then provides information on how many rows and/or columns to divide it into.  


```r
mat <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3)
print(mat)
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
```

If you supply a number or rows that doesn't evenly divide the elements of the vector and error will appear. 


```r
matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 2)
```

```
## Warning: data length [9] is not a sub-multiple or multiple of the number
## of rows [2]
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    3    5    7    9
## [2,]    2    4    6    8    1
```


Using cbind or rbind to bind columns or rows will also work.  If the vectors you are binding are of the same class (numeric, character, logical), the resulting matrix will also be that class.  However, if the vectors differ the matrix will defualt to the most compatible type.  


```r

mat2 <- cbind(nv, cv, lv)
print(mat2)
```

```
##      nv  cv      lv     
## [1,] "2" "put"   "TRUE" 
## [2,] "3" "some"  "FALSE"
## [3,] "4" "words" "FALSE"
## [4,] "2" "here"  "TRUE"
```

```r
typeof(mat2)
```

```
## [1] "character"
```

```r

mat3 <- cbind(nv, lv)
print(mat3)
```

```
##      nv lv
## [1,]  2  1
## [2,]  3  0
## [3,]  4  0
## [4,]  2  1
```

```r
typeof(mat3)
```

```
## [1] "double"
```



### 1.3 Data Frames
Most imported data will end up a data frame by default.  However, you can create a data frame from other R objects using the "data.frame" function.  When making a data frame, the data needs to



### 1.4 Lists



## 2 Importing Data

### 2.1 Copy/Paste

### 2.2 Text Files

### 2.3 Database Connection

### 2.4 Other formats (JSON, XML, etc..)

## 3 Exporting Data

### 3.1 Text Files

### 3.2 Database Connection

### 3.3 Other formats (JSON, XML, etc..)

### 3.4 dput function



