library(dplyr)
library(tidyr)

#read in 2023 data
cfb23 = read.csv("cfb23.csv")
cfb23$year = 2023

#convert data to numeric
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

#compile data together
cfb_stats = bind_rows(cfb19, cfb20, cfb21, cfb22, cfb23)

#remove non power-5 teams and separate wins and losses into two columns
cfb_stats = cfb_stats %>%
  separate(Team, into = c("Team", "Conference"), sep = " \\(|\\)", extra = "drop", fill = "right") %>%
  separate(Win.Loss, into = c('Wins', 'Losses'), sep = '-', extra = "drop", fill = "right") %>%
  filter(Conference %in% c('Big 12', 'SEC', 'Pac-12', 'Big Ten', 'ACC'))


#replace St. in team names with State
cfb_stats$Team = gsub("\\bSt\\.", "State", cfb_stats$Team)


#read in recruiting rankings
recruiting = read.csv("recruiting_rankings.csv")

#change USC to Southern California to align with the other data set
recruiting = recruiting %>%
  mutate(Team = recode(Team, 'USC' = 'Southern California'))


#merge datasets and check to see if there are any that weren't aligned
cfb_stats_2 = merge(cfb_stats, recruiting, by = c("Team", "year"))
diff = setdiff(cfb_stats$Team, cfb_stats_2$Team)
print(diff)

#write csv to directory
write.csv(cfb_stats_2, "cfb_stats_with_recruiting.csv", row.names = FALSE)






