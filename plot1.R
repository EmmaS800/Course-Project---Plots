##Working directory must contain the data before running this code

##Reading the data
initial_classes <- c("character", "character", rep("numeric", 7))
plot_data <- read.table("./household_power_consumption.txt", 
                        sep = ";", 
                        na.strings="?",
                        nrows=2075259,
                        header=TRUE,
                        colClasses = initial_classes)


##Formatting "date" data with POSIXct date/time

plot_data$Date <- as.Date(plot_data$Date, format="%d/%m/%Y")
datetime <- paste(plot_data$Date, plot_data$Time)
plot_data$Datetime <- as.POSIXct(datetime)

##Subsetting the data for the relevant dates
plot_data_subset <- subset(plot_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

##Creating "plot1" and saving as .png file
png(filename = "plot1.png", width = 480, height = 480)
hist(plot_data_subset$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
dev.off()
