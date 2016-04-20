library(shiny)
library(datasets)
library(ggplot2)

esoph$alcgp <- gsub("0-39g/day", "0-39", esoph$alcgp)
esoph$tobgp <- gsub("0-9g/day", "0-9", esoph$tobgp)
esoph$alcgp <- as.factor(esoph$alcgp)
esoph$tobgp <- as.factor(esoph$tobgp)
age2534 <- esoph[esoph$agegp=="25-34",]
age3544 <- esoph[esoph$agegp=="35-44",]
age4554 <- esoph[esoph$agegp=="45-54",]
age5564 <- esoph[esoph$agegp=="55-64",]
age6574 <- esoph[esoph$agegp=="65-74",]
age75 <- esoph[esoph$agegp=="75+",]

# Define server logic required to summarize and plot the selected dataset
shinyServer(function(input, output) {
        
        # Return the requested dataset
        datasetInput <- reactive({
                switch(input$dataset,
                       "25-34 years" = age2534, "35-44 years" = age3544, "45-54 years" = age4554,
                       "55-64 years" = age5564, "65-74 years" = age6574, "75+ years" = age75)
        })
        
        # Generate a summary of the dataset
        output$summary <- renderPrint({
                dataset <- datasetInput()
                summary(dataset)
        })
        
        # Show the Chart of the dataset
        output$plot <- renderPlot({
                dataset <- datasetInput()
                g <- qplot(ncases, ncontrols, data=dataset, 
                           facets= tobgp ~ alcgp, color=agegp,
                           xlab="Number of cases", ylab="Number of controls",
                           main = "Smoking, Alcohol (in gm/day) and (O)esophageal Cancer")
                g <- g + geom_point( size=5 )
                
                print(g)
                
        })
})