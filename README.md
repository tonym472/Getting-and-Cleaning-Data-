Information On Creating The Tidy Dataset 

 

1. The Test and Train data were downloaded to the local machine 
a. All data was then saved to the R working directory. 


2. The three test files were next read into R. 
a. Column names were added to the Subject and Task datasets 
b. The test data was then combined into one dataset using the cbind 
function. 


3. The three train files were next read into R. 
a. Column names were added to the Subject and Task datasets 
b. The train data was then combined into one dataset using the cbind 
function. 


4. The test and train datasets were then combined using the rbind function 
a. Descriptive names were then added to the task variable 


5. Next the combined dataset was subset to keep only the fields needed for the 
Tidy dataset. 
a. Only the analysis fields ending in mean() or std() were retained 
b. Descriptive names were given to the analysis fields 


6. The combined data was then reshaped using the melt function 
a. Id.vars are Subject and Activity 


7. The ddply function was used to summarize the analysis variables 
8. The write.table function was used to output the Tidy dataset to the working 
directory. 



