library(dplyr)
library(ggplot2)
A<-read.csv("C:\\Users\\admin\\Desktop\\트라하_raw.csv",header=T)
View(A)
str(A)

A$일자<-as.Date(A$일자)
A2<-A
A2$Year<-format(A2$일자, format="%y")
A2$Month<-format(A2$일자, format="%m")
A2$Date<-format(A2$일자, format="%d")

B<-read.csv("C:\\Users\\admin\\Desktop\\참고자료\\방송사_MPP.csv",header=T)
View(B)
B2<-B

A2<-merge(A2,B2,by='채널',all.x=T)
colnames(A2)[20:22]=c("Channel","MPP","구분")
table(is.na(A2))

A2%>%
  group_by(MPP)%>%
  summarise(sum_금액=sum(금액))

channelcol<-c('CJENM'='#FF3333',
              'JTBC'='#FF8230',
              'KBS N'='#FCFF30',
              'MBC Plus'='#62FF30',
              'Mediarep A'='#30F9FF',
              'SBS M&C'='#307EFF',
              'SPOTV'='#BD30FF',
              'KOBACO'='#FF30FC',
              'T cast'='#000000') 
##채널별 색깔 지정, 색깔 변경
##금액 크기에 따라 순서변경/색깔 지정 안하면 있는 범례만


트라하<-A2%>%
  group_by(구분,MPP,Channel,Date)%>%
  summarise(sum_금액=sum(금액))%>%
  ggplot(aes(x=Date,y=sum_금액,fill=MPP))+
  geom_bar(stat='identity')+
  scale_fill_manual(values=channelcol)+
  #scale_fill_gradient(low="white", high="red")+
  #geom_text(aes(label=sum_금액),vjust=-0.3)+
  labs(title="트라하 광고비",y="금액합계") +
  theme_bw()+
  #theme(legend.position = "none",
  #      axis.title.x=element_blank())+
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(c(0,200000))






########언디셈버
C<-read.csv("C:\\Users\\admin\\Desktop\\언디셈버_raw.csv",header=T)
View(C)
str(C)

C$일자<-as.Date(C$일자)
C2<-C
C2$Year<-format(C2$일자, format="%y")
C2$Month<-format(C2$일자, format="%m")
C2$Date<-format(C2$일자, format="%d")

C2<-merge(C2,B2,by='채널',all.x=T)
colnames(C2)[20:22]=c("Channel","MPP","구분")
table(is.na(C2))

C3<-subset(C2,채널!="KBC-TV(광주)"&채널!="OBS")
table(is.na(C3))

C3%>%
  group_by(MPP)%>%
  summarise(sum_금액=sum(금액),mean_금액=mean(금액))


언디셈버<-subset(C3,Date>=12)%>%
  group_by(구분,MPP,Channel,Date)%>%
  summarise(sum_금액=sum(금액))%>%
  ggplot(aes(x=Date,y=sum_금액,fill=MPP))+
  geom_bar(stat='identity')+
  scale_fill_manual(values=channelcol)+
  #scale_fill_gradient(low="white", high="red")+
  #geom_text(aes(label=sum_금액),vjust=-0.3)+
  labs(title="언디셈버 광고비",y="금액합계") +
  theme_bw()+
  #theme(legend.position = "none",
  #      axis.title.x=element_blank())+
  theme(plot.title = element_text(hjust = 0.5))


######그래프 동시에 그리기
library(gridExtra)
grid.arrange(트라하,언디셈버, ncol=2, nrow = 1)


#####엑셀로 저장
library(rJava)
library(xlsx)

write.xlsx(A2,                # R데이터명
           file="C:/Users/admin/Desktop/game.xlsx",  # 여기서는 기존의 엑셀 파일이라고 설정함
           sheetName="트라하_raw", # 기존의 엑셀 파일에 new라는 시트에 데이터를 넣음
           col.names=TRUE,  # 변수이름을 그대로 사용
           row.names=FALSE,# 행이름은 사용하지 않음
           append=TRUE)      # 기존의 엑셀 파일이 있으면 그곳에 추가해서 저장

write.xlsx(C2,                # R데이터명
           file="C:/Users/admin/Desktop/game.xlsx",  # 여기서는 기존의 엑셀 파일이라고 설정함
           sheetName="언디셈버_raw", # 기존의 엑셀 파일에 new라는 시트에 데이터를 넣음
           col.names=TRUE,  # 변수이름을 그대로 사용
           row.names=FALSE,# 행이름은 사용하지 않음
           append=TRUE)

