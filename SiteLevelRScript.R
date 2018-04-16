#Code to unzip, subset, and write modified Site by IM Factview#

 #Part 1: Set working directory
setwd("C:/Working Files/Care and Treatment/C&T Dashboard Work/FY17 Work/VL Work/Site FV")

#Part 2: 
#fileNames<-Sys.glob("*.zip")
#for (fileName in fileNames) {
  #Unzip data:
 # unzip(fileName)
#}
extension <- "txt"
fileNames <- Sys.glob(paste("*.", extension, sep = ""))
fileNumbers <- seq(fileNames)
for (fileNumber in fileNumbers) {
 
  type<-c(rep("character",45),rep("numeric",16))
  df<-read.delim(fileNames[fileNumber],header=T,colClasses=type,fill=T,fileEncoding="UTF-8-BOM")
  #read in your csv:
  newfileName <-paste("man-", 
                      sub(paste("\\.", extension, sep = ""), "", fileNames[fileNumber]), 
                      ".", extension, sep = "")
 
  
  #Create a subset of the dataset for multiple indicators at a time
  vmdata<-df[df$indicator %in% c("TX_PVLS", "LAB_PTCQI","PMTCT_ART",
                                 "TX_CURR", "TX_NEW", 
                                 "LAB_PTCQI_MIL", "TX_RET",
                                 "EMR_SITE", "EMR_SITE_MIL"),]
  # Add a blank before age band value so the variable will be
  # recognized as text when writing csv file
  df$age<-paste(" ",df$age)
  
  write.table(vmdata, newfileName, sep="\t", row.names = F, col.names=T, na="")}
  