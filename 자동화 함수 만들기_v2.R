library(readxl)
library(rJava)
library(xlsx)
library(dplyr)
library(ggplot2)
getwd()
setwd("C:\\Users\\hoeeun\\Desktop\\wavve")
fileNames = list.files(pattern="xlsx")
fileNames

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
    name=read_excel("C:\\Users\\hoeeun\\Desktop\\TV_MPP.xlsx")
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


total=rbind(else_2021.xlsx,else_2022.xlsx,wavve_2021.xlsx)
str(total)
total$Year=as.factor(total$Year)
names(total)
table(total$광고주)
total%>%
  group_by(Year,광고주)%>%
  summarise(광고노출=n())%>%
  #filter(Year==21)%>%
  ggplot(aes(x=광고주,y=광고노출,fill=Year))+
  geom_bar(stat = "identity",position = "dodge")+
  scale_fill_manual(values = c( "#0033FF","#33FFFF"))+
  theme_bw()+
  theme(axis.text.y=element_blank())+
  scale_y_continuous(breaks=NULL)+
  theme(axis.title.y=element_text(angle=0,vjust=0.5))

total%>%
  group_by(Year,광고주)%>%
  summarise(광고비=sum(금액))%>%
  #filter(Year==21)%>%
  ggplot(aes(x=광고주,y=광고비,fill=Year))+
  geom_bar(stat = "identity",position = "dodge")+
  scale_fill_manual(values = c( "#0033FF","#33FFFF"))+
  theme_bw()+
  theme(axis.text.y=element_blank())+
  scale_y_continuous(breaks=NULL)+
  theme(axis.title.y=element_text(angle=0,vjust=0.5))
  #labs(title="OTT 광고비")+
  #theme(plot.title = element_text(hjust = 0.5))


summary(total)

##type=광고 소재
type=total%>%
  group_by(광고주,소재)%>%
  summarise(n())

type
str(type)
type2=data.frame(type)
type2$소재=gsub(",","",type2$소재)
type3=arrange(type2,Year,Month)

names(total)
channel=total%>%
  group_by(광고주,Channel)%>%
  summarise(n())
channel=data.frame(channel)  


write.xlsx(type2,file="C:\\Users\\hoeeun\\Desktop\\wavve\\소재.xlsx")
write.xlsx(type3,file="C:\\Users\\hoeeun\\Desktop\\wavve\\소재2.xlsx")
write.xlsx(channel,file="C:\\Users\\hoeeun\\Desktop\\wavve\\channel.xlsx")

type3%>%
  group_by(광고주,Month)%>%
  summarise(월별=sum(n..))%>%
  ggplot(aes(x=factor(Month),y=월별,fill=광고주))+
  geom_bar(stat="identity",position = "dodge")







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

