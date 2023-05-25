myvector=c(1:6,"a")
myvector

mylist=list(1:6,"a")
mylist

obj1=1:4
obj2=6:10
obj3=list(obj1,obj2)
obj3
mylist=list(obj1,obj2,obj3)
mylist

mylist[[3]][1] #리스트
mylist[[3]][[1]] #백터
mylist[[3]][[1]][2] #원소

myvector=c(1:6,'a')
mylist=list(1:6,'a')
unlist(mylist)==myvector

mylist
mean(mylist[[1]][1:6])
mean(unlist(mylist)[1:6])
mean(myvector)

name1="Donald"
myspace=" "
name2="Trump"
list(name1,myspace,name2)
unlist(list(name1,myspace,name2))

##attr(): 속성함수_특정변수에 속성값 부여

name=c('갑','을','병','정')
gender=c(2,1,1,2)
mydata=data.frame(name,gender)
mydata
attr(mydata$name,"what the variable means")="응답자의 이름"
mydata$name
attr(mydata$gender,"what the variable means")="응답자의 성별"
mydata$gender
myvalues=gender
for(i in 1:length(gender)){
  myvalues[i]=ifelse(gender[i]==1,"남성","여성")
}
attr(mydata$gender,"what the value means")=myvalues
mydata$gender

attr(mydata$gender,"what the value means")
mydata$gender.character=attr(mydata$gender,"what the value means")
#지정된 메타 데이터 추출 방법
mydata 

mylist=list(1:4,6:10,list(1:4,6:10))
mylist
lapply(mylist[[3]],mean)
lapply(mylist,mean)
lapply(mylist[c(1,2,c(1,2))],mean) #리스트 형태로 값 도출

sapply(mylist[c(1,2,c(1,2))],sum) #벡터 형태로 값 도출
unlist(lapply(mylist[c(1,2,c(1,2))],sum))

worldlist=c("the","is","a","the")
doc1freq=c(3,4,2,4)
doc2freq=rep(1,4)
tapply(doc1freq,worldlist,length)
tapply(doc2freq,worldlist,length)
tapply(doc1freq,worldlist,sum)
tapply(doc2freq,worldlist,sum) #벡터를 테이블 형태로
#length=개수 세기 sum=빈도 세기

sent1=c("earth","to","earth")
sent2=c("ashes","to","ashes")
sent3=c("dust","to","dust")
myfreq=c(rep(1,length(sent1)),rep(1,length(sent2)),rep(1,length(sent3)))
tapply(myfreq,c(sent1,sent2,sent3),sum)
