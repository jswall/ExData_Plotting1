#
# Create many plots
#
plot4 <- function(fname) {
    # read the whole data file
    alldata <- read.csv(
        fname, sep = ";", 
        dec = ".", 
        na.strings = "?"
    )
    # combine date and time columns to a timestamp and select subset by date range
    alldata <- transform(alldata, Timestamp = strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
    startDate <- as.POSIXlt("2007-02-01")
    endDate <- as.POSIXlt("2007-02-03")
    data <- subset(alldata, Timestamp >=startDate & Timestamp < endDate)
    
    # open the target file
    png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")

    # specify 2 rows and 2 columns
    par(mfrow = c(2, 2))

    # create the first plot - Global Active Power
    with(data, plot(Timestamp, Global_active_power, 
                    ylab = "Global Active Power",
                    xlab="", type="l"))
    
    # create the second plot - Voltage
    with(data, plot(Timestamp, Voltage, xlab="datetime", ylab="Voltage", type="l"))
    
    # create the third plot - sub metering, first line
    with(data, plot(Timestamp, Sub_metering_1, ylab = "Energy sub metering", xlab="", type="l"))
    # add the second line
    with(data, lines(Timestamp, Sub_metering_2, col="red"))
    # and the third line
    with(data, lines(Timestamp, Sub_metering_3, col="blue"))
    # lastly, add the legend
    legend("topright", bty="n", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # create the fourth plot - Global Reactive Power
    with(data, plot(Timestamp, Global_reactive_power, xlab="datetime", type="l"))
    
    # close the file
    dev.off()
    
    data
}