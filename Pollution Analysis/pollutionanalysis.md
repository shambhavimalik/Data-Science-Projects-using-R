---
title: "Pollution Analysis"
author: "Shambhavi Malik"
date: "25/08/2020"
output: html_document
---
## Exploring the US Air Pollution dataset
### Synopsis
This project involves exploring the US Air Pollution dataset for fine particulate matter (PM) at 332 locations. We will mainly focus on 2 pollutants sulphate and nitrate.

### Data Processing
The zip file containing the data can be downloaded here:

[specdata.zip (2.4MB)](https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip)

The zip file contains 332 comma-separated-value (CSV) files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. Each file contains data from a single monitor and the ID number for each monitor is contained in the file name. For example, data for monitor 200 is contained in the file "200.csv". 

The file is added to the current working directory.Then we unzip this file and create the directory 'specdata'. Once you have unzipped the zip file, do not make any modifications to the files in the 'specdata' directory. 

```{r ,results='hide'}
unzip("rprog_data_specdata.zip")
setwd("specdata")
library(data.table)
```

In each file you'll notice that there are many days where either sulfate or nitrate (or both) are missing (coded as NA). This is common with air pollution monitoring data in the United States.

### Relevant Variables
Each file contains three variables:

- Date: the date of the observation in YYYY-MM-DD format (year-month-day)
- sulfate: the level of sulfate PM in the air on that date (measured in micrograms per cubic meter)
- nitrate: the level of nitrate PM in the air on that date (measured in micrograms per cubic meter)

### Pollutant Mean
This function calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA. 

```{r ,results='hide'}
pollutantmean <- function(directory, pollutant, id = 1:332)
    {file_list <- list.files(directory, full.names = TRUE) #create a list of files
    dat <- data.frame() #create an empty data frame to accommodate all files
    for (i in id) {
        dat <- rbind(dat, read.csv(file_list[i]))
        #loop through all the files and bind them together row wise into the data frame
    }
    mean(dat[, pollutant], na.rm = TRUE)
    #return the mean of the pollutant across all monitors list
}
```

### Complete
This function reads a directory full of files and reports the number of completely observed cases in each data file. It returns a data frame where the first column is the name of the file and the second column is the number of complete cases. 
```{r, results='hide'}
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
```
### Correlation
This function takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function returns a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function returns a numeric vector of length 0.
```{r,results='hide'}
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
    
```
