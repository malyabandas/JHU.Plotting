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

## Plot global active power through time
png(filename = "plot2.png")
with(dataFrame, plot(DateTime, Global_active_power, type = "l",
                     xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()