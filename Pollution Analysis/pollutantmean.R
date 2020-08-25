pollutantmean <- function(directory, pollutant, id = 1:332)
    {file_list <- list.files(directory, full.names = TRUE) #create a list of files
    dat <- data.frame() #create an empty data frame to accommodate all files
    for (i in id) {
        dat <- rbind(dat, read.csv(file_list[i]))
        #loop through all the files and rbind them together into the data frame
    }
    mean(dat[, pollutant], na.rm = TRUE)
    #return the mean of the pollutant across all monitors list
}