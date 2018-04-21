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
png("plot4.png")

#create a four graph window
par(mfcol = c(2,2), mar = c(3,4,2,1), oma = c(2,2,2,1))

#create a blank plot for the global power data
plot(powerdata$comp_time, powerdata$Global_active_power, type = "n", xlab = "", ylab = "")

#Add a y axis label to the global power data plot
title(ylab = "Global Active Power (kilowatts)")

#add data to the global power data plot
lines(powerdata$comp_time, powerdata$Global_active_power)

#create a blank plot for the sub-metering data
plot(powerdata$comp_time, powerdata$Sub_metering_1, type = "n", xlab = "", ylab ="")

#Add sub-metering data 1 to sub-metering plot
lines(powerdata$comp_time, powerdata$Sub_metering_1, col = "black")

#Add sub-metering data 2 to sub-metering plot
lines(powerdata$comp_time, powerdata$Sub_metering_2, col = "red")

#Add sub-metering data 3 to sub-metering plot
lines(powerdata$comp_time, powerdata$Sub_metering_3, col = "blue")

#Add yaxis label
title(ylab = "Energy sub metering", cex.lab = 0.8)

#create values for the legend
allmetrics <- colnames(powerdata)
metrics <- allmetrics[c(7,8,9)]

#Add legend to the plot
legend("topright", legend = metrics, col = c("black", "red", "blue"), cex = 0.7, lty = 1, lwd = 2)

#create a blank plot
plot(powerdata$comp_time, powerdata$Voltage, type = "n", xlab = "datetime", ylab = "")
title(ylab = "Voltage")

#Add Voltage data to the plot
lines(powerdata$comp_time, powerdata$Voltage)

#create a blank plot for global reaction power
plot(powerdata$comp_time, powerdata$Global_reactive_power, type = "n", xlab = "datetime", ylab = "")
title(ylab = "Global reactive power")

#Add global reaction power to plot
lines(powerdata$comp_time, powerdata$Global_reactive_power)

#close the file
dev.off()
