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
png("plot3.png")

#create a blank plot
plot(powerdata$comp_time, powerdata$Sub_metering_1, type = "n", xlab = "", ylab ="")

#Add sub-metering data 1 to plot
lines(powerdata$comp_time, powerdata$Sub_metering_1, col = "black")

#Add sub-metering data 2 to plot
lines(powerdata$comp_time, powerdata$Sub_metering_2, col = "red")

#Add sub-metering data 3 to plot
lines(powerdata$comp_time, powerdata$Sub_metering_3, col = "blue")

#Add yaxis label
title(ylab = "Energy sub metering", cex.lab = 0.8)

#create values for the legend
allmetrics <- colnames(powerdata)
metrics <- allmetrics[c(7,8,9)]
#Add legend to the plot
legend("topright", legend = metrics, col = c("black", "red", "blue"), cex = 0.7, lty = 1, lwd = 2)
dev.off()

