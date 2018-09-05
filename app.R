#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(plotly)
library(reshape2)
library(ggplot2)
library(shiny)
library(dplyr)
cars <- mtcars
cars$model <- rownames(mtcars)
cars[c('drat','vs','am','gear','carb')] <-  NULL
meltcars <- melt(cars, id = 'model')
meltcars$model <- as.factor(meltcars$model)

pdf(NULL)

# Define UI for application that draws a histogram
ui <- fluidPage(
   navbarPage(title = "MT Cars NavBar"),
   # Application title
   titlePanel("MTCars Data"),
   
   fluidRow(
       # Sidebar with a slider input for number of bins 
      sidebarLayout(
          # Input x and y for scatterplot
          sidebarPanel(
            # select Y input
             selectInput('y',
                         "Y axis:",
                         choices = colnames(cars),
                         selected = "mpg"),
             selectInput('x',
                         'X axis:',
                         choice = colnames(cars),
                         selected = "wt")
          ),
                     
          # Show a plot of the generated distribution
          mainPanel(
             plotlyOutput("scatterplot")
          )
       )
   ),
   fluidRow()
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$scatterplot <- renderPlotly({
      #generate scatterplot
      ggplotly(ggplot(cars, aes_string(x = input$x, y = input$y))+geom_smooth())
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

