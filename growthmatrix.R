# Script uses LobstaRecords from IBLS output files to create four (seasonal) growth matrices
# Code uses count data of individuals to inform probability matrices of size growth from one bin to another
# in a given time step

# Preliminaries
which_growth = "G2_S2"              # Which IBM output? 

setwd(paste("C:/Users/ChenLab/Desktop/IBM/IBM_", which_growth, sep=""))     # change as needed

# calls all records as t___
for (i in 1:148){
  assign(paste('t',i,sep=''),read.delim(paste('LobstaRecord_',i,'.txt',sep=''),
      sep="",header=FALSE, col.names=c('ID','TYPE','SEX','TIMESTEP','LENGTH',
      'BIN','MATURECOUNTER','NOMOLTCOUNTER','VNOTCHCOUNTER','EGGCOUNTER',
      'EGGTIMESTEP','MOTLNUMBER','DIEINFORMATION','VNOTCHINFORMATION',
      'FISHERYRECRUITMENTINFORMATION','MOLTINCREMENTINFORMATION','MOLTTIMESTEP',
      'AREA','MPA','FISHERY')))
}

# sexes together bin frame
tmpa<-cbind(t1$ID,t1$BIN)
colnames(tmpa)<-c('ID','BINt1')
df_a<-as.data.frame(tmpa)
require(dplyr)
for (i in 2:148){
  tmpa<-get(paste('t',i,sep=''))
  tmpa<-cbind(tmpa$ID,tmpa$BIN)
  colnames(tmpa)<-c('ID',paste('BINt',i,sep=''))
  tmpa<-as.data.frame(tmpa)
  df_a<-full_join(df_a,tmpa)
}

# make the magic happen
if (!split_sex) {
  bins.df = df_a[,2:ncol(df_a)]
} 
temp1Q.m = temp2Q.m = temp3Q.m = temp4Q.m = matrix(0,35,35) 
for (i in 1:(ncol(bins.df)-1)) {
  for (j in 1:nrow(bins.df)) {
    growth_step = bins.df[j,c(i,i+1)]
    growth_step1 = as.numeric(growth_step[1])
    growth_step2 = as.numeric(growth_step[2])
    if ((i+1)%%4 == 0) {
      temp4Q.m[growth_step1,growth_step2] = temp4Q.m[growth_step1,growth_step2]+1
      temp4Q.m[growth_step2,growth_step1] = temp4Q.m[growth_step2,growth_step1]+1
    }
    if ((i+1)%%4 == 3) {
      temp3Q.m[growth_step1,growth_step2] = temp3Q.m[growth_step1,growth_step2]+1
      temp3Q.m[growth_step2,growth_step1] = temp3Q.m[growth_step2,growth_step1]+1
    }
    if ((i+1)%%4 == 2) {
      temp2Q.m[growth_step1,growth_step2] = temp2Q.m[growth_step1,growth_step2]+1
      temp2Q.m[growth_step2,growth_step1] = temp2Q.m[growth_step2,growth_step1]+1
    }
    if ((i+1)%%4 == 1) {
      temp1Q.m[growth_step1,growth_step2] = temp1Q.m[growth_step1,growth_step2]+1
      temp1Q.m[growth_step2,growth_step1] = temp1Q.m[growth_step2,growth_step1]+1
    }
    print(paste(i,"_",j,sep=''))
  }
}
for (i in 1:nrow(temp1Q.m)) {
  for (j in 1:ncol(temp1Q.m)) {
    if (i > j) {
      temp1Q.m[i,j] = 0
      temp2Q.m[i,j] = 0
      temp3Q.m[i,j] = 0
      temp4Q.m[i,j] = 0
    }
  }
}

# make the matrices
growth_matrix1Q = growth_matrix2Q = growth_matrix3Q = growth_matrix4Q = matrix(0,35,35)
for (i in 1:nrow(growth_matrix1Q)) {
  for (j in 1:ncol(growth_matrix1Q)) {
    growth_matrix1Q[i,j] = temp1Q.m[i,j]/sum(temp1Q.m[i,])
    growth_matrix2Q[i,j] = temp2Q.m[i,j]/sum(temp2Q.m[i,])
    growth_matrix3Q[i,j] = temp3Q.m[i,j]/sum(temp3Q.m[i,])
    growth_matrix4Q[i,j] = temp4Q.m[i,j]/sum(temp4Q.m[i,])
  }
}

write.csv(growth_matrix1Q, paste("C:/Users/ChenLab/Desktop/IBM/IBM_", which_growth, "/g1Q.csv", sep=""))
write.csv(growth_matrix2Q, paste("C:/Users/ChenLab/Desktop/IBM/IBM_", which_growth, "/g2Q.csv", sep=""))
write.csv(growth_matrix3Q, paste("C:/Users/ChenLab/Desktop/IBM/IBM_", which_growth, "/g3Q.csv", sep=""))
write.csv(growth_matrix4Q, paste("C:/Users/ChenLab/Desktop/IBM/IBM_", which_growth, "/g4Q.csv", sep=""))





















