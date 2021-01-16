---
##CodeBook
###1/16/2021
###Getting and Cleaning Data Course Project
---

##### 
The data in this table comes from experiments carried out from 30 participants performing various activities while wearing a smartphone on their waist. The smartphone had an accelerometer and gyroscope that recorded motion of the users.

### Subject
30 subjects with the number 1-30 identifying each subject.

### Activity
Six activities (standing, walking upstairs, walking downstairs, sitting, standing, and laying) were recorded with the smartphones.

### Features
Mean and standard deviations were calculated for each of the features recorded from the smartphones. The features collected included:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

where t signifies time and f signifies frequency.

The final tidy data set contains the means of these measurements for each participant and activity.