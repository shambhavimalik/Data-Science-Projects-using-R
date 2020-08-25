best <- function(state, outcome) {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    if (!state %in% outcome_data$State)
    {message("invalid state")}
    else if(outcome == "heart attack") {
        col <- 11
    }
    else if (outcome == "heart failure") {
        col <- 17
    }
    else if (outcome == "pneumonia") {
        col <- 23
    }
    else{stop("invalid outcome")}
    sub<-subset(outcome_data,State==state)
    minmort<-min(as.numeric(sub[,col]),na.rm = TRUE)
    lowestmort<-subset(sub,as.numeric(sub[,col])==minmort)
    output<-lowestmort[,"Hospital.Name"]
    return(output[order(output)])
}