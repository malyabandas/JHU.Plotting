# Downloading and reading the data

if(!file.exists("./household_power_consumption.txt")) {
  ## Downloading zip file
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, "./household_power_consumption.zip", method = "curl")
  
  ## Unzip the file
  unzip("./household_power_consumption.zip", exdir = "./")
  file.remove("./household_power_consumption.zip")
}

## Read and subset the data
dataFrame <- read.table("./household_power_consumption.txt", header = TRUE,
                        sep = ";", na.strings = "?")
dataFrame <- subset(dataFrame,Date == "1/2/2007" | dataFrame$Date == "2/2/2007")


## Change date an time to date and time classes in R
dataFrame$DateTime <- strptime(paste(dataFrame$Date, dataFrame$Time, sep = " "), 
                               format = "%d/%m/%Y %H:%M:%S")

## Build the plot.
png(filename = "plot4.png")
par(mfcol = c(2, 2))

### First plot
with(dataFrame, plot(DateTime, Global_active_power, type = "l",
                     xlab = "", ylab = "Global Active Power (kilowatts)"))

### Second plot
with(dataFrame, plot(DateTime, Sub_metering_1, type = "l",
                     xlab = "", ylab = "Energy sub metering"))
with(dataFrame, lines(DateTime, Sub_metering_2, col = "red"))
with(dataFrame, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = names(dataFrame)[7:9], bty = "n")

### Third plot
with(dataFrame, plot(DateTime, Voltage, type = "l",
                     xlab = "datetime"))

### Fourth plot
with(dataFrame, plot(DateTime, Global_reactive_power, type = "l",
                     xlab = "datetime"))
dev.off()