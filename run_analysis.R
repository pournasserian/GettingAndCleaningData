
root_path <- getwd()

x_column_count <- 561 # as it is mentioned in features.txt

get_filename <- function(filetype){
    
    if (filetype == 0 ){
        ## feature list file name
        file_path <- "features.txt"
    } 
    
    if (filetype == 1 ){
        ## test subject file
        file_path <- "test/subject_test.txt"    
    }    
    
    if (filetype == 2 ){
        ## train subject file
        file_path <- "train/subject_train.txt"    
    }
    
    if (filetype == 3 ){
        ## x test data
        file_path <- "test/X_test.txt"    
    }
    
    if (filetype == 4 ){
        ## y test data
        file_path <- "test/Y_test.txt"    
    }
    
    if (filetype == 5 ){
        ## x train data
        file_path <- "train/X_train.txt"    
    }
    
    if (filetype == 6 ){
        ## y train data
        file_path <- "train/Y_train.txt"    
    }
    
    if (filetype == 7 ){
        ## labels definition
        file_path <- "activity_labels.txt"    
    }
    
    full_name <- paste(root_path, "/", file_path, sep = "")
    
    return(full_name)
    
}

get_features <- function(){
    
    ## read the feature list file
    features <- read.csv(get_filename(0), header = FALSE, sep = " ")
    
    ## set column names
    colnames(features) <- c("feature_id", "feature_name")
    
    features
}

get_subjects <- function(isTest){
    
    subject_file <- ""
    
    if (isTest == TRUE)
    {
        ## test subjects
        subject_file <- get_filename(1)
        
    }
    else
    {
        ## train subjects
        subject_file <- get_filename(2)
    }
      
    subjects <- read.csv(subject_file, header = FALSE)
    return(subjects)
}

get_activities <- function(){
    
    ## read the labels list file
    activities <- read.csv(get_filename(7), header = FALSE, sep = " ")
    
    ## set column names
    colnames(activities) <- c("ActivityId", "ActivityName")
    
    activities
}

get_feature_data_X <- function(isTest){
    
    feature_data_file_X <- ""
    
    if (isTest == T){
        feature_data_file_X <- get_filename(3)
    }
    else{
        feature_data_file_X <- get_filename(5)
    }
    
    row_format <- NULL
    for(i in 1:x_column_count){
        row_format <- append(row_format, c(-1,15))
    }
    feature_data_X <- scan(file = feature_data_file_X, sep = " ", strip.white = F, what = "numeric" )
    feature_data_X <- as.numeric(feature_data_X)
    feature_data_X <- feature_data_X[!is.na(feature_data_X)]
    feature_data_X <- matrix(ncol = x_column_count, data = feature_data_X, byrow = T)
    feature_data_X <- as.data.frame(feature_data_X)
    names <- get_features()
    names <- names[, 2]
    names <- as.character(names)
    
    colnames(feature_data_X) <- names
    
    return(feature_data_X)
    
}

get_feature_data_Y <- function(isTest){
    
    feature_data_file_Y <- ""
    
    if (isTest == T){
        feature_data_file_Y <- get_filename(4)
    }
    else{
        feature_data_file_Y <- get_filename(6)
    }
    
    feature_data_Y <- read.csv(feature_data_file_Y, header = F)
    
    feature_data_Y
}

main <- function(){
        
    test_data_X <- get_feature_data_X(T)
    test_data_Y <- get_feature_data_Y(T)
    test_subjects <- get_subjects(T)
    test_data <- cbind(test_subjects, test_data_Y, test_data_X)
    
    train_data_X <- get_feature_data_X(F)
    train_data_Y <- get_feature_data_Y(F)
    train_subjects <- get_subjects(F)
    train_data <- cbind(train_subjects, train_data_Y, train_data_X)
    
    result <- rbind(test_data, train_data)
    colnames(result)[1] <- "Subject"
    colnames(result)[2] <- "ActivityId" 
    
    activities <- get_activities()
    result <- merge(activities, result)
    result$ActivityId <- NULL
    
    result <- aggregate(result[, 3:x_column_count+2],by=list(result$Subject, result$ActivityName), FUN=mean)
    
    colnames(result)[1] <- "Subject"
    colnames(result)[2] <- "ActivityName"
    
    ## extract only columns which names containing mean and std
    valid_column_names <- get_features()
    valid_column_indexes <- grep("mean[(]|std[(]", tolower(valid_column_names[,2]))
    valid_column_names <- as.vector(valid_column_names[valid_column_indexes, 2])
    valid_column_names <- append(valid_column_names, c("Subject", "ActivityName"))
    
    result <- result[, names(result) %in% valid_column_names]
    
    write.table(result, file = "result.txt", row.name = F)
    
}