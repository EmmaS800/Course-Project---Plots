##Same initial steps as "plot1.R"
##Working directory must contain the data before running this code

##Reading the data
plot_data <- read.table("./household_power_consumption.txt", 
                        sep = ";", 
                        na.strings="?",
                        nrows=2075259,
                        header=TRUE)

##Formatting "date" data with POSIXct date/time
plot_data$Date <- as.Date(plot_data$Date, format="%d/%m/%Y")
datetime <- paste(plot_data$Date, plot_data$Time)
plot_data$Datetime <- as.POSIXct(datetime)

##Subsetting the data for the relevant dates
plot_data_subset <- subset(plot_data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))


##Creating "plot4" and saving as .png file
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2), mar=c(4,4,2,1), oma=c(0,0,2,0))

tick_positions <- as.POSIXct(c("2007-02-01 00:00:00", 
                               "2007-02-02 00:00:00",
                               "2007-02-03 00:00:00"))

##top left plot
plot(plot_data_subset$Global_active_power~plot_data_subset$Datetime, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)",
     xaxt = 'n')
axis.POSIXct(side = 1, at = tick_positions, format = "%a")

##bottom left plot
plot(plot_data_subset$Datetime, plot_data_subset$Sub_metering_1, type="l", xlab = NA, ylab = "Energy sub metering", xaxt = 'n')
lines(plot_data_subset$Datetime, plot_data_subset$Sub_metering_2, type="l", col = "red")
lines(plot_data_subset$Datetime, plot_data_subset$Sub_metering_3, type="l", col = "blue")
legend("topright", legend = c(names(plot_data_subset)[7:9]), col = c("black", "red", "blue"), lty=1, lwd=2, cex=0.8)
axis.POSIXct(side = 1, at = tick_positions, format = "%a")

##top right plot
plot(plot_data_subset$Datetime, plot_data_subset$Voltage, 
     type="l", 
     xlab = "datetime", 
     ylab = "Voltage", 
     xaxt = 'n')
axis.POSIXct(side = 1, at = tick_positions, format = "%a")

##bottom right plot
plot(plot_data_subset$Datetime, plot_data_subset$Global_reactive_power, 
     type="l", xlab = "datetime", ylab = "Global_reactive_power",
     xaxt = 'n')
axis.POSIXct(side = 1, at = tick_positions, format = "%a")

dev.off()