open<-read.csv(file="gdp_between_old.csv", header=TRUE, sep=",")
write.table(open, file="gdp_between.csv", sep=";", row.names = FALSE, quote = FALSE)
