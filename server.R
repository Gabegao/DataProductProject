data(diamonds)
diamonds$cut <- unclass(diamonds$cut)
diamonds$color <- unclass(diamonds$color)
diamonds$clarity <- unclass(diamonds$clarity)

fit<- lm(price ~ ., data=diamonds)

shinyServer(
  function(input, output) {
    output$carat <- renderPrint({input$carat})
    output$cut <- renderText({
      if(input$cut==1) "Fair"
      else if(input$cut==2) "Good"
      else if(input$cut==3) "Very Good"
      else if(input$cut==4) "Premium"
      else "Ideal"
      })
    output$color <- renderText({
      if(input$color==1) "D"
      else if(input$color==2) "E"
      else if(input$color==3) "F"
      else if(input$color==4) "G"
      else if(input$color==5) "H"
      else if(input$color==6) "I"
      else "J"
      })
    output$clarity <- renderText({
      if(input$clarity==1) "I1"
      else if(input$clarity==2) "SI2"
      else if(input$clarity==3) "SI1"
      else if(input$clarity==4) "VS2"
      else if(input$clarity==5) "VS1"
      else if(input$clarity==6) "VVS2"
      else if(input$clarity==7) "VVS1"
      else "IF"
      })
    output$x <- renderPrint({input$x})
    output$y <- renderPrint({input$y})
    output$z <- renderPrint({input$z})
    output$depth <- renderPrint({input$depth})
    output$table <- renderPrint({input$table})
    
    output$prediction <- renderPrint({as.numeric(coefficients(fit)[1]+
        coefficients(fit)[2]*input$carat+
        coefficients(fit)[3]*as.numeric(input$cut)+
        coefficients(fit)[4]*as.numeric(input$color)+
        coefficients(fit)[5]*as.numeric(input$clarity)+
        coefficients(fit)[6]*input$x+
        coefficients(fit)[7]*input$y+
        coefficients(fit)[8]*input$z+
        coefficients(fit)[9]*input$depth+
        coefficients(fit)[10]*input$table)})
    
    output$modelfit <- renderPrint({summary(fit)})
    output$Modelplot<- renderPlot(plot(fit))
  }
)