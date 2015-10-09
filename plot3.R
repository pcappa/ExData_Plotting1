##############################################################################
#
#   plot3.R
#   
#   This program plots 3 line graphs of the sub metering data between the  
#   dates of 02-01-2007 and 02-02-2007.
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

#	Open the PNG device, plot the graph, then close the device.

out.fname <- paste(fdir, "\\", "plot3.png", sep="")
png(filename=out.fname, width=480, height=480)

#   Setup the constants for the legend (just to make it easier to read)

legend.text <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend.colors <- c("black", "red", "blue")
legend.linetype <- c(1,1,1)

#   Find the maximum metering value.  This is needed to get the scaling right.

max.y <- max(c(max(ss$Sub_metering_1), max(ss$Sub_metering_2), max(ss$Sub_metering_3)))

#   Open up a up a blank plot.  Make sure it is scaled to the range of x & Y values.

plot(c(dl,du), c(0, max.y), xlab="", ylab="Energy sub metering", type='n')

#   Setup the legend.

legend("topright", col=legend.colors, legend=legend.text, lty=legend.linetype)

#   Plot the three lines.

lines(ss$Time, ss$Sub_metering_1, col=legend.colors[1])
lines(ss$Time, ss$Sub_metering_2, col=legend.colors[2])
lines(ss$Time, ss$Sub_metering_3, col=legend.colors[3])

#   Close the device.

dev.off()

# All Done!