library(shiny)



shinyUI(fluidPage(theme = "bootstrap.css",
                  
                  titlePanel("Data Science Capstone: SwiftKey Word Prediction"),
                  
                  
                  sidebarPanel(                  
                          
                          textInput("entry",       
                                    h5("Please start to type the sentence at below:"),
                                    "Great to come")
                          
                          
                  ),              
                  
                  mainPanel(              
                          textOutput('word'),          
                          h4(textOutput('sent'),style = "color:blue"), 
                          textOutput('predicted'),
                          h4(textOutput('text'),style = "color:blue"),        
                          h4('About This Shiny App', style = "color:white"),
                          htmlOutput("readme")
                  )              
                  
                  
                  
                  
                  
                  
))