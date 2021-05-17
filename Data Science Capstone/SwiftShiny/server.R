#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(shinyWidgets)
library(tidyverse)
library(tidyr)
source("NLP.R")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    pred <- reactive({ 
        ngrams(input$text)
    } )
    
    
    output$predict <- renderText({
        pred()
    })
    
    output$plot <- renderPlot({
        gg1
    })
    
    output$trigram <- renderPlot({
        gg2
    })
    
    
})
