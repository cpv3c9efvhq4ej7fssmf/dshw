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
categoricalvars <- c(2, 8, 9)
continuousvars <- c(1, 3, 4, 5, 6, 7, 10, 11)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Homework Assignment"),

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
              plotOutput("plot1")
            ),
            tabPanel(
              "Summary",
              plotOutput("plot2")
            ),
            tabPanel(
              "Box plot",
              plotOutput("plot3")
            ),
            tabPanel(
              "Bar",
              plotOutput("plot4")
            ),
            tabPanel(
              "Histogram",
              plotOutput("plot5")
            )
          )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
