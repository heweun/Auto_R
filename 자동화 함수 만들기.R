library(readxl)
library(rJava)
library(xlsx)
getwd()
setwd("C:\\Users\\admin\\Desktop\\flint")
fileNames = list.files(pattern="xlsx")

for(i in 1:length(fileNames)){
  data = read_excel(path=fileNames[i], sheet=1, col_names=F)
  data=data[-c(1,nrow(data)),]
  names(data)=data[1,]
  data=data[-1,]
  if(ncol(data)>=16){ 
    data$일자=as.Date(data$일자)
    data$Year=format(data$일자, format="%y")
    data$Month=format(data$일자, format="%m")
    data$Date=format(data$일자, format="%d")
    name=read_excel("C:\\Users\\admin\\Desktop\\add\\TV_MPP.xlsx")
    data=merge(data,name,by='채널',all.x=T)
    #data=subset(data,MPP!="NA")
    data[is.na(data)]=""
    data[,14]=as.numeric(data[,14])
    data[,15]=as.numeric(data[,15])
    data[,16]=as.numeric(data[,16])
    data[,17]=as.numeric(data[,17])
    data[,18]=as.numeric(data[,18])
    data[,19]=as.numeric(data[,19])
  }else{
    #data$연월=sprintf("%.2f",data$연월)
    data$Year=substr(data$연월,1,2)
    data$Month=substr(data$연월,4,5)
    data=data.frame(data)
  }
  assign(x=fileNames[i], value=data)
  rm(data)
}


total=rbind(year_2020.xlsx,year_2021.xlsx,year_2022.xlsx,netflix.xlsx)
table(total$상품)

openxlsx::write.xlsx(total,
                     file ="C:\\Users\\admin\\Desktop\\flint\\raw\\total.xlsx",
                     col.names=TRUE,  
                     row.names=FALSE)


nexon=subset(total,상품=="넥슨바람의나라연")
sister=subset(total,상품=="데브시스터즈쿠키런킹덤")
nc=subset(total,상품=="엔씨소프트리니지W")
nc2=subset(total,상품=="엔씨소프트블레이드앤소울2")
kakao=subset(total,상품=="카카오게임즈오딘발할라라이징")
netfilx=subset(total,상품=="넷플릭스지금우리학교는")
craft=subset(total,상품=="크래프톤배틀그라운드뉴스테이트")


write.xlsx(nexon,                # R데이터명
           file ="C:\\Users\\admin\\Desktop\\flint\\raw\\cost.xlsx",
           col.names=TRUE,  
           row.names=FALSE,
           sheetName="바람의나라_raw",
           append=T)

write.xlsx(sister,                # R데이터명
           file ="C:\\Users\\admin\\Desktop\\flint\\raw\\cost.xlsx",
           col.names=TRUE,  
           row.names=FALSE,
           sheetName="쿠키런_raw",
           append=T)

openxlsx::write.xlsx(nc,                # R데이터명
           file ="C:\\Users\\admin\\Desktop\\flint\\raw\\nc.xlsx",
           col.names=TRUE,  
           row.names=FALSE)

openxlsx::write.xlsx(nc2,                # R데이터명
           file ="C:\\Users\\admin\\Desktop\\flint\\raw\\nc2.xlsx",
           col.names=TRUE,  
           row.names=FALSE)

openxlsx::write.xlsx(kakao,                # R데이터명
           file ="C:\\Users\\admin\\Desktop\\flint\\raw\\kakao.xlsx",
           col.names=TRUE,  
           row.names=FALSE)

write.xlsx(netfilx,                # R데이터명
           file ="C:\\Users\\admin\\Desktop\\flint\\raw\\cost.xlsx",
           col.names=TRUE,  
           row.names=FALSE,
           sheetName="지금우리학교는_raw",
           append=T)

openxlsx::write.xlsx(craft,                # R데이터명
           file ="C:\\Users\\admin\\Desktop\\flint\\raw\\craft.xlsx",
           col.names=TRUE,  
           row.names=FALSE)


library(dplyr)
cost=total%>%
  group_by(광고주,상품,구분,Channel,Year,Month,Date)%>%
  summarise(금액=sum(금액))


openxlsx::write.xlsx(cost,                # R데이터명
           file ="C:\\Users\\admin\\Desktop\\flint\\raw\\cost_total.xlsx",
           col.names=TRUE,  
           row.names=FALSE)
install.packages("openxlsx")

cost_광고주=total%>%
  group_by(광고주)%>%
  summarise(sum=sum(금액))

cost_광고주_date=total%>%
  group_by(광고주,Year,Month)%>%
  summarise(sum=sum(금액))

cost_광고주_Channel=total%>%
  group_by(광고주,Channel)%>%
  summarise(sum=sum(금액))
           



for(i in 1:length(fileNames)){
  data = read_excel(path=fileNames[i], sheet=1, col_names=F)
  data=data[-c(1,nrow(data)),]
  names(data)=data[1,]
  data=data[-1,]
  print(data)
  #assign(x=fileNames[i], value=data)
}





#re_excel=function(x){
#  fileNames=list.files(path=x,pattern = "xlsx")
#  setwd(x)
#  a=data.frame()
#  for (i in 1:length(fileNames)){
#    data=read_excel(path=fileNames[i],col_names = F)
#    data=data[-c(1,nrow(data)),]
#    names(data)=data[1,]
#    data=data[-1,]
#    assign(x=fileNames[i], value=data)
#    a=rbind(a,data)
#  }
  
#} #이 데이터는 어디에 가는 걸까?
  #함수 안으로 들어갔는데..

