##########라디오 데이터 정리
library(dplyr)
library(ggplot2)
x<-read.csv("C:\\Users\\admin\\Desktop\\2111.csv",header=T)
View(x)

a<-gsub(pattern = '\\d부',
     replacement = "",x=x[,10])
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
