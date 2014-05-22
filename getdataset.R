getdataset<-function(set){
    library("sqldf");
    library("plyr");
    # load activity and feature names
    activity_names<-read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names=c("activity_id", "activity"));
    features<-read.table("UCI HAR Dataset/features.txt", header=FALSE);
    
    # load training set
    subjects<-read.table(paste0("UCI HAR Dataset/",set,"/subject_",set,".txt"), header=FALSE, col.names="subject");
    activity_ids<-read.table(paste0("UCI HAR Dataset/",set,"/y_",set,".txt"), header=FALSE, col.names="activity_id");
    y<-sqldf("select activity from activity_ids join activity_names using (activity_id)");
    X<-read.table(paste0("UCI HAR Dataset/",set,"/X_",set,".txt"), 
                  header=FALSE, col.names=features[,2], 
                  colClasses=c(rep("numeric",561)));
    # take only fields with "mean" or "std" in their names
    mean_std_X<-X[,which(grepl("mean|std",colnames(X)))];
    data<-cbind(subjects,y,mean_std_X);
    data;            
}