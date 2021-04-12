library(tidyverse)
library(broom)

# Need new data to work with.  Maybe from a package.
# should fix issue #3.

wsa <- read_csv("data/WSA_data.csv")


wsa %>% count(Vessel_Type, sort=TRUE, name='type_count')


# summarize to create a new column with t_test results as a list
#tidy it up using broom
#plot error bars from t_test

wsa %>% group_by(Vessel_Type) %>%
  summarize(t_test = list(t.test(Nrt))) %>%
  mutate(tidied = map(t_test, tidy)) %>%
  unnest(tidied) %>%
  ggplot(aes(estimate, Vessel_Type)) + 
  geom_errorbarh(aes(xmin=conf.low, xmax=conf.high)) + 
  labs(y="")




# David Robinson's Favorite Plot
# ordered horizontal bar plot of counts

wsa %>% count(Arrival_Bioregion) %>%
  filter(!is.na(Arrival_Bioregion)) %>%
  mutate(Arrival_Bioregion = fct_reorder(Arrival_Bioregion, n)) %>%
  ggplot(aes(Arrival_Bioregion, n)) + 
  geom_col() + 
  coord_flip()




wsa %>%
  mutate(Arrival_Port = fct_infreq(Arrival_Port), 
         Arrival_Port = fct_lump(Arrival_Port, 5)) %>%
  count(Arrival_Port) %>%
  ggplot(aes(Arrival_Port, n)) + 
  geom_col() + 
  coord_flip()


# Crossing from Tidyr (like expand.grid)

bay <- c("Tillamook","Netarts","Siletz")
site <- c(1,2,3)
months <- c("Jan","Feb","Mar")

crossing(bay, site, months)
