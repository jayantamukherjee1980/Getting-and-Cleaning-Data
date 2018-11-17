Steps are as follows:
1. Using download.file() the zip file is getting downloaded into the working directory
2. Using unzip() extracting the files into the folder "Data"
3. Reading X,Y,subject, feature and activitylabel files into in memory tables using read.table()
4. Using colnames(..) = .., labeling the columns
5. Column wise merging Y, Subect and X tables
6. Row wise merging the column wise merged tables for training and testing records
7. Using grepl(), filtering the columns names having "mean" or "std". Also keeping the activityId and subjectId columns to identify the records
8. Merging activity labels red in the step 3 to the mean/std records got in step 7.
9. Creating a new table with subjectId and activityId wise average values
10. Using write.table saving the new dataset
