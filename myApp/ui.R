library(shiny)
library(plotly)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Diamond Pricing App"),
  
  # Sidebar with widgets to choose diamond color/clarity/cut 
  sidebarLayout(
    sidebarPanel(
       selectInput("color",
                   "Diamond Color:",
                   c("D - Colorless" = "D",
                     "E - Colorless" = "E",
                     "F - Colorless" = "F",
                     "G - Near Colorless" = "G",
                     "H - Near Colorless" = "H",
                     "I - Near Colorless" = "I",
                     "J - Near Colorless" = "J")),
       selectInput("clarity",
                   "Diamond Clarity:", 
                   c("IF - Internally Flawless" = "IF",
                     "VVS1 - Very, Very Slightly Included" = "VVS1",
                     "VVS2 - Very, Very Slightly Included" = "VVS2",
                     "VS1 - Very Slightly Included" = "VS1",
                     "VS2 - Very Slightly Included" = "VS2",
                     "S1 - Slightly Included" = "S1",
                     "S2 - Slightly Included" = "S2",
                     "I1 - Included" = "I1")),
       uiOutput('cut'),
       strong("Documentation"),
       actionButton("show", "Show")
    ),
    
    # Show a scatterplot of diamond price vs. (carat) weight
    # and include a regression line.
    mainPanel(
       plotlyOutput("plot")
    )
  )
))
