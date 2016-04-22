library(shiny)

load("2gram.RData")
load("3gram.RData")
load("4gram.RData")
profanity <- read.csv("profanity.csv", header=FALSE, stringsAsFactors=FALSE)
profanity <- profanity$V1#get column identifier

source('MyProject.R')

shinyServer(function(input, output, session){
        
        
        dataInput <- reactive({
                
                main_predict(input$entry,profanity_csv,bigram_matrix, trigram_matrix,quadgram_matrix)
                
        })  
        
        
        output$text <- renderText({
                dataInput()
                
        })
        
        
        output$sent <- renderText({
                
                user_input <- input$entry
                user_input
        })
        
        
        
        output$word <- renderText({
                paste("Your input:")
                
        })
        
        output$predicted <- renderText({
                paste("Top 5 Predicted words:")
                
        })
        
        
        getPage<-function() {
                return(includeHTML("Note.html"))
        }
        output$readme<-renderUI({getPage()})
        
})