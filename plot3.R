plot3 <- function(){
    ## read and filter data file
    library(sqldf)
    sqlData <- read.csv.sql("./household_power_consumption.txt", 
                            sql = "select * from file where Date in ('1/2/2007',
                            '2/2/2007')",header = TRUE, sep = ";")
    closeAllConnections()
    
    ## Create date_time merged column in time format
    sqlData$date_time <- paste(sqlData$Date, sqlData$Time)
    sqlData$date_time <- strptime(sqlData$date_time, format = "%d/%m/%Y %H:%M:%S")
    
    ## set boundaries and draw output
    with(sqlData, plot(date_time, Sub_metering_1, xlab = "", 
                       ylab = "Energy sub metering", type = "l")
         )
    with(sqlData, points(date_time, Sub_metering_2, col = "red", type = "l"))
    with(sqlData, points(date_time, Sub_metering_3, col = "blue", type = "l"))
    
    ## Legend creation
    ## Legend seems to display oddly in RStudio, however if you call windows()
    ## to open the graphics device or source and run in RGui, it outputs as
    ## expected.
    legend("topright", lty = 1, col = c("black", "red", "blue"),
           names(sqlData[7:9])
           )
}