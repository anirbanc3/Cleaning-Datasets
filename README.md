# Cleaning-Datasets
This is a part of the programming assignment of Coursera- Getting and Cleaning Data Week 4


The R script, run_analysis.R, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity labels and feature info
3. Loads both the training and test datasets along with subject ids
4. Merges the two datasets
5. Puts appropriate column labels
6. Subsets the dataset with mean and standard deviation values only
7. Merges activity labels with the actual dataset
8. Calculates average of all variables by activity and subject
9. Writes the final dataset into a .txt file
