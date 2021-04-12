library(tidyverse)

models <- mtcars %>% 
  split(.$cyl) %>% 
  map(~lm(mpg ~ wt, data = .))

models2 <- mtcars %>% 
  group_by(cyl) %>% group_split() %>% 
  map(~lm(mpg ~ wt, data = .))

  mtcars %>% group_keys(cyl)
  
  
models2 <- mtcars %>% group_by(cyl) %>% group_split() %>% map(~lm(mpg ~ wt, data = .))


a<-mtcars %>%
  group_by(cyl) %>%
  nest() %>%
  mutate(models = map(~lm(mpg ~ wt, data = .)))


a<-mtcars %>% mutate(seq = map(cyl, seq))

mtcars %>% mutate(model = map(~lm(mpg ~ wt, data=.)))




# Method 1: using the name of the list element, similar to dat[[1]]["name"], dat[[2]]["name"], etc
map(dat, "name")

# Method 2: using the `pluck` function
map(dat, pluck("name"))

# Method 3: using the index of the list element
map(dat, 3)


map_dfr(dat,`[`, c("name", "gender", "culture"))


mysd <- function(n){
  mysd <- n^0.5
  return(mysd)
}


