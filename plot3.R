#
# Create line plots for energy sub metering values
#
plot3 <- function(fname) {
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
    png(filename = "plot3.png", width = 480, height = 480, bg = "transparent")
    
    # create the plot with the first line
    with(data, plot(Timestamp, Sub_metering_1, ylab = "Energy sub metering", xlab="", type="l"))
    # add the second line
    with(data, lines(Timestamp, Sub_metering_2, col="red"))
    # and the third line
    with(data, lines(Timestamp, Sub_metering_3, col="blue"))
    # lastly, add the legend
    legend("topright", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

    # close the file
    dev.off()
    
    data
}