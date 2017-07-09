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
png(filename = "plot1.png", width = 480, height = 480)

#plot1 code
hist(data2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#close png file creation
dev.off()