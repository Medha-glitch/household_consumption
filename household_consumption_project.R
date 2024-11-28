# Set your working directory where the dataset is saved
setwd("/home/medha/Downloads")

# Load the data
data <- read.table("household_power_consumption.txt", 
                   sep = ";", 
                   header = TRUE, 
                   na.strings = "?", 
                   stringsAsFactors = FALSE)
# Check the first few rows of the dataset
head(data)

# Check structure of the dataset
str(data)

# Summary statistics
summary(data)
# Convert Date and Time to datetime format
data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Inspect the new Datetime column
head(data$Datetime)
# Subset data for February 1 and 2, 2007
subset_data <- subset(data, Datetime >= "2007-02-01" & Datetime < "2007-02-03")

# Check the subset
head(subset_data)
# Remove rows with NA values
clean_data <- na.omit(subset_data)

# Check for missing values
sum(is.na(clean_data))
# Plot Global Active Power over time
plot(clean_data$Datetime, clean_data$Global_active_power, 
     type = "l", 
     xlab = "Time", 
     ylab = "Global Active Power (kilowatts)", 
     main = "Global Active Power over Time")
# Save the plot to a file
png("plot1.png", width = 480, height = 480)
plot(clean_data$Datetime, clean_data$Global_active_power, 
     type = "l", 
     xlab = "Time", 
     ylab = "Global Active Power (kilowatts)", 
     main = "Global Active Power over Time")
dev.off()
# Summary statistics for Global Active Power
summary(clean_data$Global_active_power)

# Summary statistics for Sub-metering
summary(clean_data[, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")])
# Save this code into a file
writeLines("
# Load necessary libraries
library(ggplot2)

# Step 1: Load data
data <- read.table('household_power_consumption.txt', sep = ';', header = TRUE, na.strings = '?', stringsAsFactors = FALSE)

# Step 2: Preprocess and subset data
data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format = '%d/%m/%Y %H:%M:%S')
subset_data <- subset(data, Datetime >= '2007-02-01' & Datetime < '2007-02-03')
clean_data <- na.omit(subset_data)

# Step 3: Create a plot
png('plot1.png', width = 480, height = 480)
plot(clean_data$Datetime, clean_data$Global_active_power, type = 'l', xlab = 'Time', ylab = 'Global Active Power (kilowatts)', main = 'Global Active Power over Time')
dev.off()
", con = "run_analysis.R")
