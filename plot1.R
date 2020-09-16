# ============================
# plot1.R
# v1.0 14/09/2020
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

# width and height
windows.options(width=480, height=480)

# plot histogram
par(mfrow=c(1,1), mai = c(0.2, 1, 0.2, 0.2))
hist(dt.f$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

## Copy plot to a PNG file
dev.copy(png, file = paste(output_folder,"plot1.png"))

## close the PNG device
dev.off()
windows.options(reset=TRUE)