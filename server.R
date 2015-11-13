library(shiny)

tidy_data <- function() {
    cars_data <- mtcars
    # Defined factor columns
    cars_data$cyl <- factor(cars_data$cyl)
    cars_data$vs <- factor(cars_data$vs)
    cars_data$am <- factor(cars_data$am)
    levels(cars_data$am) <-c ("automatic", "manual")
    cars_data$gear <- factor(cars_data$gear)
    cars_data$carb <- factor(cars_data$carb)
    cars_data
}

model_fit <- function(cars_data) {
    full <- glm(mpg~., cars_data, family="gaussian") # Linear model across all dimentions
    step(full, direction="both") # Identify the most influential confounders.
}



shinyServer(
    function(input, output, clientData, session) {
        data <- tidy_data()
        copy_data <- data
        fit <- model_fit(data)
        predicted <- predict(fit, data)
        last_selected <- ""
        last_predicted <- 0
        #print(summary(fit)$coefficients)
        #print(cbind(data[,c("mpg")], predicted, data$mpg - predicted))
        
        observe({
            model <- input$input_model
            if (model != last_selected) {
                updateSliderInput(session, "input_hp", value=data[model,"hp"])
                updateSliderInput(session, "input_wt", value=data[model,"wt"])
                output$out_am <- renderText(levels(data$am)[data[model, "am"]])
                output$out_cyl <- renderText(data[model, "cyl"])
                output$out_gear <- renderText(data[model, "gear"])
                output$out_disp <- renderText(data[model, "disp"])
                output$out_hp <- renderText(data[model, "hp"])
                output$out_wt <- renderText(data[model, "wt"])
                output$out_mpg <- renderText(data[model, "mpg"])
                last_selected <- model
            }
        })
        
        output$header_panel <- renderUI(headerPanel(input$input_model))
        output$coefs <- renderPrint({summary(fit)$coefficients})
        output$predicted_mpg <- renderText({
            model <- input$input_model
            copy_data[model,"hp"] <- input$input_hp
            copy_data[model,"wt"] <- input$input_wt
            #print(copy_data[model,])
            last_predicted <- predict(fit, copy_data)[model]
            output$diff_mpg <- renderText({round(last_predicted - data[model,"mpg"], 2)})
            round(last_predicted, 2)
        })
    }
)