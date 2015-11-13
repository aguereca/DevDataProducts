library(shiny)
shinyUI(
    pageWithSidebar(
        headerPanel("MPG predictor"),
        sidebarPanel(
            h3('1.- Select a vehicle'),
            selectInput('input_model', 'Models:', row.names(mtcars), size=10, selected = row.names(mtcars)[1],
                        multiple=FALSE, selectize=FALSE),
            h3('2.- What if ...'),
            sliderInput("input_hp", "Gross Horsepower:", min=50, max=500, value=mtcars[1,"hp"], step=10),
            sliderInput("input_wt", "Weight (lb/1000):", min=1.5, max=10, value=mtcars[1,"wt"], step=0.1)
        ),
        mainPanel(
            tabsetPanel(type = "tabs", selected = "Documentation",
                        tabPanel("3.- Prediction",
            uiOutput("header_panel"),
            br(),
            h5("Transmission type:"),
            textOutput("out_am", inline=TRUE),
            h5("Number of cylinders:"),
            textOutput("out_cyl", inline=TRUE),
            h5("Number of gears:"),
            textOutput("out_gear", inline=TRUE),
            h5("Displacement (cu.in.):"),
            textOutput("out_disp", inline=TRUE),
            h5("Weight (lb/1000) (factory):"),
            textOutput("out_wt", inline=TRUE),
            h5("Gross horspower (factory):"),
            textOutput("out_hp", inline=TRUE),
            h5("MPG (factory):"),
            textOutput("out_mpg", inline=TRUE),
            br(),
            h4("Predicted MPG:"),
            h3(textOutput("predicted_mpg")),
            br(),
            h4("Difference:"),
            textOutput("diff_mpg")
                        ),
                        tabPanel("Documentation",
                            includeMarkdown("docs.md")
                        )
            )
        )
    )
)