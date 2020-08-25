corr <- function(directory, threshold=0)
{
    file_list <- list.files(directory, full.names = TRUE) #create a list of files
    dat <- vector(mode = "numeric", length = 0) #create an empty data frame to accommodate all files
    for (i in 1:length(file_list)) #looping through files
    {
        files<-read.csv(file_list[i]) #read all csv files
        files<-na.omit(files) #omit all the NA rows in the file
        nobs<-nrow(files) #count the rows without NAs
        if (nobs>threshold)
        {
            dat <- c(dat, cor(files$sulfate,files$nitrate))
        }
    }
    dat
}
    