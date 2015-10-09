##############################################################################
#
#   plot1.R
#   
#   This program plots a histogram of global active power consumed between 
#   the dates of 02-01-2007 and 02-02-2007.
#
##############################################################################

#   Set some constant vairables to make our lives a little easier.

furl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fdir <- "M:\\MyLife\\Courses\\Johns Hopkins Data Analytics\\04 Exploratory Data Analysis\\Project1"
in.fname <- paste(fdir, "\\", "household_power_consumption.txt", sep="")
out.fname <- paste(fdir, "\\", "plot1.png", sep="")

start.date <- "2007-02-01"									# Start date for plot.
end.date <- "2007-02-02"									# End date for plot.

#  	Download of file.  Make sure the directory exists and that we haven't
#	already downloaded the file.

if (!file.exists(fdir)) { dir.create(fdir) }                
if (!file.exists(in.fname)) { download.file(furl, in.fname) }

#	Load the usage data into the table "x", note: '?' and "" will become NA's.

x <- read.table(in.fname, sep=";", header=TRUE, na.strings=(c("?","")))

#	Before we move forward, we have to clean up the data a bit.
#	Convert the date & time into a POSSIX time stamp.

x$Time <- strptime(paste(x$Date, x$Time), format="%d/%m/%Y %H:%M:%S") 

#	Set the variables dl and du to represent the lowest date and the hightest date we
#	will filter for.

dl <- strptime(paste(start.date,"00:00:00"), format="%Y-%m-%d %H:%M:%S")
du <- strptime(paste(end.date, "23:59:59"), format="%Y-%m-%d %H:%M:%S")

#	Now, create a subset of the data, so we only have the data that we need.

ss <- subset(x, ((x$Time >= dl) & (x$Time <= du)))

#	Open the PNG device, create the histogram, then close the device.

png(filename=out.fname, width=480, height=480)
    hist(ss$Global_active_power, col="red", 
         main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()

# All done!