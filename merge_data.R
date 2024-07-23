library(dplyr)
library(tidyr)

cfb23 = read.csv("cfb23.csv")
cfb23$year = 2023

cfb23 = cfb23 %>%
  mutate_at(vars(-Team, -Win.Loss, -Time.of.Possession, -Average.Time.of.Possession.per.Game), as.numeric)

cfb22 = read.csv("cfb22.csv")
cfb22$year = 2022
cfb21 = read.csv("cfb21.csv")
cfb21$year = 2021

cfb21 = cfb21 %>%
  mutate_at(vars(-Team, -Win.Loss, -Time.of.Possession, -Average.Time.of.Possession.per.Game), as.numeric)

cfb20 = read.csv("cfb20.csv")
cfb20$year = 2020
cfb19 = read.csv("cfb19.csv")
cfb19$year = 2019

cfb_stats = bind_rows(cfb19, cfb20, cfb21, cfb22, cfb23)

cfb_stats = cfb_stats %>%
  separate(Team, into = c("Team", "Conference"), sep = " \\(|\\)", extra = "drop", fill = "right") %>%
  separate(Win.Loss, into = c('Wins', 'Losses'), sep = '-', extra = "drop", fill = "right") %>%
  filter(Conference %in% c('Big 12', 'SEC', 'Pac-12', 'Big Ten', 'ACC'))


cfb_stats$Team = gsub("\\bSt\\.", "State", cfb_stats$Team)


recruiting = read.csv("recruiting_rankings.csv")

recruiting = recruiting %>%
  mutate(Team = recode(Team, 'USC' = 'Southern California'))



cfb_stats_2 = merge(cfb_stats, recruiting, by = c("Team", "year"))
diff = setdiff(cfb_stats$Team, cfb_stats_2$Team)
print(diff)






