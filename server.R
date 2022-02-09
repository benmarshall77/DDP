postdata <- mtcars
postdata$cars <- rownames(postdata)
postdata$cyl <- as.factor(postdata$cyl)
postdata$vs <- as.factor(postdata$vs)
postdata$am <- as.factor(postdata$am)
postdata$gear <- as.factor(postdata$gear)
postdata$carb <- as.factor(postdata$carb)

server <- function(input, output) {
   x <- reactive({
      filter(postdata, cars %in% input$cars)[,input$xcol]
   })
   c <- reactive({
      filter(postdata, cars %in% input$cars)[,input$colour]
   })
   
   fit <- reactive({lm(filter(postdata, cars %in% input$cars)$mpg ~ x(), data = postdata)})
   intercept <- reactive({summary(fit())$coefficients[1,1]})
   slope <- reactive({summary(fit())$coefficients[2,1]})
   rsquare <- reactive({summary(fit())$r.squared})
   pvalue <- reactive({summary(fit())$coefficients[2,4]})
   
   output$plot <- renderPlotly(
      plot1 <- plot_ly(
         y = filter(postdata, cars %in% input$cars)$mpg,
         x = x(), 
         type = 'scatter',
         mode = 'markers',
         color = c(),
         text = ~filter(postdata, cars %in% input$cars)$cars) %>%
         layout(yaxis = list(title = "MPG"),
                xaxis = list(title = input$xcol)) %>%
         add_lines(x = x(), y = fitted(fit()),inherit = FALSE, name="fit")
   )
   
   output$intercept <- renderText({ 
      intercept()
   })
   
   output$slope <- renderText({ 
      slope()
   })
   
   output$rsquare <- renderText({ 
      rsquare()
   })
   
   output$pvalue <- renderText({ 
      pvalue()
   })

}
