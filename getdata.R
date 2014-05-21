library("sqldf");
activity_names<-read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names=c("activity_id", "activity"));
features<-read.table("UCI HAR Dataset/features.txt", header=FALSE);

# training set
subjects<-read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names="subject");
activity_ids<-read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names="activity_id");
y<-sqldf("select activity from activity_ids join activity_names using (activity_id)");
X<-read.table("UCI HAR Dataset/train/X_train.txt", 
                 header=FALSE, col.names=features[,2], 
                 colClasses=c(rep("numeric",561)));
mean_std_X<-X[,which(grepl("mean|std",colnames(X)))];
data_train<-cbind(subjects,y,mean_std_X);


# test set
subjects<-read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names="subject");
activity_ids<-read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names="activity_id");
y<-sqldf("select activity from activity_ids join activity_names using (activity_id)");
X<-read.table("UCI HAR Dataset/test/X_test.txt", 
                 header=FALSE, col.names=features[,2], 
                 colClasses=c(rep("numeric",561)));
mean_std_X<-X[,which(grepl("mean|std",colnames(X)))];
data_test<-cbind(subjects,y,mean_std_X);

data<-rbind(data_test, data_train);


