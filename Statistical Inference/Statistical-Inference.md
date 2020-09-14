<<<<<<< HEAD
Simulation Exercise
-------------------

Overview

In this we investigate the exponential distribution in R and compare it
with the Central Limit Theorem. The exponential distribution can be
simulated in R with rexp(n, lambda) where lambda is the rate parameter.
The mean of exponential distribution is 1/lambda and the standard
deviation is also 1/lambda. Set lambda = 0.2 for all of the simulations.
We investigate the distribution of averages of 40 exponentials. Note
that we do a thousand simulations.

### Part 1: Show the sample mean and compare it to the theoretical mean distribution

    n <- 40
    Simulations <- 1000
    Lambda <- 0.2

    SampleMean <- NULL
    for(i in 1:Simulations) {
      SampleMean <- c(SampleMean, mean(rexp(n, Lambda)))
    }
    mean(SampleMean)

### Part 2: Show the sample is (via variance) and compare it to the thoretical variance of the distribtution

    Variance <- var(SampleMean)
    Variance

### Part 3: Show that the distribution is appoximately normal

    hist(SampleMean, breaks = n, prob = T, col = "turquoise", xlab = "Means")
    x <- seq(min(SampleMean), max(SampleMean), length = 100)
    lines(x, dnorm(x, mean = 1/Lambda, sd = (1/Lambda/sqrt(n))), pch = 25, col = "black")

    qqnorm(SampleMean)
    qqline(SampleMean, col = "red")

The distribution averages of 40 exponentials is very close to a normal
distribution.

Basic Inferential Data Ananlysis
--------------------------------

We will analyze the ToothGrowth data in the R datasets package.

1.  Load the ToothGrowth data and perform some basic exploratory data
    analysis

<!-- -->

    library(datasets)
    data(ToothGrowth)
    library(ggplot2)

    str(ToothGrowth)

1.  Look at the data set

<!-- -->

    head(ToothGrowth)
    summary(ToothGrowth)

1.  Plotting the data

<!-- -->

    ggplot(data=ToothGrowth, aes(x=as.factor(dose), y=len, fill=supp)) +
        geom_bar(stat="identity") +
        facet_grid(. ~ supp) +
        xlab("Dose(mg)") +
        ylab("Tooth length")

1.  Use confidence intervals and/or hypothesis tests to compare tooth
    growth by supp and dose.

<!-- -->

    hypoth1 <- t.test(len ~ supp, data = ToothGrowth)
    hypoth1$conf.int
    hypoth1$p.value
    hypoth2<-t.test(len ~ supp, data = subset(ToothGrowth, dose == 0.5))
    hypoth2$conf.int
    hypoth2$p.value
    hypoth3<-t.test(len ~ supp, data = subset(ToothGrowth, dose == 1))
    hypoth3$conf.int
    hypoth3$p.value
    hypoth4<-t.test(len ~ supp, data = subset(ToothGrowth, dose == 2))
    hypoth4$conf.int
    hypoth4$p.value

### Conclusion

OJ ensures more tooth growth than VC for dosages 0.5 & 1.0. OJ and VC
gives the same amount of tooth growth for dose amount 2.0 mg/day. For
the entire trail we cannot conclude OJ is more effective that VC for all
scenarios.
=======
Simulation Exercise
-------------------

Overview

In this we investigate the exponential distribution in R and compare it
with the Central Limit Theorem. The exponential distribution can be
simulated in R with rexp(n, lambda) where lambda is the rate parameter.
The mean of exponential distribution is 1/lambda and the standard
deviation is also 1/lambda. Set lambda = 0.2 for all of the simulations.
We investigate the distribution of averages of 40 exponentials. Note
that we do a thousand simulations.

### Part 1: Show the sample mean and compare it to the theoretical mean distribution

    n <- 40
    Simulations <- 1000
    Lambda <- 0.2

    SampleMean <- NULL
    for(i in 1:Simulations) {
      SampleMean <- c(SampleMean, mean(rexp(n, Lambda)))
    }
    mean(SampleMean)

### Part 2: Show the sample is (via variance) and compare it to the thoretical variance of the distribtution

    Variance <- var(SampleMean)
    Variance

### Part 3: Show that the distribution is appoximately normal

    hist(SampleMean, breaks = n, prob = T, col = "turquoise", xlab = "Means")
    x <- seq(min(SampleMean), max(SampleMean), length = 100)
    lines(x, dnorm(x, mean = 1/Lambda, sd = (1/Lambda/sqrt(n))), pch = 25, col = "black")

    qqnorm(SampleMean)
    qqline(SampleMean, col = "red")

The distribution averages of 40 exponentials is very close to a normal
distribution.

Basic Inferential Data Ananlysis
--------------------------------

We will analyze the ToothGrowth data in the R datasets package.

1.  Load the ToothGrowth data and perform some basic exploratory data
    analysis

<!-- -->

    library(datasets)
    data(ToothGrowth)
    library(ggplot2)

    str(ToothGrowth)

1.  Look at the data set

<!-- -->

    head(ToothGrowth)
    summary(ToothGrowth)

1.  Plotting the data

<!-- -->

    ggplot(data=ToothGrowth, aes(x=as.factor(dose), y=len, fill=supp)) +
        geom_bar(stat="identity") +
        facet_grid(. ~ supp) +
        xlab("Dose(mg)") +
        ylab("Tooth length")

1.  Use confidence intervals and/or hypothesis tests to compare tooth
    growth by supp and dose.

<!-- -->

    hypoth1 <- t.test(len ~ supp, data = ToothGrowth)
    hypoth1$conf.int
    hypoth1$p.value
    hypoth2<-t.test(len ~ supp, data = subset(ToothGrowth, dose == 0.5))
    hypoth2$conf.int
    hypoth2$p.value
    hypoth3<-t.test(len ~ supp, data = subset(ToothGrowth, dose == 1))
    hypoth3$conf.int
    hypoth3$p.value
    hypoth4<-t.test(len ~ supp, data = subset(ToothGrowth, dose == 2))
    hypoth4$conf.int
    hypoth4$p.value

### Conclusion

OJ ensures more tooth growth than VC for dosages 0.5 & 1.0. OJ and VC
gives the same amount of tooth growth for dose amount 2.0 mg/day. For
the entire trail we cannot conclude OJ is more effective that VC for all
scenarios.
>>>>>>> 5ed7cd07d1857c57182d7ed5895866a2b82459f9
