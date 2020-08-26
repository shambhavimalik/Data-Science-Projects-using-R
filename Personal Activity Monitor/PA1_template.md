---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: true
---


## Loading and preprocessing the data

The zip file is in the current working directory which was cloned from GitHub. We first need to unzip the file to access its contents.
After unzipping we read the table activity.csv and store it in the variable data_activity.
See its first few entries using the head command.

```r
unzip("activity.zip")
data_activity <- read.csv("activity.csv")
head(data_activity)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```


## What is mean total number of steps taken per day?

We first form a data set of total steps taken per day using the aggregate function. We ignore the NA values.
View the first few contents of total_step using the head command.

```r
total_step<-aggregate(steps~date,data_activity,sum,na.rm=TRUE)
head(total_step)
```

```
##         date steps
## 1 2012-10-02   126
## 2 2012-10-03 11352
## 3 2012-10-04 12116
## 4 2012-10-05 13294
## 5 2012-10-06 15420
## 6 2012-10-07 11015
```

Now we visualize the data by plotting a histogram.

```r
hist(total_step$steps,breaks= 20,col = "turquoise",xlab = "Total Steps per day",ylab = "Frequency")
```

![](PA1_template_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

We can see the mean of the dataset by using the summary command.
We can also calculate mean and median by using their respective commands.

```r
summary(total_step)
```

```
##      date               steps      
##  Length:53          Min.   :   41  
##  Class :character   1st Qu.: 8841  
##  Mode  :character   Median :10765  
##                     Mean   :10766  
##                     3rd Qu.:13294  
##                     Max.   :21194
```

```r
mean_steps <- mean(total_step$steps)
median_steps <- median(total_step$steps)
mean_steps
```

```
## [1] 10766.19
```

```r
median_steps
```

```
## [1] 10765
```



## What is the average daily activity pattern?
We create a data set of steps according to 5 min intervals and take their average using the aggregate function.
Look at its contents using head command.

```r
meanStepsInterval <- aggregate(steps ~ interval, data_activity, mean)
head(meanStepsInterval)
```

```
##   interval     steps
## 1        0 1.7169811
## 2        5 0.3396226
## 3       10 0.1320755
## 4       15 0.1509434
## 5       20 0.0754717
## 6       25 2.0943396
```

Then we make a time series plot (i.e. \color{red}{\verb|type = "l"|}type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

```r
plot(x=meanStepsInterval$interval, y=meanStepsInterval$steps, type="l",
     main="Time Series Plot of Average Steps Taken per Interval",
     ylab="Number of Steps", xlab="Intervals (in 5 mins)",
     col="darkblue", lwd=1.5)
```

![](PA1_template_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

To find the 5-minute interval for which, on average across all the days in the dataset, contains the maximum number of steps

```r
meanStepsInterval[grep(max(meanStepsInterval$steps), meanStepsInterval$steps), ]
```

```
##     interval    steps
## 104      835 206.1698
```

## Imputing missing values

First we need to calculate total number of missing values in the dataset.

```r
sum(is.na(data_activity$steps))
```

```
## [1] 2304
```

```r
sum(is.na(data_activity$date))
```

```
## [1] 0
```

```r
sum(is.na(data_activity$interval))
```

```
## [1] 0
```

Now we replace the missing values by the mean steps in intervals and create a new data set.

```r
imputedData <- data_activity
for(x in 1:17568) {
    if(is.na(imputedData[x, 1])==TRUE) {
        imputedData[x, 1] <- meanStepsInterval[meanStepsInterval$interval %in% imputedData[x, 3], 2]
    }
}
head(imputedData)
```

```
##       steps       date interval
## 1 1.7169811 2012-10-01        0
## 2 0.3396226 2012-10-01        5
## 3 0.1320755 2012-10-01       10
## 4 0.1509434 2012-10-01       15
## 5 0.0754717 2012-10-01       20
## 6 2.0943396 2012-10-01       25
```


```r
imputedTotalStepsDay <- aggregate(steps ~ date, imputedData, sum)
head(imputedTotalStepsDay)
```

```
##         date    steps
## 1 2012-10-01 10766.19
## 2 2012-10-02   126.00
## 3 2012-10-03 11352.00
## 4 2012-10-04 12116.00
## 5 2012-10-05 13294.00
## 6 2012-10-06 15420.00
```

Now we create a histogram of the new dataset.

```r
hist(imputedTotalStepsDay$steps, breaks=20, xlab="Number of Steps Taken", 
     main="Histogram of Total Number of Steps Taken per Day (With Imputed Values)",
     col="coral")
```

![](PA1_template_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

We can see the mean of the new dataset by using the summary command.
We can also calculate mean and median by using their respective commands.

```r
summary(imputedTotalStepsDay)
```

```
##      date               steps      
##  Length:61          Min.   :   41  
##  Class :character   1st Qu.: 9819  
##  Mode  :character   Median :10766  
##                     Mean   :10766  
##                     3rd Qu.:12811  
##                     Max.   :21194
```

```r
mean_steps_new <- mean(imputedTotalStepsDay$steps)
median_steps_new <- median(imputedTotalStepsDay$steps)
mean_steps_new
```

```
## [1] 10766.19
```

```r
median_steps_new
```

```
## [1] 10766.19
```

Although the results are quite similar the total steps per day increases by imputing the data.
We can compare by plotting graphs of both data set side by side and using the same graph limits.

```r
par(mfrow = c(1, 2))
hist(total_step$steps, breaks=20, xlab="Number of Steps Taken", 
     col="turquoise", ylim=c(0, 20), main=NULL)
hist(imputedTotalStepsDay$steps, breaks=20, xlab="Number of Steps Taken", 
     col="coral", ylim=c(0, 20), main=NULL)
```

![](PA1_template_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

## Are there differences in activity patterns between weekdays and weekends?

We create a new data set by classifying days into weekdays and weekends.

```r
daysData <- imputedData
daysData$days <- weekdays(as.Date(daysData$date))
daysData$weekday <- as.character(rep(0, times=17568))
for(x in 1:17568) {
    if(daysData[x, 4] %in% c("Saturday", "Sunday")) {
        daysData[x, 5] <- "weekend"
    } else {
        daysData[x, 5] <- "weekday"
    }
}
daysData$weekday <- factor(daysData$weekday)
head(daysData)
```

```
##       steps       date interval   days weekday
## 1 1.7169811 2012-10-01        0 Monday weekday
## 2 0.3396226 2012-10-01        5 Monday weekday
## 3 0.1320755 2012-10-01       10 Monday weekday
## 4 0.1509434 2012-10-01       15 Monday weekday
## 5 0.0754717 2012-10-01       20 Monday weekday
## 6 2.0943396 2012-10-01       25 Monday weekday
```

Now we separate the data into 2 data sets according to weekdays.

```r
weekdayData <- daysData[daysData$weekday=="weekday", ]
weekendData <- daysData[daysData$weekday=="weekend", ]
weekdayMean <- aggregate(steps ~ interval, weekdayData, mean)
weekendMean <- aggregate(steps ~ interval, weekendData, mean)
head(weekdayMean)
```

```
##   interval      steps
## 1        0 2.25115304
## 2        5 0.44528302
## 3       10 0.17316562
## 4       15 0.19790356
## 5       20 0.09895178
## 6       25 1.59035639
```

```r
head(weekendMean)
```

```
##   interval       steps
## 1        0 0.214622642
## 2        5 0.042452830
## 3       10 0.016509434
## 4       15 0.018867925
## 5       20 0.009433962
## 6       25 3.511792453
```

Finally we plot for both the data sets.

```r
par(mfrow=c(2, 1),mar=c(4, 4, 3, 2))
plot(weekdayMean$interval, weekdayMean$steps, type="l",
     main="Time Series Plot of Average Steps Taken per Interval, for Weekdays",
     xlab="Intervals (in 5 mins)", ylab="Number of Steps",
     col="steelblue", lwd=1.5, ylim=c(0, 230))
plot(weekendMean$interval, weekendMean$steps, type="l",
     main="Time Series Plot of Average Steps Taken per Interval, for Weekends",
     xlab="Intervals (in 5 mins)", ylab="Number of Steps",
     col="springgreen", lwd=1.5, ylim=c(0, 230))
```

![](PA1_template_files/figure-html/unnamed-chunk-16-1.png)<!-- -->
