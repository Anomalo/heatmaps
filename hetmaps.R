args<-commandArgs(TRUE)
library(gplots)
files = c('crossover.csv','fpkmnoduplicats.csv','postfed.csv')

f = args

pname = paste(f,'png',sep='.')
print(pname)
data <- read.table(f,check.names=FALSE,sep=",",header=TRUE,row.names=1)
means = rowMeans(data)
data = data[!means==0,]
means = means[!means==0]
size <- (length(means))
#data=head(data,100)
#means=head(means,100)
data = data/means

data[data==0] <- 0.00001
data = log2(data)
max = 3
min = -max
data[data<min] <- min
data[data>max] <- max
#memory.limit(30000)


data_matrix <- data.matrix(data)
col = c("#B2182B", "#D6604D", "#F4A582", "#FDDBC7", "#F7F7F7", "#D1E5F0" ,"#92C5DE", "#4393C3" ,"#2166AC")
png(pname,width=6,height=16,units="in",res=1000)
par(mar=c(5,6,4,1)+.1)
heatmap.2(data_matrix,key=NULL,keysize=2,trace = 'none',col=col,labRow='')
dev.off()


