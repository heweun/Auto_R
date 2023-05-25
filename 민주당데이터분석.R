media_t2<-data.frame(
  media=rep(c("인터넷","지상파TV","OOH","케이블TV","디지털동영상","SNS",
              "라디오","IPTV","잡지","신문","영화"),times=3),
  touchr=c(95.7,80.2,66.2,65.5,64.4,63.3,26.2,23.1,11.3,9.9,6.6,
           98.9,67.3,71.7,54.6,79.6,80.6,17.9,28.8,10.6,4.3,9.5,
           95.9,78.4,65.7,64.0,65.4,64.0,24.5,22.6,10.6,9.2,6.6),
  targeta=c(rep("p1969",11),rep("p2039",11),rep("total",11)))

str(media_t2)
media_t2$targeta<-as.factor(media_t2$targeta)

colorchip <- c("#d1495b", "#edae49", "#66a182")

ggplot(media_t2,aes(x=reorder(media,-touchr), y=touchr, fill=targeta))+
  geom_bar(stat="identity",position = "dodge")+
  scale_fill_manual(values=colorchip)+
  labs(title="매체별 타깃분석",x="매체명",y="횟수",fill="타깃나이")+
  geom_text(aes(y=touchr+3, label=touchr), position=position_dodge(width=1),size=2.5)+ 
  theme_bw()+
  theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(), panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank())+
  theme(axis.title.x=element_blank())+
  theme(plot.title = element_text(hjust = 0.5))
  
#색깔, 순서, 제목 바꾼 그래프, 텍스트 크기 조정, 격자 제거