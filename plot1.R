# Configuration
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destDir <- "./data"
destZipfile <- "./data/power_consumption.zip"
destFile <- "./data/household_power_consumption.txt"

# Create data directory if needed
if (!file.exists(destDir)) {
  dir.create(destDir)
}

# Download and extract data if needed
if (!file.exists(destfile)) {
  # Download
  download.file(fileUrl, destfile)
  
  # Extract
  unzip(destfile, exdir = destDir)
}

# Read the data
f <- file(destFile, "r");
data <- read.table(
  text = grep("^[1,2]/2/2007",  readLines(f), value = TRUE), 
  sep = ";",
  skip = 0,
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Name the columns
names(data) <- c(
  "date", 
  "time", 
  "active_power", 
  "reactive_power", 
  "voltage",
  "intensity",
  "sub_metering_1",
  "sub_metering_2",
  "sub_metering_3"
)

# Plot - I
par(mfrow = c(1, 1))
hist(
  data$active_power,
  main = "Global Active Power", 
  xlab = "Global Active Power (kilowatts)", 
  ylab = "Frequency", 
  col = "red",
  freq = TRUE
)

# Create output file
dev.copy(png, file = "plot1.png")

# Close
dev.off()