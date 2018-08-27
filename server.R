#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# in the following we give the function for caluclating parabola
calculateParabola <- function(x, ExpansionContraction, xIntercept, yIntercept) {
  y <- ExpansionContraction * (xIntercept - x)^3 +x*(yIntercept) 
  data.frame(x=x, y=y)
}

# Define server logic required to design our shinyapp
serverLogic <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    xIntercept <- input$xIntercept
    yIntercept <- input$yIntercept
    ExpansionContraction <- input$ExpansionContraction
    
    normalParabola <- calculateParabola(seq(-10,10,by=0.1),
                                        ExpansionContraction = 1,
                                        xIntercept = 0,
                                        yIntercept = 0)
    
    normalParabolaVertex <- calculateParabola(0,
                                              ExpansionContraction = 1,
                                              xIntercept = 0,
                                              yIntercept = 0)
    
    parabola <- calculateParabola(seq(-10,10,by=0.1),
                                  ExpansionContraction = ExpansionContraction,
                                  xIntercept = xIntercept,
                                  yIntercept = yIntercept)
    
    parabolaVertex <- calculateParabola(0+xIntercept,
                                        ExpansionContraction = ExpansionContraction,
                                        xIntercept = xIntercept,
                                        yIntercept = yIntercept)
    
    # draw the plot  
    ggplot() +
      ggtitle(paste0("y = ",
                     ExpansionContraction, "*(", 
                     xIntercept, 
                     "-x)^3+","x","*(", 
                     yIntercept,
                     ")")) + 
      coord_cartesian(xlim = c(-10, 10), 
                      ylim = c(-10, 10)) +
      geom_line(data=normalParabola, aes(x=x, y=y), 
                size=2, 
                color="black", 
                alpha=0.3) + 
      geom_vline(data=normalParabolaVertex, 
                 aes(xintercept = x), 
                 size=2
                 , 
                 color="black", 
                 alpha=0.3) +
      geom_hline(data=normalParabolaVertex, 
                 aes(yintercept=y), 
                 size=2, 
                 color="black", 
                 alpha=0.3) +
      geom_point(data=normalParabolaVertex, 
                 aes(x=x, y=y), 
                 size=6, 
                 shape = 4,
                 color="black", 
                 alpha=0.3) +
      geom_line(data=parabola, 
                aes(x=x, y=y), 
                size=1,
                color="blue") + 
      geom_vline(data=parabolaVertex, 
                 aes(xintercept = x),
                 colour = "red") +
      geom_hline(data=parabolaVertex, 
                 aes(yintercept=y),
                 colour = "red") +
      geom_point(data=parabolaVertex, 
                 aes(x=x, y=y), 
                 size = 5, 
                 shape = 4,
                 colour = "red")
    
  }, height = 300, width = 300)
  
}

# Add serverLogic
shinyServer(serverLogic)