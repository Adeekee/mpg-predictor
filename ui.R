library(shiny)

shinyUI(fluidPage(

  titlePanel("🚗 Car MPG Predictor"),

  # --- Documentation / Help Panel ---
  wellPanel(
    h4("How to Use This App"),
    p("This app predicts a car's fuel efficiency (MPG — miles per gallon) based on its engine and physical characteristics."),
    tags$ul(
      tags$li(strong("Cylinders:"), " Number of engine cylinders (4, 6, or 8)"),
      tags$li(strong("Horsepower:"), " Engine horsepower (50–340)"),
      tags$li(strong("Weight:"), " Car weight in 1000 lbs (1.5–5.5)"),
      tags$li(strong("Transmission:"), " Automatic or Manual")
    ),
    p("Adjust the sliders and selectors on the left, and the predicted MPG will update instantly on the right."),
    p(em("Model: Linear regression trained on the built-in R ", code("mtcars"), " dataset (32 cars)."))
  ),

  sidebarLayout(
    sidebarPanel(
      h4("Car Specifications"),

      radioButtons("cyl", "Number of Cylinders:",
                   choices = c("4" = 4, "6" = 6, "8" = 8),
                   selected = 4, inline = TRUE),

      sliderInput("hp", "Horsepower:",
                  min = 50, max = 340, value = 110, step = 5),

      sliderInput("wt", "Weight (1000 lbs):",
                  min = 1.5, max = 5.5, value = 3.0, step = 0.1),

      selectInput("am", "Transmission:",
                  choices = c("Automatic" = 0, "Manual" = 1),
                  selected = 0),

      br(),
      actionButton("predict", "Predict MPG", class = "btn-primary btn-lg",
                   width = "100%")
    ),

    mainPanel(
      h3("Prediction Result"),

      uiOutput("mpgResult"),

      br(),
      h4("Where does your car sit?"),
      plotOutput("mpgPlot", height = "320px"),

      br(),
      h4("Model Summary"),
      verbatimTextOutput("modelSummary")
    )
  )
))
