library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Fitting the Gaussian Mixture"),
    
    sidebarPanel(
        actionButton("generateButton","Generate new data"),    
        
        sliderInput("mu1", "mu1:", 
                    min = 0, max = 25, value = 10, step= 0.1),
        
        sliderInput("mu2", "mu2:", 
                    min = 0, max = 25, value = 20, step= 0.1),
        
        sliderInput("sigma1", "sigma1:", 
                    min = 0.5, max = 5, value = 1, step= 0.1),
        
        sliderInput("sigma2", "sigma2:", 
                    min = 0.5, max = 5, value = 1, step= 0.1),
        
        helpText("Task: There are 400 points generated from a mixture of two Guassians.
                 Your task is to set their means and standard deviations in such a way 
                 that the log likelihood is maximum. For simplicity, the mixing coefficients are equal to 0.5.")
    ),
    
    mainPanel(
        plotOutput('newHist'),
        h4('Log likelihood:'),
        verbatimTextOutput("loglikelihood")
    )
))