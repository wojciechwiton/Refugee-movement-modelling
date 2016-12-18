#X^2-test
chisq.test(c(1,1,1),c(1,1,1))

M <- as.table(rbind(c(762, 327, 468), c(484, 239, 477)))
dimnames(M) <- list(gender = c("F", "M"),
                    party = c("Democrat","Independent", "Republican"))
M
(Xsq <- chisq.test(M))  # Prints test summary

historic<-read.csv("/Users/sylviaschumacher/Desktop/historic_v2.csv",sep=";")
predicted<-read.csv("/Users/sylviaschumacher/Desktop/predicted_v2.csv", sep=";")
colnames(historic)==colnames(predicted)

as.table(rbind(historic[6,-1],predicted[6,-1]))
2015test<-as.table(rbind(historic[6,-1],predicted[6,-1]))


chisq.test(rbind(predicted[6,c(-1,-35)],historic[6,c(-1,-35)])) #test 2015

chisq.test(rbind(historic[2,-1],predicted[2,-1]))

#?ks.test
#ks.test(x=predicted[6,-1],y=historic[6,-1])
length(colnames(historic))

#RMSE
install.packages("hydroGOF")
library(hydroGOF)
a=rmse(sim=predicted[6,-1], obs=historic[6,-1])
plot(a)

rmse(sim=predicted[6,-1], obs=historic[6,-1]) #2015
historic[6,-1]


rmse(sim=predicted[5,-1], obs=historic[5,-1])/historic[5,-1] #2014

#Weighted X^2
install.packages("weights")
library(weights)
wtd.chi.sq(var1=predicted[6,-1], var2=historic[6,-1])

##Without turkey
which(colnames(historic)=="Turkey")
wtd.chi.sq(var1=predicted[6,c(-1,-35)], var2=historic[6,c(-1,-35)])

#Calculate RMSD for 2015

sqrt(sum((predicted[6,c(-1,-35)]-historic[6,c(-1,-35)])^2)/length(historic[6,c(-1,-35)]))

max(historic[6,c(-1,-35)])
min(historic[6,c(-1,-35)])
#normalized

sqrt(sum((predicted[6,c(-1,-35)]-historic[6,c(-1,-35)])^2)/length(historic[6,c(-1,-35)]))
/(max(historic[6,c(-1,-35)])-min(historic[6,c(-1,-35)]))

#Comparing flows

sum(historic[6,c(-1,-35)])
sum(predicted[6,c(-1,-35)])

sum(historic[6,35])
sum(predicted[6,35])

sum(historic[6,-1])
sum(predicted[6,-1])

(5089830-2989613)/2989613
(386485-485767)/485767
(4703345-2503846)/2503846

#coefficient of determination
historic=stack(historic[6,c(-1,-35)])
mean(historic$values)
predicted=stack(predicted[6,c(-1,-35)])

SSRES<-sum((historic$values-predicted$values)^2)
SSTOT<-sum((historic$values-mean(historic$values))^2)
1-(SSRES/SSTOT)


