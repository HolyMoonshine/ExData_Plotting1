plot2 <- function(){
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
    par(mar = c(5,4,3,2), oma = c(1,1,1,1))
    with(sqlData, plot(date_time, Global_active_power, 
                       ylab = "Global Active Power (kilowatts)", 
                       xlab = "", type = "l")
         )
    
}