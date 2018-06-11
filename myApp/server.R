library(shiny)
library(plotly)

shinyServer(function(input, output) {
   
  output$plot <- renderPlotly({
    d <- diamonds[diamonds$color   == input$color &
                  diamonds$clarity == input$clarity &
                  diamonds$cut     == input$cut,]
    
    fit <- lm(log(price) ~ log(carat), d)
    
    plot_ly(d, x = ~carat, y = ~price) %>%
    add_markers(x = ~carat, y = ~price, showlegend = FALSE) %>%
    add_lines(y = ~exp(predict(fit)),
            line = list(color = 'rgba(7, 164, 181, 1)'),
            name = "Estimated") 
  })

  output$cut <- renderUI({
    selectInput("cut", "Diamond Cut Quality:", rev(levels(diamonds$cut)))
  })
    
})
