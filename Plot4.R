
#=======================================================================
# Function: Set_WorkingDir
# Description: Set Personal Working Directory here 
#=======================================================================

Set_WorkingDir <- function() 
{
  setwd("C:/Coursera_Exploratory_Data_Analysis/Week1/ExData_Plotting1/")
}

#=======================================================================
# Function: Get_AssignmentData
# Description: (1) Check if Assignment Data Exist
#              (2) If not exist download
#=======================================================================

Set_DataSource <- function()
{
  
  # Check if Data Directory Exist if NOT create
  
  if (!file.exists("./Data"))
  {
    dir.create(file.path(getwd(), "Data"))
  }
  
  #Check if the zip file exist else download and unzip 
  
  if(!file.exists(paste(getwd(), "Data/household_power_consumption.txt", sep="/")))
  {
    
    #Download Data File
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./Data/Dataset.zip")
    
    #unzip file
    unzip ("./Data/Dataset.zip", exdir = "./Data")
    
  }
  
}

Process_Plot4 <- function()
{
  
  # ---------------------------------------------------
  # Set Working Directory  
  # ---------------------------------------------------
  
  # you have to set personal working directory 1st before using this function....!!!!!!!!
  
  #Set_WorkingDir()
  
  # ---------------------------------------------------
  # Get Data 
  # ---------------------------------------------------
  
  Set_DataSource()
  
  # ---------------------------------------------------
  # Read Data into Data Frame 
  # ---------------------------------------------------
  
  dfx <- read.table("./data/household_power_consumption.txt", 
                    sep = ";", 
                    skip = 66637, 
                    nrows = 2880, 
                    col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  # ---------------------------------------------------
  # Set DateTime Column   
  # ---------------------------------------------------
  
  dfx$DateTime <- as.POSIXct(paste(dfx$Date, " " ,dfx$Time),format="%d/%m/%Y %H:%M:%S")
  
  #dfx <- subset(dfx, select=c(10,4,5,7,8,9))  
  
  # ---------------------------------------------------
  # Save To PNG   
  # ---------------------------------------------------

  png("./plot4.png", width=480, height=480)
  
  # ---------------------------------------------------
  # Set display layout = 2 Columns and 2 Rows  
  # ---------------------------------------------------
  
  par(mfcol = c(2,2))
  
  # -----------------------------------------------------------
  # Draw Plot: Date Time / Global Active Power(kilowatts)
  # -----------------------------------------------------------

  plot(dfx$DateTime, dfx$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)")
  
  # -----------------------------------------------------------
  # Draw Plot: Date Time / Sub_metering_ ( 1 - 3 )
  # -----------------------------------------------------------

  plot(dfx$DateTime, dfx$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
  
  lines(dfx$DateTime, dfx$Sub_metering_2, type = "l", col = "red" )
  
  lines(dfx$DateTime, dfx$Sub_metering_3, type = "l", col = "blue" )
  
  legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))

  # -----------------------------------------------------------
  # Draw Plot: Date Time / Voltage
  # -----------------------------------------------------------
  
  plot(dfx$DateTime, dfx$Voltage, type = "l", xlab = "Date Time", ylab = "Voltage")

  # -----------------------------------------------------------
  # Draw Plot: Date Time / Global Reactive Power
  # -----------------------------------------------------------
  
  plot(dfx$DateTime, dfx$Global_reactive_power, type = "l", xlab = "Date Time", ylab = "Global Reactive Power")

  dev.off()
  
}

