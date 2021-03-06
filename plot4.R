#Download the data set by clicking the link from the forked repo and save the file with the name "powerdata.zip"
#Unzip the downloaded file
#Set the working directory of R to where the unzipped data file (powerdata.txt) is located. Mine is on my desktop.

powerdata <- read.table("power_data.txt", na.strings=c("NA","?"), sep = ";", skip=66637, nrow=2880)# just read the data of the specified time range into R object powerdata
names(powerdata) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

dim(powerdata)

powerdata$Datetime <- paste(powerdata$Date, powerdata$Time)
powerdata1 <- subset(powerdata, select=-c(Date, Time))

library(lubridate) #load package "lubridate"
powerdata1$Datetime <- strptime(powerdata1$Datetime, format="%d/%m/%Y %T") ##Convert the new Datetime column into time format
powerdata1$Global_active_power <- as.numeric(powerdata1$Global_active_power)#make all the data in the other columns numeric
powerdata1$Voltage <- as.numeric(powerdata1$Voltage)
powerdata1$Global_intensity <- as.numeric(powerdata1$Global_intensity)
powerdata1$Sub_metering_1 <- as.numeric(powerdata1$Sub_metering_1)
powerdata1$Sub_metering_2 <- as.numeric(powerdata1$Sub_metering_2)
powerdata1$Sub_metering_3 <- as.numeric(powerdata1$Sub_metering_3)

str(powerdata1)
summary(powerdata1$Datetime)# make sure the data covers the whole specified time range.

# Construct the forth plot
par(mfrow=c(2,2)) ##arrange the 4 plots in a 2 by 2 style.

plot(powerdata1$Datetime, powerdata1$Global_active_power,  type="l", xlab="",
    ylab="Global Active Power")
plot(powerdata1$Datetime, powerdata1$Voltage,  type="l", xlab="datetime",
    ylab="Voltage")

plot(powerdata1$Datetime, powerdata1$Sub_metering_1,  type="l", xlab="",
    ylab="Energy sub metering")
lines(powerdata1$Datetime, powerdata1$Sub_metering_2,  type="l", col="red", xlab="", ylab="")
lines(powerdata1$Datetime, powerdata1$Sub_metering_3,  type="l", col="blue", xlab="", ylab="")

legend("topright", lty=1, col=c("black","red","blue"), cex=0.95,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) ## create a legend at the right top corner of the plot
plot(powerdata1$Datetime, powerdata1$Global_reactive_power,  type="l", xlab="datetime",
    ylab="Global_reactive_power")


# Save the forth plot to a png file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()