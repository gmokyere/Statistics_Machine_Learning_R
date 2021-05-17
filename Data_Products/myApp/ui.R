#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Mtcars Prediction with splines"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h3('Slide me'),
            sliderInput("mpgSlider",
                        "Choose MPG to predict:",
                        min = 10,
                        max = 40,
                        value = 20),
            
            #numericInput('id1', 'numbers only', 5, 0, 50, step = 5),
            
            #dateInput('date', 'Enter Date'),
            
            checkboxInput('show_mod1', 'Show Model1', value = T),
            checkboxInput('show_mod2', 'Show Model2', value = T),
            checkboxInput('show_col', 'show groups', value = T),
            
            #submitButton('submit')
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3('Summary'),

           h5 ("This Slide contains a splines prediction on a mtcars data. Two models are used to predict
            Horsepower (hp) using mpg as predictor. thus a simple linear regression and splines. 
            
            The Shiny App shows the interactive difference between the two models and also takes a number 
            from the user and predicts it"),
            
            
            h3("How to use the App"),
            h5("- Click on the link to the shiny.oi server
            - Use the first tab to visualize the predictions and second tab for numeric predictions
            - The sidebar panel is for the interactive use "),
    
            tabsetPanel(type = "tabs",
                        tabPanel(title = "Tab1", br(), plotOutput("Plot"),
                                 ),
                        
                        tabPanel(title = "Prediction", br(), 
                                 h4("Model 1 Prediction"), textOutput("pred2"),
                                 
                                 h4("Model 2 prediction"), verbatimTextOutput('pred1')
                        )
                        )
            
            # h4("Model 1 Prediction"),
           # verbatimTextOutput('pred1'),
            
            # h4("Model 2 prediction"),
            
          
            #h3("Day is"),
            #verbatimTextOutput("dat")
        )
    )
))
