

## The purpose of this function is to plot the following all on the same page:
## (1) Global Active Power through time
## (2) Voltage through time
## (3) Energy sub metering through time
## (4) Global Reactive Power through time
## All data is plotted for Feb 1 and 2, 2007, and plots are then saved to a .png.

plot4 <- function(input_file="household_power_consumption.txt",output_file="plot4.png") {

	## read in data file
	data <- read.table(input_file, header = TRUE, sep = ";", na.strings = "?")
	
	## format the Date
	data$date_formatted <- as.Date(data$Date, format = "%d/%m/%Y")

	## subset the data to extract data for Feb 1 and Feb 2
	data_subset <- subset(data, data$date_formatted == "2007-02-01" | data$date_formatted == "2007-02-02")
		
	## combine date and time
	data_subset$date_time<-strptime(paste(data_subset$Date, data_subset$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S")

	## plot 4 graphs on one page, in a 2x2 pattern
	par(mfrow = c(2,2), mar = c(2.5,4.1,4.1,2.1))  
	
		## plot Global Active Power through time
		plot(data_subset$date_time, data_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power")

		## plot Voltage through time
		plot(data_subset$date_time, data_subset$Voltage, type="l", xlab="datetime", ylab="Voltage")

		## plot Energy sub metering through time
		## plot the Energy sub metering through time on the same plot and add a legend
		plot(data_subset$date_time, data_subset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
		lines(data_subset$date_time, data_subset$Sub_metering_2, col="red")
		lines(data_subset$date_time, data_subset$Sub_metering_3, col="blue")
		
			## add the legend
			legend("topright",lwd = 1, bty = "n", col=c("black","red","blue"), cex=0.5, xjust = 1, legend=c("Sub_metering_1   ","Sub_metering_2   ","Sub_metering_3   "))

		## plot Global Reactive Power through time
		plot(data_subset$date_time, data_subset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
			
	
	## write the plot to a .png
	## note there is no need to specify the size of the plot (project instructions were 480x480) because that is the default)
	dev.copy(png, file = output_file, bg = "transparent")
	dev.off()

}