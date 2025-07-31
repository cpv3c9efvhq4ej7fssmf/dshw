#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(ggplot2)
library(tidyverse)
library(shinyWidgets)
library(DT)
categoricalvars <- c(2, 8, 9)
continuousvars <- c(1, 3, 4, 5, 6, 7, 10, 11)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    setBackgroundColor("yellow"),
    h1("Homework Assignment", style = "color: red"),
    h2("Christopher Pawlik"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            varSelectInput("discrete", "Select categorical variable", data = mtcars[,categoricalvars]),
            varSelectInput("continuous", "Select a continuous variable", data = mtcars[,continuousvars])
        ),

        # Show a plot of the generated distribution
        mainPanel(
          tabsetPanel(
            type = "pills",
            tabPanel(
              "Data",
              h1("Dataset: mtcars"),
              dataTableOutput("data")
            ),
            tabPanel(
              "Summary",
              h1("Discrete"),
              tableOutput("summary1"),
              h1("Continuous"),
              tableOutput("summary2")
            ),
            tabPanel(
              "Box plot",
              plotOutput("box")
            ),
            tabPanel(
              "Bar chart",
              plotOutput("bar")
            ),
            tabPanel(
              "Histogram",
              plotOutput("hist")
            )
          )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  x1 <- reactive({
    input$discrete
  })
  
  x2 <- reactive({
    input$continuous
  })
  
  output$data <- renderDT({
      mtcars
    })
    
    output$summary1 <- renderPrint({
      summary(mtcars[[x1()]])
    })
    
    output$summary2 <- renderPrint({
      summary(mtcars[[x2()]])
    })
    
    output$box <- renderPlot({
      
    })
    
    output$bar <- renderPlot({
      
    })
    
    output$hist <- renderPlot({})
}

# Run the application 
shinyApp(ui = ui, server = server)
