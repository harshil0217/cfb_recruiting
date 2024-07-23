library(dplyr)
cfb_stats = read.csv("cfb23.csv")
cfb_stats$Team = gsub("\\s*\\([^\\)]+\\)", "", cfb_stats$Team)
cfb_stats$Team <- gsub("\\bSt\\.\\b", "State", cfb$Team)

cfb_stats = cfb_stats %>%
  mutate(Team = recode(Team, "App State" = "Appalachian State",
                       ))

recruiting = read.csv("recruiting_rankings.csv")

cfb_stats_2 = merge(cfb_stats, recruiting, by = "Team")







