## r/dataisbeautiful challenge
## 2018 - 01
library(ggplot2)
library(ggthemr)

## read and prepare the data 
algae <- read.csv("algae/algae.csv", sep=";")
algae$temp <- as.factor(algae$temp)
algae$lux <- as.factor(algae$lux)

# set ggthemr "dust"
ggthemr("dust")

ggplot(algae, aes(x=temp, y=value, color=lux, group=lux)) +
  geom_point(size=2) +
  geom_line(size=1) + 
  facet_wrap( ~ species, nrow = 6) +
  labs(
    x = "Temperature (°C)", 
    y = "Divisions per day",
    color = "Light intensity (lux)") +
  ggtitle("Growth Rates of Algae") +
  theme(legend.position = "bottom", legend.direction = "horizontal")

# reset ggthemr
ggthemr_reset()
