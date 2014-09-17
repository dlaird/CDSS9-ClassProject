library(shiny)
library(car)
data(Wool)

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Wool Strength Estimator"),
    h3("Welcome Wool Producers - Estimate Your Cycles Until Failure Here! "),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar
      sidebarPanel(
        h4("Instructions:"),
        p("Estimate your projected number of Cycles Until Failure given the specimen length of your choice.  Set this slider to your desired speciment length:"),
        sliderInput("newlen", 
                    "Specimen Length:", 
                    min = 200,  max = 400,  value = 250),
        hr(),
        p("You can also adjust the Test Load and Loading Cycle Amplitude from the drop down boxes below.  Your plot will refresh automatically!"),
        selectInput("load", "Test Load (kg):", 
                    choices=unique(Wool$load)),
        hr(),
        selectInput("amp", "Loading Cycle Amplitude (minutes):", 
                    choices=unique(Wool$amp)),
        hr(),
        h5("Note:"),
        p("The vertical bars represent actual laboratory test restuls.  The projection algorithm uses more information than what is displayed on the chart, so your projected results may be higher or lower than the bars. "),
        hr(),
        h5("Attribution:"),
        helpText("Data provided as part of the car package.  The original source is Box and Cox (1964), Journal of the Royal Statistical Society, B26, pp. 211-46")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("woolPlot")  
      )
      
    )
  )
)