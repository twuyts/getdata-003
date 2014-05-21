
data_train<-getdataset("train", TRUE);
data_test<-getdataset("test", TRUE);
data<-rbind(data_test, data_train);
save(data, file="data.rda");


