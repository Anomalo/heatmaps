args<-commandArgs(TRUE)
library(RColorBrewer)
library(gplots)
files = c('crossover.csv','fpkmnoduplicats.csv','postfed.csv')
max = 15

f = args
print(f)
pname = paste(f,max,'png',sep='.')
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
min = -max
data[data<min] <- min
data[data>max] <- max
#memory.limit(30000)

#data = head(data)
data_matrix <- data.matrix(data)
col <- colorRampPalette(c("blue", "white", "red"))(n = 1000)
png(pname,width=6,height=16,units="in",res=1000)
heatmap.2(data_matrix,col=col,keysize=2,margins=c(7,1),trace = 'none',labRow='',Colv=FALSE)
dev.off()


print(pname)
