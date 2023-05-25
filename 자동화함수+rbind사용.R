library(readxl)
library(rJava)
library(xlsx)
getwd()
setwd("C:\\Users\\admin\\Desktop\\mobile")
fileNames = list.files(pattern="xlsx")

for(i in 1:length(fileNames)){
  data = read_excel(path=fileNames[i], sheet=1, col_names=F)
  data=data[-c(1,nrow(data)),]
  names(data)=data[1,]
  data=data[-1,]
  data=data.frame(data)
  data[,14]=as.numeric(data[,14])
  data[,15]=as.numeric(data[,15])
  data[,16]=as.numeric(data[,16])
  assign(x=fileNames[i], value=data)
  rm(data)
}

str(`01.xlsx`)

total=rbind(`01.xlsx`,`02.xlsx`,`03.xlsx`,`04.xlsx`,`05.xlsx`,`06.xlsx`,`07.xlsx`,`08.xlsx`,
            `09.xlsx`,`10.xlsx`,`11.xlsx`,`12.xlsx`)
str(total)

openxlsx::write.xlsx(total,
           file ="C:\\Users\\admin\\Desktop\\mobile\\total.xlsx",
           col.names=TRUE,
           row.names=FALSE)
