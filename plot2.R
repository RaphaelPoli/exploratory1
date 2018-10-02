library(lubridate)
library(dplyr)
extDF<-read.table("household_power_consumption.txt",skip=66600,nrows=300*12,sep=";",na.strings="?")
#contains subset but larger

#subeting precisely
DF<-subset(extDF, dmy(extDF$V1) ==dmy("01-02-2007") | dmy(extDF$V1)==dmy("02-02-2007"))
DF<-rename(DF, Date=V1, Time=V2,Global_active_power=V3, Global_reactive_power=V4, Voltage=V5, Global_intensity=V6, Sub_metering_1=V7,Sub_metering_2=V8,Sub_metering_3=V9)

#changing language so titles don't appear in french
Sys.setlocale("LC_TIME", "C")# worked
#adding a compiled date and time
date<-paste(DF$Date,DF$Time)
DF$Time <- strptime(date, "%d/%m/%Y %H:%M:%S")

#ploting
par(mfrow=c(1,1))
plot(y=DF$Global_active_power,type="l",x=DF$Time, xlab="Time", ylab="Global Active Power")#second plot ok

#saving to png
dev.copy(png,"plot2of4.png")
dev.off()