import requests
from bs4 import BeautifulSoup
import sqlite3
import numpy as np
from datetime import datetime
import pandas as pd


# Initialize the known entities
url = 'https://web.archive.org/web/20230902185326/https://en.wikipedia.org/wiki/List_of_countries_by_GDP_%28nominal%29'
db_name = 'World_Economies.db'
table_name = 'Countries_by_GDP'
csv_path = './Countries_by_GDP.csv'
table_attribs = ["Country", "GDP_USD_millions"]

# Extra
conn = sqlite3.connect(db_name)

def extract(url, table_attribs):
    ''' This function extracts the required
    information from the website and saves it to a dataframe. The
    function returns the dataframe for further processing. '''

    # Load the webpage for Webscraping
    html_page = requests.get(url).text
    data = BeautifulSoup(html_page, 'html.parser')
    df = pd.DataFrame(columns=table_attribs)


    # Check the connection of the site
    # Send request to get the webpage content
    response = requests.get(url)
    if response.status_code != 200:
        print("Failed to retrieve the page")
        return None
    
    # Get the data and find the table
    table = data.find_all('tbody')
    rows = table[2].find_all('tr')

    ## take the data and append it into a dataframe
    for row in rows:
        col = row.find_all('td')
        if len(col) != 0:
            if col[0].find('a') is not None and '—' not in col[2]:
                country_name = col[0].a.contents[0]
                gdp_value = col[2].contents[0].replace(',', '')  # Remove commas in GDP value
                if gdp_value:  # Ensure GDP value exists
                    data_dict = {"Country": country_name, "GDP_USD_millions": gdp_value}
                    df1 = pd.DataFrame(data_dict, index=[0])
                    df = pd.concat([df, df1], ignore_index=True)    
    return df

def transform(df):
    ''' This function converts the GDP information from Currency
    format to float value, transforms the information of GDP from
    USD (Millions) to USD (Billions) rounding to 2 decimal places.
    The function returns the transformed dataframe.'''

    GDP_list = df["GDP_USD_millions"].tolist()

    GDP_list = [float("".join(x.split(','))) for x in GDP_list]

    GDP_list = [np.round(x/1000,2) for x in GDP_list]

    df["GDP_USD_millions"] = GDP_list
    
    df=df.rename(columns = {"GDP_USD_millions":"GDP_USD_billions"}) 

    return df

def load_to_csv(df, csv_path):
    ''' This function saves the final dataframe as a `CSV` file 
    in the provided path. Function returns nothing.'''

    df.to_csv(csv_path)

def load_to_db(df, sql_connection, table_name):
    ''' This function saves the final dataframe as a database table
    with the provided name. Function returns nothing.'''

    df.to_sql(table_name, sql_connection, if_exists='replace', index=False)

def run_query(query_statement, sql_connection):
    ''' This function runs the stated query on the database table and
    prints the output on the terminal. Function returns nothing. '''
    
    print(query_statement)
    query_output = pd.read_sql(query_statement, sql_connection)
    print(query_output)

def log_progress(message): 
    timestamp_format = '%Y-%h-%d-%H:%M:%S' # Year-Monthname-Day-Hour-Minute-Second 
    now = datetime.now() # get current timestamp 
    timestamp = now.strftime(timestamp_format) 
    with open("./etl_project_log.txt","a") as f: 
        f.write(timestamp + ' : ' + message + '\n')

# Input necesaary for output

# Initiate the ETL Process
log_progress('Preliminaries complete. Initiating ETL process')

# Start the data extraction
df = extract(url, table_attribs)
log_progress('Data extraction complete. Initiating Transformation process')

# Start the data transformation 
df = transform(df)
log_progress('Data transformation complete. Initiating loading process')

# load the data to csv
load_to_csv(df, csv_path)
log_progress('Data saved to CSV file')

# Initiate the sql connection
sql_connection = sqlite3.connect('World_Economies.db')
log_progress('SQL Connection initiated.')

# load the data to database
load_to_db(df, sql_connection, table_name)
log_progress('Data loaded to Database as table. Running the query')

# Create the query statement
query_statement = f"SELECT * from {table_name} WHERE GDP_USD_billions >= 100"

# Run the query statement
run_query(query_statement, sql_connection)
log_progress('Process Complete.')

# Close the sql connection
sql_connection.close()