##############################################################################
#
#   plot4.R
#   
#   This program plots draws four separte plots onto a 2x2 display for data
#   between the dates of 02-01-2007 and 02-02-2007.
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

#	Open the PNG device, plot the 2x2 graphs, then close the device.

out.fname <- paste(fdir, "\\", "plot4.png", sep="")
png(filename=out.fname, width=480, height=480)

#   Setup the a 2x2 quadrants for the 4 plots.

par(mfrow=c(2, 2))

#   First plot is for Global Active Power

plot(ss$Time, ss$Global_active_power, type="l", xlab="", ylab="Global Active Power")

#   Second plot is for Voltage

plot(ss$Time, ss$Voltage, type="l", xlab="datetime", ylab="Voltage")

#   Third plot is for Energy Sub Metering

plot(c(dl,du), c(0, max.y), xlab="", ylab="Energy sub metering", type='n')
legend("topright", cex=0.95, bty="n", col=legend.colors, legend=legend.text, lty=legend.linetype)
lines(ss$Time, ss$Sub_metering_1, col=legend.colors[1])
lines(ss$Time, ss$Sub_metering_2, col=legend.colors[2])
lines(ss$Time, ss$Sub_metering_3, col=legend.colors[3])

#   Fourth plot is for Global Reactive Power

plot(ss$Time, ss$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#   Close the device.

dev.off()

# All done!