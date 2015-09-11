#Project 1: Plot 4

if (!file.exists("household_power_consumption.txt")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, dest = 'data.zip', method = 'curl')
    unzip('data.zip')
}

table <- read.table('household_power_consumption.txt', sep = ';', nrows = 5, 
                    header = TRUE)
variableNames <- names(table)

table <- read.table("household_power_consumption.txt", skip = 66636, nrows = 2880,
                    col.names = variableNames, stringsAsFactors = FALSE, 
                    na.strings = '?', sep = ';')
str(table)

table$dateTime <- paste(table$Date, table$Time)
table$dateTime <- strptime(table$dateTime, '%d/%m/%Y %H:%M:%S')

#creating plot
par(mfcol = c(2,2))
with(table, {
    plot(dateTime, Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power')
    plot(dateTime, Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
    lines(table$dateTime, table$Sub_metering_2, col = 'red')
    lines(table$dateTime, table$Sub_metering_3, col = 'blue')
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", 'blue'), lwd = 1, cex = .5, bty = 'n',
           y.intersp = .5)
    plot(dateTime, Voltage, type = 'l', xlab = 'datetime')
    plot(dateTime, Global_reactive_power, type = 'l', xlab = 'datetime' )
})

#saving plot to file
dev.copy(png, 'plot4.png')
dev.off()
