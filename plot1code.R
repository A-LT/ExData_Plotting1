#Project 1: Plot 1

#If the data is not already downloaded, this code will check, download, and unzip
if (!file.exists('household_power_consumption.txt')){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile = "data.zip", method = 'curl')
    unzip('data.zip')
}

table <- read.table("household_power_consumption.txt", sep = ';', nrows = 5, 
                    header = TRUE, na.strings = '?')


#I only want to read in certain dates (2007-02-01 and 2007-02-02). A observation is
#taken every minute so in two days there will be 2880 observations. The data set
#starts Dec 16,2006  at 17:24 so I need to figure out how many rows to skip.  46 days
# plus partial day on Dec 16. 1 day = 24 hr * 60 min = 1440 observations.
# (1440 * 46) + 397 = 66636 observations to skip.

#Since skipping rows, get names to set as col.names in new table
variableNames <- names(table)
table <- read.table("household_power_consumption.txt", sep = ";", skip = 66637,
                    nrows = 2880, na.strings = '?', col.names = variableNames,
                    stringsAsFactors = FALSE)

str(table)

#Creating the plot
with(table, hist(Global_active_power, main = paste("Global Active Power"),
                 xlab = "Global Active Power (kilowatts)",
                 col = 'red')
)

#copying to png
dev.copy(png, file = 'plot1.png')
dev.off()
