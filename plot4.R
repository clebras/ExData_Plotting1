# ============================
# plot4.R
# v1.0 16/09/2020
# ============================
output_folder<-"R/04 - Exploratory Data Analysis/Week1/"
filename<-paste(output_folder,"exdata_data_household_power_consumption/household_power_consumption.txt")

# caution: some NA characters "?"
dt<-read.csv2(filename, na.strings = "?", dec=".")
#    => 2075259 observations of 9 variables

# transform factor as Date (to be used by dplyr::filter)
dt$Date<-as.Date(dt$Date, "%d/%m/%Y")

# filtered data
#    => 2880 observations
dt.f<-dplyr::filter(dt, dt$Date >= "2007-02-01" & dt$Date <= "2007-02-02")

# New column Datetime = concatenate(Date and Time)
dt.f<-dplyr::mutate(dt.f, Datetime = as.POSIXct((paste(dt.f$Date," ",dt.f$Time))))

# Set locale for date label in English
Sys.setlocale("LC_TIME", "English")

# width and height
windows.options(width=480, height=480)

# 4 plots in the same window
par(mfrow=c(2,2), mai = c(0.7, 1, 0.2, 0.2))

# plot1
plot(x=dt.f$Datetime, y=dt.f$Global_active_power, type="l", ylab = "Global Active Power", xlab="")

# plot2
plot(x=dt.f$Datetime, y=dt.f$Voltage, type="l", ylab = "Voltage", xlab="datetime")

# plot3
plot(x=dt.f$Datetime, y=dt.f$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="", col="Black")
lines(x=dt.f$Datetime, y=dt.f$Sub_metering_2, col="Red")
lines(x=dt.f$Datetime, y=dt.f$Sub_metering_3, col="Blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("Black","Red","Blue"), lty=1, bty="n", cex=0.75)

# plot4
plot(x=dt.f$Datetime, y=dt.f$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab="datetime")

## Copy plot to a PNG file
dev.copy(png, file = paste(output_folder,"plot4.png"))

## close the PNG device
dev.off()
windows.options(reset=TRUE)
