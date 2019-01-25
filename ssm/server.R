library(shiny)
library(tidyr)
library(ggplot2)
library(ggmap)
library(fiftystater)

shinyServer(function(input, output) {
 
  ssm <- read.csv("ssm.csv", header=TRUE, sep=",")
  ssm[,3:23] <- lapply(ssm[,3:23], factor, levels=c("No Law", "Statutory Ban", "Constitutional Ban", "Legal"))
  
  ssm$long <- state.center$x
  ssm$lat <- state.center$y
  # Hawaii and Alaska
  ssm$long[c(2,11)] <- c(-117.5, -106)
  ssm$lat[c(2,11)] <- c(28.9, 25.9)
  
  cols <- c("No Law" = "darkgrey",  "Statutory Ban" = "darkgoldenrod1", "Constitutional Ban" = "darkgoldenrod", 
            "Legal" = "green4")
  
  ssm.tidy <- ssm %>% gather(Year, Status, -State, -abbrev)
  ssm.tidy$Year <- gsub("X", "", ssm.tidy$Year)
  
  
  output$mapPlot <- renderPlot({
   
      ggplot(ssm, aes(map_id = tolower(State))) + 
      geom_map(aes_string(fill = paste("X", input$year, sep="")), map=fifty_states, color="white") +
      expand_limits(x=fifty_states$long, y=fifty_states$lat) + 
      coord_map("albers", lat0=39, lat1=45) +
      scale_x_continuous(breaks=NULL) + 
      scale_y_continuous(breaks=NULL) + 
      labs(x="", y="") + #fifty_states_inset_boxes() +
      theme(legend.position = "bottom", panel.background = element_blank()) +
      scale_fill_manual("", values=cols, drop=FALSE) +
      geom_text(aes(long, lat, label=abbrev), size=3)
    
  })
  
}) 