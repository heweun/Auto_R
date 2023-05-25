hey_d<-read.csv('C:\\Users\\admin\\Desktop\\hey_d.csv',header = T)
str(hey_d)

#chr로 인식->date형으로 변경  
str(hey_d$일자)
hey_d$일자<-as.Date(hey_d$일자)

hey_d2<-hey_d
hey_d2$일자<-format(hey_d$일자, format="%m/%d")

hey_d2%>%
  group_by(일자)%>%
  summarise(sum_금액=sum(금액))%>%
  ggplot(aes(x=일자,y=sum_금액,fill=sum_금액))+
  geom_bar(stat='identity')+
  scale_fill_gradient(low="white", high="red")+
  geom_text(aes(label=sum_금액),vjust=-0.3)+
  labs(title="헤이딜러 광고비",y="금액합계") +
  theme_bw()+
  theme(legend.position = "none",
        axis.title.x=element_blank())+
  theme(plot.title = element_text(hjust = 0.5))
##범례, x축 제목 삭제, 연속형 데이터 색깔 변경
  

hey_d2%>%
  group_by(일자)%>%
  summarise(sum_금액=sum(금액))%>%
  ggplot(aes(x=일자,y=sum_금액,fill=일자))+
  geom_bar(stat='identity')+
  geom_text(aes(label=sum_금액),vjust=-0.3)+
  labs(title="헤이딜러 광고비",y="금액합계") +
  theme(plot.title = element_text(hjust = 0.5))
