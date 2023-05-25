library(rvest)
library(tidyverse)
url="https://news.naver.com/main/read.naver?mode=LSD&mid=shm&sid1=103&oid=052&aid=0001302291"
read_html(url)
read_html(url)%>%
  html_nodes('h3')
read_html(url)%>%
  html_nodes('h3#articleTitle')
a<-read_html(url)%>%
  html_nodes('h3#articleTitle')%>%
  html_text()
b<-read_html(url)%>%
  html_nodes('._article_body_contents')%>%
  html_text()
a_f<-data.frame(a)
b_f<-data.frame(b)
c<-cbind(a_f,b_f)
write.csv(c,'C:/Users/admin/Desktop/new.csv')

b_pre<-gsub("[\r\n\t]"," ",b) #이스케이프 문자 제거
b_pre=gsub('[[:punct:]]'," ",b_pre) #문장 부호 제거
b_pre=gsub('[[:cntrl:]]'," ",b_pre) #특수 문자 제거
b_pre=gsub('\\d+'," ",b_pre) #숫자 제거
#b_pre=gsub('[a-z]'," ",b_pre) #영문 소문자 제거
#b_pre=gsub('[A-Z]'," ",b_pre) #영문 대문자 제거
b_pre=gsub('\\s+'," ",b_pre) #2개 이상 공백 교체
b_pre

##특정 문자 제거 후 space_bar 이용, 공백으로 교체

base_url<-"https://search.naver.com/search.naver?where=news&sm=tab_pge&query=%ED%99%88%ED%94%8C%EB%9F%AC%EC%8A%A4&sort=0&photo=0&field=0&pd=3&ds=2022.01.21&de=2022.01.21&cluster_rank=54&mynews=0&office_type=0&office_section_code=0&news_office_checked=&nso=so:r,p:from20220121to20220121,a:all&start="
urls<-NULL
for(x in 0:5){
  urls<-c(urls,paste(base_url,x*10+1,sep=''))
}
urls

html=read_html(urls[1])
html

htmlnode=html_nodes(html,'ul.list_news>li>div>a')
htmlnode
html_attr(htmlnode,'href')

urls[1]%>%
  read_html()%>%
  html_nodes('ul.list_news>li>div>a')%>%
  html_attr('href')

##########
url_wiki="https://en.wikipedia.org/wiki/Student%27s_t-distribution"
html_wiki=read_html(url_wiki,encoding = 'UTF-8')
html_wiki%>%
  html_nodes(".wikitable")%>%
  html_table()

url_kadd="https://www.adresearch.co.kr/M1_form.asp?addr=M1_1"
html_kadd=read_html(url_kadd,encoding = 'UTF-8')
html_kadd%>%
  html_nodes("#tbl1.zeroTable")%>%
  html_table()
