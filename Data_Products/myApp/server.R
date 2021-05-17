#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(lubridate)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    mtcars$mpg_spline <- ifelse(mtcars$mpg - 20> 0, mtcars$mpg -20, 0)
    
    fit.lm1 <- lm(hp~mpg, data = mtcars)
    fit.lm2  <- lm(hp~mpg + mpg_spline, data = mtcars)
    
    lm1.pred <- reactive({
        mpgInp <- input$mpgSlider
        predict(fit.lm1, newdata = data.frame(mpg = mpgInp))
    })
    
    lm2.pred <- reactive({
        mpgInp <- input$mpgSlider
        predict(fit.lm2, newdata = data.frame(mpg = mpgInp, 
                                              mpg_spline = ifelse(mpgInp -20 >0, mpgInp -20, 0) 
                                              )
                )
    })

    output$Plot <- renderPlot({ 
        mpgInp <- input$mpgSlider
        with(mtcars, plot(mpg, hp, xlab = "MPG", ylab = "Horsepower",
                          ylim = c(50,340), xlim = c(10,35) 
                          )
             )
        
        if(input$show_mod1){
            abline(fit.lm1, col = "red", lwd = 2)
        }
        if(input$show_col){
            with(mtcars, plot(mpg, hp, xlab = "MPG", ylab = "Horsepower", pch = 17,
                              ylim = c(50,340), xlim = c(10,35), col = as.factor(mtcars$cyl)
                              )
    
            )
        }
        if(input$show_mod2){
            model2_splines <- predict(fit.lm2, 
                                      newdata = data.frame(mpg = 10:35, 
                                            mpg_spline = ifelse(10:35 -20 >0, 10:35 -20, 0)
                                            )
                                      )
            
        lines(10:35, model2_splines, col = 'blue', lwd = 2)
        
        }
        
        points(mpgInp, lm2.pred(), col = 'blue', pch = 16)
        points(mpgInp, lm1.pred(), col = 'red', pch = 16)
    })

    output$pred1 <- renderText({
        lm1.pred()
        })
    
    output$pred2 <- renderText({lm2.pred()})
    

})
