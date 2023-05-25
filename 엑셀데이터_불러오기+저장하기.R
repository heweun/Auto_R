###엑셀 파일 불러오기
library(readxl) #작업 디렉토리, 파일명에 한글 불가
library(rJava)
library(xlsx)

getwd() #작업 디렉토리 확인
setwd("C:\\Users\\admin\\Desktop")


name=read_excel("C:\\Users\\admin\\Desktop\\add\\TV_MPP.xlsx")
A=read_excel("Traha.xlsx")
A=A[-1800,] #total 자리에 따라

A$일자<-as.Date(A$일자)
A2<-A
A2$Year<-format(A2$일자, format="%y")
A2$Month<-format(A2$일자, format="%m")
A2$Date<-format(A2$일자, format="%d")

A2<-merge(A2,name,by='채널',all.x=T)
colnames(A2)[20:22]=c("Channel","MPP","구분")
table(is.na(A2))

write.xlsx(A2,                # R데이터명
           file="C:/Users/admin/Desktop/Traha.xlsx",  # 여기서는 기존의 엑셀 파일이라고 설정함
           sheetName="트라하_raw", # 기존의 엑셀 파일에 new라는 시트에 데이터를 넣음
           col.names=TRUE,  # 변수이름을 그대로 사용
           row.names=FALSE,# 행이름은 사용하지 않음
           append=TRUE)      # 기존의 엑셀 파일이 있으면 그곳에 추가해서 저장



#####################################
read_excel(path,
           sheet=#number or name,
             range=#불러올 영역만 A1:B10,
             na=""#공백을 결측치로 인식,
           trim_ws=FALSE#띄어쓰기 살리기,
           )



###엑셀 저장하기
library(rJava)
library(xlsx)

write.xlsx(A2,                # R데이터명
           file="C:/Users/admin/Desktop/game.xlsx",  # 여기서는 기존의 엑셀 파일이라고 설정함
           sheetName="트라하_raw", # 기존의 엑셀 파일에 new라는 시트에 데이터를 넣음
           col.names=TRUE,  # 변수이름을 그대로 사용
           row.names=FALSE,# 행이름은 사용하지 않음
           append=TRUE)      # 기존의 엑셀 파일이 있으면 그곳에 추가해서 저장
#######################################
# 작업공간에 있는 엑셀 파일의 목록을 저장
setwd("C:\\Users\\admin\\Desktop\\excel")
fileNames = list.files(pattern="xlsx")



# for문을 이용하여 여러 개의 엑셀 파일을 읽어오고,

# 엑셀 파일의 이름과 동일하게 각각의 R데이터를 생성한다.

A=function(x){
  setwd(x)
  fileNames = list.files(pattern=x)
  for(i in 1:length(fileNames)){
    a = read_excel(path=fileNames[i], sheet=1, col_names=TRUE)
    assign(x=fileNames[i], value=a)}
  rm(a)
  }

A(B)

getwd()

assign(x=fileNames[1], value=data)

A=A[-1800,] #total 자리에 따라

for(i in 1:length(fileNames)){
  x=fileNames[i]
  x$일자<-as.Date(X$일자)
}


A$일자<-as.Date(A$일자)
A2<-A
A2$Year<-format(A2$일자, format="%y")
A2$Month<-format(A2$일자, format="%m")
A2$Date<-format(A2$일자, format="%d")

A2<-merge(A2,name,by='채널',all.x=T)
colnames(A2)[20:22]=c("Channel","MPP","구분")
table(is.na(A2))

write.xlsx(A2,                # R데이터명
           file="C:/Users/admin/Desktop/Traha.xlsx",  # 여기서는 기존의 엑셀 파일이라고 설정함
           sheetName="트라하_raw", # 기존의 엑셀 파일에 new라는 시트에 데이터를 넣음
           col.names=TRUE,  # 변수이름을 그대로 사용
           row.names=FALSE,# 행이름은 사용하지 않음
           append=TRUE)      # 기존의 엑셀 파일이 있으면 그곳에 추가해서 저장
