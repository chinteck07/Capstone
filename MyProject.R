library(stringr)
library(quanteda)

main_predict <- function(input, profanity_csv, bigram_matrix, trigram_matrix,quadgram_matrix, MaxOutcome=5){
        
        input <- toLower(input)
        input <- tokenize(input,removeNumbers=TRUE, 
                          removePunct=TRUE, 
                          removeTwitter=TRUE,
                          removeHyphens=TRUE,
                          simplify=TRUE,
                          removeSeparators=TRUE,
                          concatenator = " ",
                          verbose=TRUE)
        
        input <- grep("[0-9]", input, value = TRUE, invert=TRUE)
        if(length(input) == 0 ) return('Please Start Typing Words...')
        
        input1 <- paste("^", input[length(input)-2], sep="")
        input2 <- paste(input[length(input)-1], sep="")
        input3 <- paste(input[length(input)], sep="")
        inputquad  <- paste(input1, input2, input3 )
        
        
        predict4 <- quadgram_matrix[ grep(inputquad, quadgram_matrix[1:length(quadgram_matrix)])  ,1:3]
        predict4 <- head(data.frame(predict4), MaxOutcome*2)
        
        if(nrow(predict4) != 0){
                predict4 <- str_split_fixed(predict4$quadgram, " ", 4)
                predict4 <- unique(predict4[,4])
                if (length(predict4) < MaxOutcome ){        
                        return( predict4[ 1:length(predict4)])
                        break;
                }else    
                { return(predict4[ 1:MaxOutcome]) 
                        break;}
        }
        
        inputtri <- paste(paste("^", input2, sep=""), input3)
        predict3 <- trigram_matrix[ grep(inputtri, trigram_matrix[1:length(trigram_matrix)])  ,1:3]
        predict3 <- head(data.frame(predict3), MaxOutcome*2)
        
        if(nrow(predict3) != 0){
                predict3 <- str_split_fixed(predict3$trigram, " ", 3)
                predict3 <- unique(predict3[,3])
                if (length(predict3) < MaxOutcome ){        
                        return( predict3[ 1:length(predict3)])
                        break;
                }else    
                { return(predict3[ 1:MaxOutcome]) 
                        break;}
        }
        
        input2 <- paste("^", input[length(input)], ".", sep="")
        predict2 <- bigram_matrix[ grep(input2, bigram_matrix[1:length(bigram_matrix)]) ,1:3]
        predict2 <- head(data.frame(predict2), MaxOutcome*2)    
        
        if(nrow(predict2) != 0){
                predict2 <- str_split_fixed(predict2$bigram, " ", 2)
                predict2 <- unique(predict2[,2])
                if (length(predict2) < MaxOutcome ){        
                        return( predict2[ 1:length(predict2)])
                        break;
                }else    
                { return(predict2[ 1:MaxOutcome]) 
                        break;}
        }
        
        if(length(input) > 1){
                input1 <- paste("^", input[length(input)-1], ".", sep="")
                predict_bi2 <- bigram_matrix[ grep(input1, bigram_matrix[1:length(bigram_matrix)]) ,1:3]
                predict_bi2 <- head(data.frame(predict_bi2), MaxOutcome*2)  
                
                if(nrow(predict_bi2) != 0){
                        predict_bi2 <- str_split_fixed(predict_bi2$bigram, " ", 2)
                        predict_bi2 <- unique(predict_bi2[,2])
                        if (length(predict_bi2) < MaxOutcome ){        
                                return( predict_bi2[ 1:length(predict_bi2)])
                                break;
                        }else    
                        { return(predict_bi2[ 1:MaxOutcome]) 
                                break;}
                }
        }
        return('Warning: Sorry do try again...')
        
}