library(dplyr)
library(tidyr)
cfb_stats = read.csv("cfb23.csv")

cfb_stats = cfb_stats %>%
  separate(Team, into = c("Team", "Conference"), sep = " \\(|\\)", extra = "drop", fill = "right") %>%
  filter(Conference %in% c('Big 12', 'SEC', 'Pac-12', 'Big Ten', 'ACC'))


cfb_stats$Team = gsub("\\bSt\\.", "State", cfb_stats$Team)


recruiting = read.csv("recruiting_rankings.csv")

recruiting = recruiting %>%
  mutate(Team = recode(Team, 'USC' = 'Southern California'))



cfb_stats_2 = merge(cfb_stats, recruiting, by = "Team")
diff = setdiff(cfb_stats$Team, cfb_stats_2$Team)
print(diff)






