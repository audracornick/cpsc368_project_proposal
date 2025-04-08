CPSC 368 Group 3 Project: TITLE

By Audra Cornick, Abigail Grunenberg, Rishika Lyaga

1. Library Dependencies 
  - pandas
  - oracledb
  - matplotlib
  - seaborn
  - scikit-learn
  - statsmodels
  - numpy
  - scipy
  
2.Project Files
  - sql_statements.ipynb : Generates the SQL insert statements for our health expenditure data and our surgical wait time data.
  - surigcal_wait_time_insert.sql : The generated insert statements for the surgical wait time data set.
  - expenditure_insert.sql : The generated insert statements for our health expenditure data set. 
  - project_database.sql : The create table SQL statement for our HealthExpenditures table combined with its corresponding inserts, as well as the create table statment for our SurgicalWaitTimes table with its insert statements.
  - create_joint_table.sql : The create table as command used to create a joint table that combines attributes from HealthExpenditures tbale and SurgicalWaitTimes table using aggregation and grouping. This is used to perform analysis for research question 1 in the Question1-Analysis.ipynb file.
  - Question1-Analysis.ipynb : Contains all of the SQL statements, besides the create_joint_table.sql file, that is used to perform the regression analyses on our data for our first research question.
  - Question2-Analysis.ipynb : Contains all of the SQL statements used to perform the chi-squared analyses on our data and the visualization for our second research question.
  - Question3-Analysis.ipynb : Contains all of the SQL statements used to perform the regression analyses on our data for our third research question.
  - preprocessed_health_data.csv : Our health expenditure data after it has been cleaned.
  - preprocessed_surgical_wait_times.csv : Our surgical wait time data after it has been cleaned and procedures have been categorized.
  
3. Location of SQL Queries
  - Research Question 1:
    - The first major SQL command/query for this analysis is in the create_joint_table.sql file. 
    - Within the Question1-Analysis.ipynb file, SQL queries occur in cells 3, 10, 15, 22, and 26.
    
  - Research Question 2: Within the Question_2.ipynb file where the SQL query is written and executed in cell 4. 
    
  - Research Question 3: Within the Question3-Analysis.ipynb file, the SQL query occurs in cell 3.
    
  
