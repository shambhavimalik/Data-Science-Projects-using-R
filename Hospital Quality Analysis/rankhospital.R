rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    #Read the data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    #Create a database for use
    fd <- as.data.frame(cbind(data[, 2], #Hospital name
                              data[, 7], #State 
                              data[, 11], #heart attack
                              data[, 17], #heart failure
                              data[, 23]), #Pneumonia
                        stringsAsFactors = FALSE)
    colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
    
    #Check whether the state value is valid
    if (!state %in% fd[, "state"]) {
        stop("invalid state")
        
    } #Check whether the outcome is valid
    else if (!outcome %in% c("heart attack", "pneumonia", "heart failure")) {
        stop("invalid outcome")
        
    } #Check whether the rank value is numeric
    
    else if (is.numeric(num)) {
        #Extract the data for the called state and outcome
        si <- which(fd[, "state"] == state)
        ts <- fd[si, ]
        ts[, eval(outcome)] <- as.numeric(ts[, eval(outcome)])
        
        #Sort the data frame
        ts <- ts[order(ts[, eval(outcome)], ts[, "hospital"], na.last = NA),]
        #Check whether the called rank exceeds the record number
        output <- ts[, "hospital"][num]}
    
    else if (!is.numeric(num)) {
        
        if (num == "best") {
            output <- best(state, outcome)}
        
        else if (num == "worst") {
            si <- which(fd[, "state"] == state)
            ts <- fd[si, ]
            ts[, eval(outcome)] <- as.numeric(ts[, eval(outcome)])
            ts <- ts[order(ts[, eval(outcome)], ts[, "hospital"], na.last = NA, decreasing = TRUE), ]
            output <- ts[, "hospital"][1]
        }
        
        else {
            stop("invalid rank")}
    }
    return (output)
    
}
