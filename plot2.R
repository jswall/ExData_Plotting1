
plot2 <- function(fname) {
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
    png(filename = "plot2.png", width = 480, height = 480, bg = "transparent")
    
    # create the plot
    plot(data$Timestamp, data$Global_active_power, 
         ylab = "Global Active Power (kilowatts)",
         xlab="",
         type="l")
    
    # close the file
    dev.off()
    
    data
}