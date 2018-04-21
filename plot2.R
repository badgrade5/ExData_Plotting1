#open data.table package
library(data.table)

#read subsetted data into memory with fread. Need to add column names back to new object
header <- colnames(fread("household_power_consumption.txt", nrow = 5))
powerdata <- fread("household_power_consumption.txt", skip = "1/2/2007", nrow = 2880)
colnames(powerdata) <- header

#create computer representation of time
comp_time <- paste(powerdata$Date, powerdata$Time)
comp_time <- strptime(comp_time, format = "%d/%m/%Y %H:%M:%S")

#add new time column to selected data
powerdata <- cbind(powerdata, comp_time)

#open a png
png("plot2.png")

#create a blank plot
plot(powerdata$comp_time, powerdata$Global_active_power, type = "n", xlab = "", ylab = "")

#Add a y axis label to the plot
title(ylab = "Global Active Power (kilowatts)")

#add data to the plot
lines(powerdata$comp_time, powerdata$Global_active_power)

#save the plot
dev.off()

