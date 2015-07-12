
## The purpose of this function is to read in a given data file and plot the Global
## Active Power parameter through time for 2007-02-01 and 2007-02-02. Create the plot on
## the screen and also write the plot to a .png file.


plot2 <- function(input_file="household_power_consumption.txt",output_file="plot2.png") {

	## read in data file
	data <- read.table(input_file, header = TRUE, sep = ";", na.strings = "?")
	
	## format the Date
	data$date_formatted <- as.Date(data$Date, format = "%d/%m/%Y")

	## subset the data to extract data for Feb 1 and Feb 2
	data_subset <- subset(data, data$date_formatted == "2007-02-01" | data$date_formatted == "2007-02-02")
		
	## combine date and time
	data_subset$date_time<-strptime(paste(data_subset$Date, data_subset$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S")

	## plot the Global Average Power through time and add a y axis label
	plot(data_subset$date_time, data_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
		
	## write the plot to a .png
	## note there is no need to specify the size of the plot (project instructions were 480x480) because that is the default)
	dev.copy(png, file = output_file, bg = "transparent")
	dev.off()

}


