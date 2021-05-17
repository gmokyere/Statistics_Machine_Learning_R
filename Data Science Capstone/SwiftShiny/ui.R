#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(shinyWidgets)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Text Prediction"),
    
    
    setBackgroundColor(
        color = c("#F7FBFF", "#2171B5"),
        gradient = "linear",
        direction = "bottom"
    ),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
            textInput("text", label = "Type inside here", value = "How are"),
            submitButton(text = "Submit"),
            helpText("Click submit when done")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(

            tabsetPanel(type = "tabs",
                        
                        tabPanel(title = "Prediction", br(), 
                                 h4("Model 1 Prediction"), verbatimTextOutput("predict") 
                                 ),
                                 
                        tabPanel(title = "Bi-gram plot", br(), plotOutput("plot"),
                        ),
                        
                        tabPanel(title = "Tri-gram plot", br(), plotOutput("trigram"),
                        )
                        
                        
                       
            )
            
        )
    )
))
