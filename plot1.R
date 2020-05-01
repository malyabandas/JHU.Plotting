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


## Plot Global Active Power histogram

png(filename = "plot1.png")
with(dataFrame, hist(Global_active_power, col = "red", 
                     main = "Global Active Power", 
                     xlab = "Global Active Power (kilowatts)"))
dev.off()