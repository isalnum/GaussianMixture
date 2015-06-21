library(shiny)

generatePoints <- function() {
    mu1 <- runif(1, 5, 12)
    mu2 <- runif(1, 13, 20)
    
    sigma1 <- runif(1, 0.5, 5)
    sigma2 <- runif(1, 0.5, 5)
    
    points <- c(rnorm(200, mu1, sigma1), rnorm(200, mu2, sigma2))
    v$data <- points[points > -1 & points < 26]
}


shinyServer(function(input, output) {
    
    v <- reactiveValues(data = NULL)
    
    generatePoints <- function() {
        mu1 <- runif(1, 5, 12)
        mu2 <- runif(1, 13, 20)
        
        sigma1 <- runif(1, 0.5, 5)
        sigma2 <- runif(1, 0.5, 5)
        
        points <- c(rnorm(200, mu1, sigma1), rnorm(200, mu2, sigma2))
        v$data <- points[points > -1 & points < 26]
    }
    
    observeEvent(input$generateButton, {
        generatePoints()
    })
    
    output$newHist <- renderPlot({
        
        
        if (is.null(v$data)) {
            generatePoints()
        }
        
        user_mu1 <- input$mu1
        user_mu2 <- input$mu2
        user_sigma1 <- input$sigma1
        user_sigma2 <- input$sigma2
        
        
        x <- seq(-1, 26, 0.01)
        g1 <- dnorm(x, user_mu1, user_sigma1)
        g2 <- dnorm(x, user_mu2, user_sigma2)
        
        h <- hist(v$data, breaks = 26, plot = F)
        hist(v$data, breaks = 28, freq = F, ylim = c(0, 0.05 + max(h$density, g1, g2)),
             xlab = "data", main = "Histogram of data")
        
        lines(x, g1, type = "l", col = "red")
        lines(x, g2, type = "l", col = "blue")


        d1 <- dnorm(v$data, user_mu1, user_sigma1)
        d2 <- dnorm(v$data, user_mu2, user_sigma2)
        loglikelihood <- sum(log((0.5 * d1) + (0.5 * d2)))
        

        output$loglikelihood <- renderPrint({loglikelihood}) 

    })
})