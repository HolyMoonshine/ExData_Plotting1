plot1 <- function(){
    ## read and filter data file
    library(sqldf)
    sqlData <- read.csv.sql("./household_power_consumption.txt", 
                            sql = "select * from file where Date in ('1/2/2007',
                            '2/2/2007')",header = TRUE, sep = ";")
    closeAllConnections()
    
    ## Export for PNG
    png(file = "plot1.png", height = 480, width = 480)
    ## set boundaries and draw histogram.
    par(mar = c(5,4,3,2), oma = c(1,1,1,1))
    with(sqlData, hist(Global_active_power, col = "red",
                       xlab = "Global Active Power (kilowatts)", 
                       main = "Global Active Power")
         )
    dev.off()
}