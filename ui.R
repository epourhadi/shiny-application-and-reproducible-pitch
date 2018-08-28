#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


# Define UI for application
ui <- fluidPage(
  titlePanel("A third order polynomial and its shape by changing its coefficients"),
  
  # Sidebar with a slider input
  sidebarLayout(
    inputPanel(
      sliderInput("ExpansionContraction",
                  "Expansion(close to 0) v.s. Contraction(far from 0)",
                  min = -10,
                  max = +10,
                  step = 1,
                  value = 1),
      sliderInput("xIntercept",
                  "First intercept(shifting)",
                  min = -20,
                  max = 20,
                  step = 1,
                  value = 0),
      sliderInput("yIntercept",
                  "Second intercept(curvature change)",
                  min = -20,
                  max = +20,
                  step = 1,
                  value = 0)
    ),
    # Show a plot of the generated distribution
    mainPanel("In the following graph we study the shape of graph for 
              a polynomial by changing its three coefficients",
      plotOutput("distPlot")
    )
  )
)


# Draws UI