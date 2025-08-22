import sqlite3
import pandas as pd

conn = sqlite3.connect("STAFF.db")

# Create the table and initialize the attribute list
table_name = 'INSTRUCTOR'
attribute_list = ['ID', 'FNAME', 'LNAME', 'CITY', 'CCODE']

# Create a table colled departments
table_name_d = "DEPARTMENTS"
attribute_list_2 =["DEPT_ID","DEP_NAME","MANAGER_ID","LOC_ID"] 

# Read the CSV for departments
file_path2 = '/home/project/dbase/Departments.csv'
df2 = pd.read_csv(file_path2, names = attribute_list_2)

# Read the CSV files
# Get the attributes list
file_path = '/home/project/dbase/INSTRUCTOR.csv'
df = pd.read_csv(file_path, names = attribute_list)

# Create the database
df.to_sql(table_name, conn, if_exists = 'replace', index =False)
print('Table Instructor is ready')

# Create Second Database
df2.to_sql(table_name_d, conn, if_exists = 'replace', index =False)
print('Table Departmnets is ready')

# View the data in the table
query_statement = f"SELECT * FROM {table_name}"
query_output = pd.read_sql(query_statement, conn)
print(query_statement)
print(query_output)

# View the FNAME column data
query_statement = f"SELECT FNAME FROM {table_name}"
query_output = pd.read_sql(query_statement, conn)
print(query_statement)
print(query_output)

# View the total number of entries in the table
query_statement = f"SELECT COUNT(*) FROM {table_name}"
query_output = pd.read_sql(query_statement, conn)
print(query_statement)
print(query_output)

# View the data from departments
query_statement = f"SELECT * FROM {table_name_d}"
query_output = pd.read_sql(query_statement, conn)
print(query_statement)
print(query_output)

# View the Dept_ID from departments
query_statement = f"SELECT DEPT_ID FROM {table_name_d}"
query_output = pd.read_sql(query_statement, conn)
print(query_statement)
print(query_output)

# View the Dep_Name
query_statement = f"SELECT DEP_NAME FROM {table_name_d}"
query_output = pd.read_sql(query_statement, conn)
print(query_statement)
print(query_output)

# View the Manager ID
query_statement = f"SELECT MANAGER_ID FROM {table_name_d}"
query_output = pd.read_sql(query_statement, conn)
print(query_statement)
print(query_output)

# View the LOC_ID 
query_statement = f"SELECT LOC_ID FROM {table_name_d}"
query_output = pd.read_sql(query_statement, conn)
print(query_statement)
print(query_output)

# View the total number of entries in the table
query_statement = f"SELECT COUNT(*) FROM {table_name_d}"
query_output = pd.read_sql(query_statement, conn)
print(query_statement)
print(query_output)

# append data in the dataframe of Departments
data_dict_2 = {'DEPT_ID' : [9],
            'DEP_NAME' : ['Quality Assurance'],
            'MANAGER_ID' : [30010],
            'LOC_ID' : ['L0010']}
data_append_2 = pd.DataFrame(data_dict_2)

# Append data in the dataframe
data_dict = {'ID' : [100],
            'FNAME' : ['John'],
            'LNAME' : ['Doe'],
            'CITY' : ['Paris'],
            'CCODE' : ['FR']}
data_append = pd.DataFrame(data_dict)

# Check if the data is appended successfully
data_append.to_sql(table_name, conn, if_exists = 'append', index =False)
print('Data appended for first database successfully')

# Check if the data is appended to the second dataabase
data_append_2.to_sql(table_name_d, conn, if_exists = 'append', index =False)
print('Data appended for second database successfully')

# Close the connection to the database
conn.close()

