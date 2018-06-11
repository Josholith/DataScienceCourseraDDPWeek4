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

  observeEvent(input$show, {
      showModal(modalDialog(
        title = "Documentation",
        HTML("This simple Shiny app is a convenient tool for pricing diamonds. As inputs,
         you will need to choose the specific <b>color</b>, <b>clarity</b>, and <b>cut</b>
         you are interested in.<br><br>For diamonds matching your criteria,
         you will get a 2-d scatterplot that shows the price of those
         diamonds vs. their weight (carats).<br><br>A log-log regression line
         is added so you can predict prices for new weights."),
        easyClose = TRUE
      ))
    })
      
})
