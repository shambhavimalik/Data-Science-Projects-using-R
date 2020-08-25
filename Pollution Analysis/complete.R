complete <- function(directory, id = 1:332)
    {file_list <- list.files(directory, full.names = TRUE) #create a list of files
    dat <- data.frame() #create an empty data frame to accommodate all files
    for (i in id) #looping through files
        {files<-read.csv(file_list[i]) #read all csv files
        files<-na.omit(files) #omit all the NA rows in the file
        nobs<-nrow(files) #count the rows without NAs
        dat<-rbind(dat,cbind(i,nobs)) #final dataframe of the result
    }
    dat #return the final dataframe
}
    