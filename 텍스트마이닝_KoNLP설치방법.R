install.packages("multilinguer")
library(multilnguer)

install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP',upgrade="never",INSTALL_opts=c("--no-multiarch"))

library(KoNLP)
extractNoun("인하대학교 공학대학원 블록체인 전공입니다.")

install.packages(c("hash","tau","Sejong","RSQLite","devtools","bit","rex","laryrval","htmlwidgets"))