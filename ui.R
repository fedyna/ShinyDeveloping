library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
        
        # Application title.
        titlePanel("Influence of Alcohol and Tobacco consumption on esophageal cancer"),
        
        # Sidebar with controls to select a dataset and specify the
        # number of observations to view. The helpText function is
        # also used to include clarifying text. Most notably, the
        # inclusion of a submitButton defers the rendering of output
        # until the user explicitly clicks the button (rather than
        # doing it immediately when inputs change). 
        
        sidebarLayout(
                sidebarPanel(
                        selectInput("dataset", "Choose the age of the investigated categories:", 
                                    choices = c("25-34 years", "35-44 years", "45-54 years", "55-64 years", "65-74 years", "75+ years")),
                        
                        helpText("Note: ColumNames in the dataset: (agegp) - Age group, 
                                 (alcgp) - Alcohol consumption, (tobgp) - Tobacco consumption,
                                 (ncases) - Number of cases, (ncontrols) - Number of controls"),
                        
                        
                        submitButton("Update View")
                ),
                
                # Show a summary of the dataset and Chart with the
                # relative to age group. 
                mainPanel(
                        h4("Summary"),
                        verbatimTextOutput("summary"),
                        
                        h4("Chart"),
                        plotOutput("plot")
                )
        )
))