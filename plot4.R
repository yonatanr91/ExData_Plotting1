#check if file exists, if not, download and unzip
if(!file.exists("household_power_consumption.txt")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile="C:/Users/yrafael/Desktop/Data Science Course/Course Code/household_power_consumption.zip")
        unzip("household_power_consumption.zip")
}

#download data sets
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

#clean data set
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data2 <- subset(data, Date == "2007/2/1" | Date == "2007/2/2")
data2$DateTime <- paste(data2$Date, data2$Time)
data2$DateTime <- as.POSIXct(paste(data2$Date, data2$Time))

#start png file creation
png(filename = "plot4.png", width = 480, height = 480)

#plot4 code
par(mfcol = c(2,2))
#top left
plot(data2$DateTime, data2$Global_active_power, xlab = '', ylab = 'Global Active Power', type = 'l')
#bottom left
plot(data2$DateTime, data2$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
points(data2$DateTime, data2$Sub_metering_2, col = "red", type = "l")
points(data2$DateTime, data2$Sub_metering_3, col = "blue", type = "l")
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n")
#top right
plot(data2$DateTime, data2$Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l')
#bottom right
plot(data2$DateTime, data2$Global_reactive_power, xlab = 'datetime', ylab = "Global_reactive_power", type = 'l')

#close png file creation
dev.off()