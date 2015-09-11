#Project 1: Plot 2

#If the data is not already downloaded, this code will check, download, and unzip
if (!file.exists('household_power_consumption.txt')){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile = "data.zip", method = 'curl')
    unzip('data.zip')
}

table <- read.table("household_power_consumption.txt", nrows = 5, sep = ';', 
                    header = TRUE, stringsAsFactors = FALSE)

variableNames <- names(table)

table <- read.table("household_power_consumption.txt", skip = 66636, nrows = 2880,
                    sep = ';', stringsAsFactors = FALSE, col.names = variableNames,
                    na.string = '?')

str(table)

#creating new variable dateTime that is combined Date and Time, 
table$dateTime <- paste(table$Date, table$Time)
table$dateTime <- strptime(table$dateTime, '%d/%m/%Y %H:%M:%S')

#creating plot
with(table, plot(dateTime, Global_active_power, type = 'l', xlab = '',
                 ylab = 'Global Active Power (kilowatts)'))

#copying plot to png file
dev.copy(png, "plot2.png")
dev.off()
