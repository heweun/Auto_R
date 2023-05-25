letters[3]
LETTERS[3]
length(letters)

tolower("Eye for eye") #소문자로 변환
toupper("Eye for eye") #대문자로 변환

#문자수와 바이트 수는 다름
#알파벳=1바이트/ 국어=2바이트
nchar("Korea")
nchar("Korea",type="bytes")
nchar("한국")
nchar("한국",type="bytes")

nchar("Korea")
nchar("Korea ")
nchar("Korea\t") #탭 공백
nchar("Korea, Republic of")
nchar("Korea, 
Republic of")
nchar("Korea, \nRepublic of") #줄 바꾸기

#단어 단위로 문장 분해
mysentence="Learning R is so interesting"
strsplit(mysentence,split=" ") #리스트 형태로 출력

#문자 단위로 단어 분해
mywords=strsplit(mysentence,split=" ")
strsplit(mywords[[1]][5],split='') #리스트 형태로 출력

myletters=list(rep(NA,5))
for (i in 1:5){
  myletters[i]=strsplit(mywords[[1]][i],split = "")
}
myletters #문자 단위로 분해 리스트 형태로 출력

paste(myletters[[1]],collapse = "")
mywords2=list(rep(NA,5))
for (i in 1:5){
  mywords2[i]=paste(myletters[[i]],collapse = "")
}
mywords2 #분해된 문자 단어로 합치기 리스트 형태로 출력
paste(mywords2,collapse=" ")


R_wiki="R is a programming language for statistical computing and graphics supported by the R Core Team and the R Foundation for Statistical Computing. Created by statisticians Ross Ihaka and Robert Gentleman, R is used among data miners and statisticians for data analysis and developing statistical software. Users have created packages to augment the functions of the R language.
According to surveys like Rexer's Annual Data Miner Survey and studies of scholarly literature databases, R is one of the most commonly used programming language used in data mining. As of February 2022, R ranks 13th in the TIOBE index, a measure of programming language popularity."

#문단 단위로 분해
R_wiki_para=strsplit(R_wiki,split="\n")
R_wiki_para 

#문장 단위로 분해
R_wiki_sent=strsplit(R_wiki_para[[1]],split = "\\. ")
R_wiki_sent

#문단>문장>단어 분해
R_wiki_word=list(NA,NA)
for (i in 1:2){
  R_wiki_word[[i]]=strsplit(R_wiki_sent[[i]],split = " ")
}
R_wiki_word
R_wiki_word[[1]][[2]][3]

#텍스트 위치, 개수 세기
mysentence="Learning R is so interesting"
regexpr("ing",mysentence) #첫번째 등장하는 ing찾기
loc.begin=as.vector(regexpr("ing",mysentence))
loc.begin
loc.length=as.vector(attr(regexpr("ing",mysentence),"match.length"))
loc.length
loc.end=loc.begin+loc.length-1 #시작 지점부터 셌기 때문에 -1 필수!
loc.end

gregexpr("ing",mysentence) #문장 안에 등장하는 모든 ing찾기
length(gregexpr("ing",mysentence)[[1]])#ing 몇번 등장 했는지 찾기
loc.begin=as.vector(gregexpr("ing",mysentence)[[1]])
loc.begin
loc.length=as.vector(attr(gregexpr("ing",mysentence)[[1]],"match.length"))
loc.length
loc.end=loc.begin+loc.length-1
loc.end

regexec("interestin(g)",mysentence)#()이용 종료 위치까지 찾을 수 있음
regexec("interesting",mysentence)#==regexpr의 결과값과 같음
regexec("so (interestin(g))",mysentence)
#'so interesting' 의 시작 위치, 길이
#'interesting' 의 시작 위치, 길이
#'interesting' 의 끝나는 위치, 길이

mysentences=unlist(R_wiki_sent)
regexpr("programming",mysentences)
gregexpr("programming",mysentences) #없으면 결과값=-1

mytemp=regexpr("programming",mysentences)
my.begin=as.vector(mytemp)
my.begin[my.begin==-1]=NA
my.end=my.begin+as.vector(attr(mytemp,"match.length"))
mylocs=matrix(NA,nrow=length(my.begin),ncol = 2)
colnames(mylocs)=c("begin","end")
rownames(mylocs)=paste("sentence",1:length(my.begin),sep=".")
for (i in 1:length(my.begin)){
  mylocs[i,]=cbind(my.begin[i],my.end[i])
}
mylocs


#텍스트 등장 확인
grep("programming",mysentences) #몇 번째 문장에서 단어가 등장했는지 찾아냄
grepl("programming",mysentences) #전체 문장에서 등장여부 T/F로 표시

#텍스트 형태 바꾸기
mysentence="Learning R is so interesting"
sub("ing","ING",mysentence) #첫번째 ing만 변경
gsub("ing","ING",mysentence) #모든 ing 변경

#띄어쓰기 되어 있는 단어들을 고유명사로 만들기
sent1=R_wiki_sent[[1]][1]
new.sent1=gsub("R is a programming language",
               "R_is_a_programming_language",sent1) #"_" 이용해서 한 단어로 만들기
sum(table(strsplit(sent1," ")))
sum(table(strsplit(new.sent1," ")))

#문장에서 의미 없는 단어 삭제
drop.sent1=gsub("and |by |for| the","",new.sent1)
sum(table(strsplit(drop.sent1,split = " ")))

#원하는 표현만 추출OR제거
mypattern=regexpr("ing",mysentence)
regmatches(mysentence,mypattern)#첫번째만

mypattern=gregexpr("ing",mysentence)
regmatches(mysentence,mypattern)#있는거 다 추출

mypattern=regexpr("ing",mysentence)
regmatches(mysentence,mypattern,invert=T)#invert=T 특정 표현 제외

mypattern=gregexpr("ing",mysentence)
regmatches(mysentence,mypattern,invert = T)#있는거 다 제외


strsplit(mysentence,split = "ing")#regmatches와 끝에 ""여부 다름
gsub("ing","",mysentence)#리스트형태X 내부에서 자체적 대채

mysentences
substr(mysentences,1,30) #각 문장의 첫번째부터 30번째까지의 문자 추출


#정규표현 활용하여 조건에 맞는 표현 추출
my2sentence=c("Learning R is so interesting","He is a fascinating singer")
mypattern0=gregexpr("ing",my2sentence)
regmatches(my2sentence,mypattern0)

mypattern1=gregexpr("[[:alpha:]](ing)",my2sentence)
regmatches(my2sentence,mypattern1) #ing직전에 있는 알파벳과 함께 추출

mypattern2=gregexpr("[[:alpha:]]+(ing)",my2sentence)
regmatches(my2sentence,mypattern2) #ing이 포함된 단어 전체 추출

mypattern3=mypattern2=gregexpr("[[:alpha:]]+(ing)\\b",my2sentence)
regmatches(my2sentence,mypattern3) #\\b->ing로 종결 되는 단어만 추출

mypattern=gregexpr("[[:alpha:]]+(ing)\\b",mysentences)
myings=regmatches(mysentences,mypattern)
table(unlist(myings))
mypattern=gregexpr("[[:alpha:]]+(ing)\\b",tolower(mysentences))
myings=regmatches(tolower(mysentences),mypattern)
table(unlist(myings)) #같은 단어 소문자로 변경하여 하나의 단어로

mypattern=gregexpr("(stat)[[:alpha:]]+",tolower(mysentences))
regmatches(tolower(mysentences),mypattern)
 #stat로 시작하는 단어 추출

#문장에 사용된 개별 알파벳 빈도수 구하기(대/소 구분)
#대문자
mypattern=gregexpr("[[:upper:]]",mysentences)
my.uppers=regmatches(mysentences,mypattern)
table(unlist(my.uppers))

#소문자
mypattern=gregexpr("[[:lower:]]",mysentences)
my.lowers=regmatches(mysentences,mypattern)
table(unlist(my.lowers))

#대/소 구분 없이-모두 대문자로 변환
mypattern=gregexpr("[[:upper:]]",toupper(mysentences))
my.alphas=regmatches(toupper(mysentences),mypattern)
mytable=table(unlist(my.alphas))
mytable

mytable[mytable==max(mytable)]
length(mytable)
sum(mytable)

#빈도 그래프 그리기
library(ggplot2)
mydata=data.frame(mytable)
ggplot(mydata,aes(x=Var1,y=Freq,fill=Var1))+
  geom_bar(stat="identity")+
  guides(fill="none")+ #범례 제거
  geom_hline(aes(yintercept=median(mytable)))+ #중위값 표시
  xlab("알파벳")+ylab("빈도수")
