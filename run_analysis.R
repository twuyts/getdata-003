source('getdataset.R');
alldata<-rbind(getdataset("test"), getdataset("train"));
tidydata<-ddply(alldata, .(subject, activity), function(x) colMeans(x[c(3:81)]));
