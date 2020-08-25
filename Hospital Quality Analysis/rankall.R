rankall <- function(outcome, num = "best") {
    #Load the data
    data <- read.csv("outcome-of-care-measures.csv",
                     colClasses = "character")
    
    #Check whether the outcome value is valid
    
    if (!(outcome %in% c("heart attack", "heart failure",
                         "pneumonia"))){
        stop ("invalid outcome")}
    if (is.numeric(num) == TRUE) {
        if (length(data[,2]) < num) {return(NA)}
    }
    
    colnum <-
        if (outcome == "heart failure") {17}
    else if (outcome == "heart attack") {11}
    else {23}
    
    data[, colnum] <- as.numeric(data[, colnum])
    data[, 2] <- as.character(data[, 2])
    
    #Create an empty vector
    output <- vector()
    
    #Get a complete list of states
    states <- levels(factor(data[, 7]))
    
    for (i in 1:length(states)) {
        statedata <- subset(data, State == states[i])
        selected_columns <- as.numeric(statedata[, colnum])
        statedata <- statedata[!(is.na(selected_columns)), ] 
        orderdata <- statedata[order(statedata[, colnum], 
                                     statedata[, 2]), ]
        
        
        if (num == "best") {
            ranknum = 1
        }else if (num == "worst") {
            ranknum = nrow(orderdata)
        }else {
            ranknum = num
        }
        hospital <- orderdata[ranknum, 2]
        
        output <- append(output, c(hospital, states[i]))}
    
    
    
    #Convert the output from vector to data frame
    output <- as.data.frame(matrix(output, length(states), 
                                   2, byrow = TRUE))
    colnames(output) <- c("hospital", "state")
    rownames(output) <- states
    
    return(output)
}
