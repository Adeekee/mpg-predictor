library(shiny)

shinyServer(function(input, output) {

  # --- Train model once on startup ---
  model <- lm(mpg ~ cyl + hp + wt + am, data = mtcars)

  # --- Reactive prediction ---
  prediction <- eventReactive(input$predict, {
    new_data <- data.frame(
      cyl = as.numeric(input$cyl),
      hp  = input$hp,
      wt  = input$wt,
      am  = as.numeric(input$am)
    )
    pred <- predict(model, newdata = new_data, interval = "confidence")
    list(fit = round(pred[1, "fit"], 1),
         lwr = round(pred[1, "lwr"], 1),
         upr = round(pred[1, "upr"], 1))
  }, ignoreNULL = FALSE)   # run on load with defaults

  # --- Display numeric result ---
  output$mpgResult <- renderUI({
    p <- prediction()
    color <- if (p$fit >= 25) "#27ae60" else if (p$fit >= 18) "#e67e22" else "#e74c3c"
    tagList(
      div(style = paste0("font-size:64px; font-weight:bold; color:", color, ";"),
          paste0(p$fit, " MPG")),
      p(style = "color:#555;",
        paste0("95% Confidence Interval: [", p$lwr, ", ", p$upr, "] MPG"))
    )
  })

  # --- Plot: histogram of mtcars mpg with predicted value marked ---
  output$mpgPlot <- renderPlot({
    p <- prediction()
    hist(mtcars$mpg,
         breaks = 10,
         col    = "#AED6F1",
         border = "white",
         main   = "MPG Distribution in mtcars Dataset",
         xlab   = "Miles Per Gallon",
         ylab   = "Number of Cars",
         xlim   = c(5, 40))
    abline(v = p$fit, col = "#e74c3c", lwd = 3, lty = 2)
    legend("topright",
           legend = paste("Your prediction:", p$fit, "MPG"),
           col    = "#e74c3c",
           lwd    = 3, lty = 2,
           bty    = "n")
  })

  # --- Model summary ---
  output$modelSummary <- renderPrint({
    summary(model)
  })
})
