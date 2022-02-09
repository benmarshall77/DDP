library(shiny)
library(plotly)
library(magrittr)
library(dplyr)
library(datasets)

ui <- fluidPage(
   headerPanel('Exploring fuel efficiency'),
   sidebarPanel(
      selectInput('xcol','MPG by...', names(mtcars)[-c(1,2,8,9,10,11)],
                  selected = names(mtcars)[[6]]),
      selectInput('colour', 'Colour by:', names(mtcars)[-c(1,3,4,5,6,7)],
                  selected = names(mtcars)[[2]]),
      h4("Regression Line:"),
      h5("Intercept:",textOutput('intercept', inline = TRUE)),
      h5("Slope:",textOutput('slope', inline = TRUE)),
      h5("R-Square:",textOutput('rsquare', inline = TRUE)),
      h5("p = ",textOutput('pvalue', inline = TRUE)),
      h4("_________"),
      h4("Variables:"),
      h5("mpg=  Miles/(US) gallon"),
      h5("cyl=  Number of cylinders;"),
      h5("disp= Displacement (cu.in.);"),
      h5("hp=	Gross horsepower;"),
      h5("drat=	Rear axle ratio;"),
      h5("wt=	Weight (1000 lbs);"),
      h5("qsec=	1/4 mile time;"),
      h5("vs=	Engine (0 = V-shaped, 1 = straight);"),
      h5("am=	Transmission (0 = automatic, 1 = manual);"),
      h5("gear=	Number of forward gears;"),
      h5("carb=	Number of carburetors.")),
   mainPanel(
      plotlyOutput('plot'),
      checkboxGroupInput('cars', 'Show me:', c(sort(row.names(mtcars))), selected = c(row.names(mtcars)), inline = TRUE)
)
)
