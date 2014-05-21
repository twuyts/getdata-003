source('getdataset.R');
data_train<-getdataset("train");
data_test<-getdataset("test");

alldata<-rbind(data_test, data_train);
tidydata<-ddply(alldata, .(subject, activity), function(x) colMeans(x[c(3:563)]));
