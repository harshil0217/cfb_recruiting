library(dplyr)
cfb_stats = read.csv("cfb23.csv")
cfb_stats$Team = gsub("\\s*\\([^\\)]+\\)", "", cfb_stats$Team)

recruiting = read.csv("recruiting_rankings.csv")

cfb_stats = merge(cfb_stats, recruiting, by = "Team")





