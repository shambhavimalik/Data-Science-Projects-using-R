powerDT <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
subpower <- subset(powerDT,Date=="1/2/2007" | Date =="2/2/2007")
datetime <- strptime(paste(subpower$Date, subpower$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
png("plot4.png",width = 480,height = 480)
par(mfrow=c(2,2))

#1st plot
plot(datetime,as.numeric(subpower$Global_active_power),type="l",xlab="",ylab="Global Active Power")

#2nd plot
plot(datetime,as.numeric(subpower$Voltage),type="l",xlab="datetime",ylab="Voltage")

#3rd plot
plot(datetime,as.numeric(subpower$Sub_metering_1),type="l",xlab="",ylab="Energy sub metering")
points(datetime,as.numeric(subpower$Sub_metering_2),type = "l",col="red")
points(datetime,as.numeric(subpower$Sub_metering_3),type = "l",col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"),bty = "n")

#4th plot
plot(datetime,as.numeric(subpower$Global_reactive_power),type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()