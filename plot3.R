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


##Creating "plot3" and saving as .png file
png(filename = "plot3.png", width = 480, height = 480)

plot(plot_data_subset$Datetime, plot_data_subset$Sub_metering_1, type="l", xlab = NA, ylab = "Energy sub metering", xaxt = 'n')
lines(plot_data_subset$Datetime, plot_data_subset$Sub_metering_2, type="l", col = "red")
lines(plot_data_subset$Datetime, plot_data_subset$Sub_metering_3, type="l", col = "blue")
legend("topright", legend = c(names(plot_data_subset)[7:9]), col = c("black", "red", "blue"), lty=1, lwd=2, cex=0.8)

tick_positions <- as.POSIXct(c("2007-02-01 00:00:00", 
                               "2007-02-02 00:00:00",
                               "2007-02-03 00:00:00"))
axis.POSIXct(side = 1, 
             at = tick_positions, 
             format = "%a")
dev.off()