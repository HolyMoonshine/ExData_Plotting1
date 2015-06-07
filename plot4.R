## Plot 4
plot4 <- function(){
## read and filter data file
    library(sqldf)
    sqlData <- read.csv.sql("./household_power_consumption.txt", 
                            sql = "select * from file where Date in ('1/2/2007',
                            '2/2/2007')",header = TRUE, sep = ";")
    closeAllConnections()
    
    ## Create date_time merged column in time format
    sqlData$date_time <- paste(sqlData$Date, sqlData$Time)
    sqlData$date_time <- strptime(sqlData$date_time, format = "%d/%m/%Y %H:%M:%S")
    
    ## Export for PNG
    png(file = "plot4.png", height = 480, width = 480)
    
    ##
    par(mfrow = c(2,2), mar = c(5,4,5,2), oma = c(1,1,0,0))
    
    ## 1,1
    with(sqlData, plot(date_time, Global_active_power,type = "l",
                       xlab = "", 
                       ylab = "Global Active Power")
    )
    
    ## 1,2
    with(sqlData, plot(date_time, Voltage, type = "l", xlab = "datetime" ))
    
    ## 2,1
    colours <- c("black", "red", "blue")
    with(sqlData, plot(date_time, Sub_metering_1, xlab = "", 
                       ylab = "Energy sub metering", col = colours[1],type = "l"))
    with(sqlData, points(date_time, Sub_metering_2, col = colours[2], type = "l"))
    with(sqlData, points(date_time, Sub_metering_3, col = colours[3], type = "l"))
    ## Legend 
    legend("topright", lty = 1, col = c("black", "red", "blue"), 
           names(sqlData[7:9]),
           bty = "n")
    
    ## 2,2
    with(sqlData, plot(date_time, Global_reactive_power, type = "l", 
                       xlab = "datetime")
    )
    dev.off()
}