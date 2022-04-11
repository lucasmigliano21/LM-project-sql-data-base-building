## SQL database cleaning and building project

### Python - pandas
In order to work on this project, the first action was to upload all the .csv files to a jupyter notebook (Project2-Cleaning.ipynb). Now, we were able to investigate and learn about each file, and clean the data with pandas regarding our needs. Also trying to identify the columns that would be used as PK and FK to join all the files in SQL.
The first glance of each file showed that the files were almost complete, only one column had to be deleted because it had null data. After learning about the content of each future SQL table, we applied some capitalize, lower, concat the actor's name + surname to work with only one column. Once every file was ready to be uploaded to an SQL db, we only had to export them. 

### MySQL
We uploaded all the files and worked on the connections between them. With 'Reverse Engineer', we could define each PK for each table and link them between the ones that could be joined (please check de 'ERD - project' image). We started with some basic queries, in order to fulfill the exercise. Moreover, some subqueries were used as well as CASE. The list of queries and explanations can be found in the file 'src.py.ipynb'. Also it is uploaded the SQL file 'project-cleaning.sql'.

### Bonus
Finally, we decided to create a new table that linked some tables just to show that we can :). And that the tables were linked correctly.
