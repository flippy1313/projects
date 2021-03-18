rm(list = ls()) 
load("model.RData")
prediction <- function(dat){
  a1=dat[,1]
  a2=dat[,2]
  a3 =dat[,3]
  feature = c()
  feature[1] = 1
  k =2
  h = c(3,10,30,60,120,180,240,360,480,600,720,960,1200,1440)
  for(i in h){
    feature[k] = br(a1,1440,i)
    feature[k+1] = br(a2,1440,i)
    feature[k+2] = br(a3,1440,i)
    k = k+3
  }
  input = c()
  input[2:34] = feature[-c(1,14,12,16,19,40,33,10,13,28)]
  input[1] = 1
  

  
  return(input%*%coefficient)
}






br <- function(x,t,h){
  if(t<= h+1){
    br = (x[t]-x[1])/x[1]
  }
  else{
    br = (x[t]-x[t-h])/x[t-h]
    
  }
  return(br)
}











