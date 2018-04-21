#open data.table package
library(data.table)

#read subsetted data into memory with fread. Need to add column names back to new object
header <- colnames(fread("household_power_consumption.txt", nrow = 5))
powerdata <- fread("household_power_consumption.txt", skip = "1/2/2007", nrow = 2880)
colnames(powerdata) <- header

powerdata$Date <- as.Date(powerdata$Date, format = "%d/%m/%Y")
png("plot1.png")
hist(powerdata$Global_active_power, col = "red", main = "Global active power", xlab = "Global Active Power (kilowatts)")
dev.off()


