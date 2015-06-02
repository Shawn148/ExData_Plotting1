#Download the data set by clicking the link from the forked repo and save the file with the name "powerdata.zip"
#Unzip the downloaded file
#Set the working directory of R to where the unzipped data file (powerdata.txt) is located. Mine is on my desktop.

powerdata <- read.table("power_data.txt", na.strings=c("NA","?"), sep = ";") # read data into R
names(powerdata) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
#name all the nine columns accordingly.

dim(powerdata) # check the dimensions of the loaded data
data1 <- powerdata[66638:69517, ] #subset the 2007-02-01 to 2007-02-02 data into a data file "data1"
dim(data1) # check the dimensions of subset data1

data1$Datetime <- paste(data1$Date, data1$Time)
newdata1 <- subset(data1, select=-c(Date, Time)) ## merge Date and Time column into a new column "Datetime", and remove the old Date and Time columns.

library(lubridate) # load package "lubridate"
newdata1$Datetime <- strptime(newdata1$Datetime, format="%d/%m/%Y %T") #Convert the new Datetime column into time format
newdata1$Global_active_power <- as.numeric(newdata1$Global_active_power) #Change column class from Factor into numeric.
newdata1$Voltage <- as.numeric(newdata1$Voltage)
newdata1$Global_intensity <- as.numeric(newdata1$Global_intensity)
newdata1$Sub_metering_1 <- as.numeric(newdata1$Sub_metering_1)
newdata1$Sub_metering_2 <- as.numeric(newdata1$Sub_metering_2)
newdata1$Sub_metering_3 <- as.numeric(newdata1$Sub_metering_3)

str(newdata1) # check features of the final data

# Construct the First plot
par(mfrow=c(1,1))
hist(newdata1$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

# Save the plot to a png file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
