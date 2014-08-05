#
# Plots histogram of Global Active Power for date range 2007-02-01 to 2007-02-02.
# The histogram is stored in PNG format (480x480px) in the file plot1.png.
#
plot1 <- function(fname) {
    # read the whole data file
    alldata <- read.csv(
        fname, sep = ";", 
        dec = ".", 
        na.strings = "?"
        )
    # transform date column to date and select subset by date range
    alldata <- transform(alldata, Date = strptime(Date, format="%d/%m/%Y"))
    startDate <- as.POSIXlt("2007-02-01")
    endDate <- as.POSIXlt("2007-02-02")
    data <- subset(alldata, Date >=startDate & Date <= endDate)

    # open the target file
    png(filename = "plot1.png", width = 480, height = 480, bg = "transparent")
    
    # create the histogram
    hist(data$Global_active_power, 
         main = "Global Active Power",
         xlab = "Global Active Power (kilowatts)", 
         col="red")

    # close the file
    dev.off()
    
    data
}