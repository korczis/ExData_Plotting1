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

# rename the columns
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

# Add time column
data$new_time <- as.POSIXct(paste(data$date, data$time), format = "%d/%m/%Y %T")

legend <- c(
  "Sub_metering_1",
  "Sub_metering_2",
  "Sub_metering_3"
)

# plot - IV
par(mfrow = c(2, 2))
with(data,
  {
    plot(new_time, active_power, type = "l", xlab = "", ylab = "Global Active Power")
    plot(new_time, voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    plot(new_time, sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(new_time, sub_metering_2, col = "red")
    lines(new_time, sub_metering_3, col = "blue")
    legend(
      "topright",
      col = c("black", "red", "blue"),
      cex = 0.7,
      lty = 1,
      bty = "n",
      legend = legend
    )
    plot(
      new_time,
      reactive_power,
      type = "l",
      xlab = "datetime",
      ylab = "Global Reactive Power"
    )
  }
)

# Create output file
dev.copy(png, file = "plot4.png")

# Close
dev.off()