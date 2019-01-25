library(shiny)

shinyUI(fluidPage(
  
  headerPanel("Legal Status of Same-Sex Marriage in the US from 1995-2015"),
  
  
  fluidRow(
    column(12,
           sliderInput("year", 
                "Year", 
                min=1995, 
                max=2015, 
                sep="",
                value=1995)
  ),
  
  column(12,
    plotOutput("mapPlot", height=960)
  )
  )
  
  
))


