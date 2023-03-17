library(tidyverse)
library(infer)
library(openintro)

# df <- read.csv("df.csv") %>%
#   subset(Residency == "SUM") %>%
#   subset(Deer.Species %in% c('md', 'wt')) %>%
#   mutate( row.number = row_number(), .before = Hunting.District) %>%
#   filter( row.number <= 327) %>%
#   select( c(3,4,9:12,15,16)) %>%
#   rename( district = Hunting.District,  
#           species = Deer.Species,
#           harvest = Total.Harvest,
#           bucks = Bucks,  
#           does = Does,  
#           fawns = Fawns,  
#           smallBucks = Less.than.4.Points,
#           bigBucks = X4.or.More.Points) %>%
#   mutate( distKnown = if_else(str_sub(district, start = 2) == "XX", FALSE, TRUE)) %>%
#   subset(distKnown == TRUE) %>%
#   select(1:8)

#view(df)

#write.csv(df, "mtDeerHunt2020.csv", row.names = FALSE)

df <- read.csv("mtDeerHunt2020.csv")

df2 <- df %>% 
  mutate( harvest2 = bucks + does + fawns, 
          bucks2 = smallBucks + bigBucks, .after = harvest)

mule <- subset(df, species == 'md')
white <- subset(df, species == 'wt')

byDistrict <- df %>%
  group_by(district) %>%
  summarize(
    total = sum(harvest), 
    bucks = sum(bucks),
    smallBucks = sum(smallBucks),
    bigBucks = sum(bigBucks), 
    propBucks = bucks / total, 
    probBigBucks = bigBucks / bucks
  )

region1 <- subset(byDistrict, district < 200)

region1 <- subset(region1, total>100 )

test = chisq.test( x = region1[,4:5], correct = FALSE)
