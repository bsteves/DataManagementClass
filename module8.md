ESM 505/ESR 605 : Data Management, Spring 2014

Module 8: Loops and Flow Control 
====================




## If
If statements allow for conditional execution of code


```r
# random number between 1 and 10
x <- sample(10, 1)
print(x)
```

```
## [1] 8
```

```r
guess <- 5

if (guess == x) {
    print("Yes!")
}

if (guess > x) {
    print("too high!")
}

if (guess < x) {
    print("too low!")
}
```

```
## [1] "too low!"
```


## If Else
The else statement lets you specify a chunk of code to run when the if condition isn't met.


```r
coin <- c("Heads", "Tails")

guess <- "Tails"
print(paste("You called", guess))
```

```
## [1] "You called Tails"
```

```r

x <- sample(2, 1)
print(paste("The flip is", coin[x]))
```

```
## [1] "The flip is Heads"
```

```r

if (guess == coin[x]) {
    print("You win!")
} else {
    print("You loose!")
}
```

```
## [1] "You loose!"
```



## Ifelse
The Ifelse() function is a shortcut to an if else statement.  It takes the following form.. ifelse(test, yes, no)


```r
coin <- c("Heads", "Tails")

guess <- "Tails"
print(paste("You called", guess))
```

```
## [1] "You called Tails"
```

```r

x <- sample(2, 1)  #random number 1 to 2
print(paste("The flip is", coin[x]))
```

```
## [1] "The flip is Tails"
```

```r

ifelse(guess == coin[x], "You win!", "You loose!")
```

```
## [1] "You win!"
```


## For Loop

If you need to run a chunk of code a specific number of times you will want to use a `for` loop.  Think.. "For every value in the sequence do the following"


```r

num_of_loops <- 10
for (i in 1:num_of_loops) {
    print(paste("loop number", i))
}
```

```
## [1] "loop number 1"
## [1] "loop number 2"
## [1] "loop number 3"
## [1] "loop number 4"
## [1] "loop number 5"
## [1] "loop number 6"
## [1] "loop number 7"
## [1] "loop number 8"
## [1] "loop number 9"
## [1] "loop number 10"
```


For loops are even more useful when you assign the number of loops based on your data.  For example, you might want a loop for each row of data in your data frame.  The nrow() function returns the number of rows in a data frame.


```r

dat <- read.csv("data/wk1sites.csv")
print(dat)
```

```
##   siteID        site            lake   lat    lon
## 1      1 Boat Ramp A Henry Hagg Lake 45.48 -123.2
## 2      2 Boat Ramp C Henry Hagg Lake 45.49 -123.2
```

```r
for (i in 1:nrow(dat)) {
    print(paste("Latitude:", dat$lat[i], ", Longitude:", dat$lon[i]))
}
```

```
## [1] "Latitude: 45.482414 , Longitude: -123.210945"
## [1] "Latitude: 45.488943 , Longitude: -123.228111"
```



## While
If you need to run a chunk of code a number of times, but you don't know in advance how many times you need to loop through the code you'll want to use a `while` loop.   Think... "While the this condition is still true, do the following."


```r
x <- 0
while (x < 5) {
    x <- rnorm(1) * 5
    print(x)
}
```

```
## [1] -4.563
## [1] -3.199
## [1] 1.887
## [1] -2.817
## [1] -0.1786
## [1] -5.897
## [1] 2.022
## [1] -4.08
## [1] -7.194
## [1] -3.339
## [1] -1.286
## [1] -0.3345
## [1] 2.987
## [1] 2.721
## [1] 5.333
```


## Repeat
A repeat loop is very similar to a while loop. A while loop won't even start if the conditional starts out as false, but a repeat loop will run once first and then check the conditional. You also have to specify when to stop using "break".


```r

repeat {
    x <- rnorm(1) * 5
    print(x)
    if (x > 5) 
        break
}
```

```
## [1] -0.8956
## [1] 7.063
```



## Break and Next
The break statement is used to stop a loop.  The Next statement is used to skip the current loop.  In the following example we will override the normal 10 loops of the for loop from our first example using next and break.


```r

num_of_loops <- 10
for (i in 1:num_of_loops) {
    if (i == 5) 
        next
    if (i > 7) 
        break
    print(paste("loop number", i))
}
```

```
## [1] "loop number 1"
## [1] "loop number 2"
## [1] "loop number 3"
## [1] "loop number 4"
## [1] "loop number 6"
## [1] "loop number 7"
```


Notice that we skipped over loop number 5 using the `next` and stopped at  loop 7 by using `break`.


## Homework

Using your data, provide an R script that loads your data and performs a loop and an if statement on the data.  Load the R script to the dropbox.



