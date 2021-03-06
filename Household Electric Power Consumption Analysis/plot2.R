powerDT <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
subpower <- subset(powerDT,Date=="1/2/2007" | Date =="2/2/2007")
datetime <- strptime(paste(subpower$Date, subpower$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
png("plot2.png",width = 480,height = 480)
plot(datetime,as.numeric(subpower$Global_active_power),type="l",xlab="",ylab="Global Active Power(kilowatts)")
dev.off()