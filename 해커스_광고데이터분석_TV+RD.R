##########라디오 데이터 정리
library(dplyr)
A<-read.csv("C:\\Users\\admin\\Desktop\\RD_raw.csv",header=T)
View(A)
str(A)

A$일자<-as.Date(A$일자)
A2<-subset(A,업종!="Total")
A2$Year<-format(A2$일자, format="%y")
A2$Month<-format(A2$일자, format="%m")
A2$Date<-format(A2$일자, format="%d")
A2$Program<-gsub(pattern = '\\d부',
                 replacement = "",x=A2[,10])

A2<-A2%>%arrange(프로그램)
write.csv(A2,"C:\\Users\\admin\\Desktop\\2021.12 온라인 교육 업종 RD Data.csv")

###########TV금액/횟수 확인
B<-read.csv("C:\\Users\\admin\\Desktop\\Month_raw.csv",header=T)
B2<-subset(B,업종!="Total")
colnames(B2)[10]="케이블"
colnames(B2)[11]="종편"
B2$연월<-sprintf("%.2f",B2$연월)
str(B2)
B2$Year<-substr(B2$연월,1,2)
B2$Month<-substr(B2$연월,4,5)

C<-read.csv("C:\\Users\\admin\\Desktop\\Name_company.csv",header=T)
colnames(C)[2]="상품"
colnames(C)[3]="Product"

B2<-merge(B2,C[,c(2,3)],by='상품',all.x=T)
B2$CATV<-B2$케이블+B2$종편
B2$TVTotal<-B2$지상파+B2$케이블+B2$종편

B3<-subset(B2,항목=="금액")
B3<-B3%>%arrange(연월)
B4<-subset(B2,항목=="횟수")
B4<-B4%>%arrange(광고주,연월)

write.csv(B3,"C:\\Users\\admin\\Desktop\\2021.1-12 온라인 교육 업종 5대매체_광고비.csv")
write.csv(B4,"C:\\Users\\admin\\Desktop\\2021.1-12 온라인 교육 업종 5대매체_집행횟수.csv")


##na.omit()
##이름 합치기
##유형별로 추출하기