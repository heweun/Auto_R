##########라디오 데이터 정리
library(dplyr)
library(ggplot2)
x<-read.csv("C:\\Users\\admin\\Desktop\\rd_row.csv",header=T)
View(x)

str(x2)

x$일자<-as.Date(x$일자)
x2<-x
x2$Year<-format(x2$일자, format="%y")
x2$Month<-format(x2$일자, format="%m")
x2$Date<-format(x2$일자, format="%d")
x2$Program<-gsub(pattern = '\\d부',
                 replacement = "",x=x2[,10])
write.csv(x2,"C:\\Users\\admin\\Desktop\\2021.12 온라인 교육 업종 RD Data.csv")



y<-read.csv("C:\\Users\\admin\\Desktop\\cost_row.csv",header=T)
View(y)

str(y)

y$연월<-as.Date(y$연월)
y2<-y
y2$Year<-format(y2$연월, format="%y")
y2$Month<-format(y2$연월, format="%m")
y2$product<-#
y2$CATV<-y2$케이블.닐슨추정보너스.케이블+y2$종편.닐슨추정보너스.종편
y2$TVTOTAL<-지상파+케이블+종편

write.csv(x2,"C:\\Users\\admin\\Desktop\\2021.12 온라인 교육 업종 RD Data.csv")



mydata<-read.csv("C:\\Users\\admin\\Desktop\\count_row2.csv")
str(mydata$연월)
mydata2<-mydata

nchar(21.01)


y<-cbind(x,a)



b<-y%>%
  group_by(a)%>%
  summarise(sum_횟수=sum(횟수),sum_금액=sum(금액))%>%
  arrange(desc(sum_금액))
z<-merge(y,b)

#부수 살려서
c<-x%>%
  group_by(프로그램)%>%
  summarise(sum_횟수=sum(횟수),sum_금액=sum(금액))%>%
  arrange(desc(sum_금액))

write.csv(z,"C:\\Users\\admin\\Desktop\\rd.csv")


##채널별로 분석
z[-1,]%>%
  group_by(채널)%>%
  summarise(sum_횟수=sum(횟수),sum_금액=sum(금액))%>%
  ggplot(aes(x=채널,y=sum_횟수))+
  geom_bar(stat='identity')

z[-1,]%>%
  group_by(채널)%>%
  summarise(sum_횟수=sum(횟수),sum_금액=sum(금액))%>%
  ggplot(aes(x=reorder(채널,-sum_금액),y=sum_금액,fill=채널))+
  geom_bar(stat='identity')+
  scale_fill_manual(values=channelcol)+
  geom_text(aes(label=sum_금액),vjust=-0.3)+
  labs(title="라디오 광고비",x="채널명",y="집행비")+
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))

channelcol<-c('MBC-FM'='#FA93E1',
  'SBS-FM'='#32D4CD',
  'SBS-RD'='#32D479',
  'KBS-2RD'='#D5E04D',
  'KBS-2FM'='#F07865',
  'CSB-FM'='#c70125',
  'YTN-FM'='#000000',
  'FEBC-AM'='#c30452',
  'CBR-RD'='#315288') 
##채널별 색깔 지정, 색깔 변경
##금액 크기에 따라 순서변경
