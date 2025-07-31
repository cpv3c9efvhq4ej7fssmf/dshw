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
categoricalvars <- c(2, 8, 9) # vector to select only the categorical variables
continuousvars <- c(1, 3, 4, 5, 6, 7, 10, 11) # selects only the continuous variables


# Define UI, app layout
ui <- fluidPage(

    # Application title
    setBackgroundColor("yellow"),
    h1("Homework Assignment", style = "color: red"),
    h2("Christopher Pawlik"),

    # Sidebar with drop-down selectors for discrete and continuous variables
    sidebarLayout(
        sidebarPanel(
            varSelectInput("discrete", "Select categorical variable", data = mtcars[,categoricalvars]), # uses selection vector specified above
            varSelectInput("continuous", "Select a continuous variable", data = mtcars[,continuousvars])
        ),

        # Define tabs
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
              h3("Box plot of selected continuous variable, grouped by discrete variable"),
              plotOutput("box")
            ),
            tabPanel(
              "Bar chart",
              h3("Bar chart of selected discrete variable"),
              plotOutput("bar")
            ),
            tabPanel(
              "Histogram",
              h3("Bar chart of selected continuous variable"),
              plotOutput("hist")
            )
          )
        )
    )
)

# Define server logic required to draw plots and tables
server <- function(input, output) {

  x1 <- reactive({ #specify reactive variables
    input$discrete
  })
  
  x2 <- reactive({
    input$continuous
  })
  
  output$data <- renderDT({
      mtcars
    })
    
    output$summary1 <- renderPrint({ # used renderPrint, renderTable would not work for some reason
      summary(mtcars[[x1()]])
    })
    
    output$summary2 <- renderPrint({
      summary(mtcars[[x2()]])
    })
    
    output$box <- renderPlot({
      ggplot(mtcars, aes(x = as.factor(mtcars[[x1()]]), y = mtcars[[x2()]])) +
        geom_boxplot(color = "red") +
        labs(x = print(x1()), y = print(x2()))
    })
    
    output$bar <- renderPlot({
      ggplot(mtcars, aes(x = as.factor(mtcars[[x1()]]))) +
        geom_bar(fill = "white", color = "red") +
        labs(x = print(x1()))
    })
    
    output$hist <- renderPlot({
      ggplot(mtcars, aes(x = mtcars[[x2()]])) +
        geom_histogram(fill = "white", color = "red") +
        labs(x = print(x2()))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
