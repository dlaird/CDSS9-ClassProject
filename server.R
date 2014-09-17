library(shiny)
library(car)
data(Wool)

shinyServer(
  function(input,output){
    
    #fit = lm(Wool$cycles ~ Wool$len)
    fit = lm(cycles ~ .,data = Wool)
    
    output$woolPlot <- renderPlot({
      newcycles = 
        fit$coefficients[1] + 
        fit$coefficients[2]*input$newlen + 
        fit$coefficients[3]*as(input$amp,"numeric") + 
        fit$coefficients[4]*as(input$load,"numeric")
      Wool2 = Wool[(Wool$load == input$load) & (Wool$amp == input$amp),]
      plot(Wool2$len,
           Wool2$cycles,
           type = "h",
           lwd = 25,
           col = c(4,3,5),
           main="Cycles Until Failure",
           ylab="Cycles",
           xlab="Specimen Length (mm)",
           ylim = c(0,4000),
           xlim = c(200,400))
      points(input$newlen,
             newcycles,
             pch = 25,
             lwd = 5,
             col = c(6)
      )
      text(220,3800,
           "Projected Cycles =")
      text(260,3800,
           round(newcycles,0))
    })
  }
)
