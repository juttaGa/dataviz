library(ggplot2)
library(tidyverse)
library(ggmap)
library(fiftystater)

# read and prepare data
ssm <- read.csv("ssm.csv", header=TRUE, sep=",")
ssm[,3:23] <- lapply(ssm[,3:23], factor, levels=c("No Law", "Statutory Ban", "Constitutional Ban", "Legal"))

# set colors 
cols <- c("No Law" = "darkgrey", 
          "Statutory Ban" = "darkgoldenrod1", 
          "Constitutional Ban" = "darkgoldenrod",  
          "Legal" = "green4")

# tidy data for heatmap
ssm.tidy <- ssm %>% gather(Year, Status, -State, -abbrev)
ssm.tidy$Year <- gsub("X", "", ssm.tidy$Year)

# heatmap
ggplot(ssm.tidy, aes(x=Year, y=abbrev, fill=factor(Status, levels=c("No Law", "Statutory Ban", "Constitutional Ban", "Legal")))) + 
  geom_tile(color="white", size=0.8) + 
  scale_fill_manual("", values=cols) + 
  labs(x="", y="") + 
  scale_x_discrete(breaks=c(1995, 2000, 2005, 2010, 2015)) +
  scale_y_discrete(limits=rev(levels(ssm.tidy$abbrev))) +
  theme(legend.position = "top", legend.direction = "horizontal") +
  ggtitle("Legal Status of Same-Sex Marriage by US State and Year")

# map of US States (for shiny app)

# read long/lat for state abbrev

ssm$long <- state.center$x
ssm$long[c(2,11)] <- c(-117.5, -106)

ssm$lat <- state.center$y
ssm$lat[c(2,11)] <- c(28.9, 25.9)

p <- ggplot(ssm, aes(map_id = tolower(State))) + 
    geom_map(aes_string(fill = paste("X", 2001, sep="")), map=fifty_states, color="white") +
    expand_limits(x=fifty_states$long, y=fifty_states$lat) + 
    coord_map("albers", lat0=39, lat1=45) +
    scale_x_continuous(breaks=NULL) + 
    scale_y_continuous(breaks=NULL) + 
    labs(x="", y="") + #fifty_states_inset_boxes() +
    theme(legend.position = "bottom", panel.background = element_blank()) +
    scale_fill_manual("", values=cols, drop=FALSE) +
    geom_text(aes(long, lat, label=abbrev), size=3)



