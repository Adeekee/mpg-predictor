# Car MPG Predictor — Shiny App

A Shiny application that predicts a car's fuel efficiency (MPG) using linear
regression on the built-in `mtcars` dataset.

## Files

| File | Purpose |
|------|---------|
| `ui.R` | Shiny UI — inputs, layout, documentation panel |
| `server.R` | Shiny server — model training, prediction, plot |
| `pitch.Rpres` | RStudio Presenter pitch (5 slides) |

## How to Run Locally

```r
install.packages("shiny")   # if not already installed
library(shiny)
runApp(".")                 # from inside the shiny_mpg/ folder
```

## How to Deploy to shinyapps.io

```r
install.packages("rsconnect")
library(rsconnect)

# One-time setup — get your token from https://www.shinyapps.io/admin/#/tokens
rsconnect::setAccountInfo(
  name   = "YOUR-USERNAME",
  token  = "YOUR-TOKEN",
  secret = "YOUR-SECRET"
)

# Deploy
rsconnect::deployApp(appName = "mpg-predictor")
```

## How to Publish the Presentation to RPubs

1. Open `pitch.Rpres` in RStudio
2. Click **Preview** to render it
3. Click the **Publish** button (top-right of the Preview pane)
4. Choose **RPubs** and follow the prompts
5. Copy the `http://` link (not `https://`) for your submission

## App Features

- Radio buttons: cylinder count (4 / 6 / 8)
- Sliders: horsepower (50–340) and weight (1.5–5.5 klbs)  
- Dropdown: transmission type (Automatic / Manual)
- Reactive histogram showing your prediction vs. the mtcars distribution
- 95% confidence interval on every prediction
- Full model summary table
