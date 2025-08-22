# Data URL https://web.archive.org/web/20230908091635 /https://en.wikipedia.org/wiki/List_of_largest_banks
# CSV path: https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMSkillsNetwork-PY0221EN-Coursera/labs/v2/exchange_rate.csv

# Table attributes on extraction: Name, MC_USD_Billion
# Table attributes (final): Name, MC_USD_Billion, MC_GBP_Billion, MC_EUR_Billion, MC_INR_Billion
# output csv path ./Largest_banks_data.csv
# Banks.db
# Largest_banks
# cod_log.txt

# Import Libraries
import requests
from bs4 import BeautifulSoup
import sqlite3
import numpy as np
from datetime import datetime
import pandas as pd

# Initialize the known entities
url = 'https://web.archive.org/web/20230908091635%20/https://en.wikipedia.org/wiki/List_of_largest_banks'
db_name = 'Banks.db'
table_name = 'Largest_Banks'
output_path = './Largest_banks_data.csv'
csv_path = './exchange_rate.csv'
table_attribs = ["Name", "MC_USD_Billion"]

# Create a dunction to logs the messages 
def log_progress(message):
    ''' This function logs the mentioned message of a given stage of the
    code execution to a log file. Function returns nothing'''
    
    timestamp_format = '%Y-%h-%d-%H:%M:%S' # Year-Monthname-Day-Hour-Minute-Second 
    
    now = datetime.now() # get current timestamp 
    
    timestamp = now.strftime(timestamp_format) 
    
    with open("./code_log.txt","a") as f: 
        
        f.write(timestamp + ' : ' + message + '\n')

def extract(url, table_attribs):
    ''' This function aims to extract the required
    information from the website and save it to a data frame. The
    function returns the data frame for further processing. '''
    """
    Extracts information from the webpage at the given URL.
    
    Args:
        url (str): The URL of the webpage to scrape.
        table_attribs (list): List of column names for the DataFrame.
    
    Returns:
        pd.DataFrame: DataFrame containing the extracted data.
    """

     # Send a request to the webpage to check if the webpage is available for scraping
    response = requests.get(url)
    if response.status_code != 200:
        print("Failed to retrieve the page")
        return None
    
    # Start by parsing the HTML Content
    html_parser = BeautifulSoup(response.text, 'html.parser')

    # locate the table 
    tables = html_parser.find_all('table', {'class': 'wikitable'})

    # Get the data from the site
    if not tables or len(tables) < 2:  # Assuming the second table contains the relevant data
        print("No suitable table found")
        return None
    
    # Select the 2nd table to get the data from
    table  =  tables[1]
    rows = table.find_all('tr')

    # Create a table with the 2 starter columns 
    df = pd.DataFrame(columns = table_attribs)

    # Extract the data from the table
    for row in rows[1:]: # skip the header row
        cols = row.find_all('td')
        if len(cols) >=3: # ensure there are enough columns
            name = cols[1].text.strip() # get the bank name
            market_cap = cols[2].text.strip().replace(',', '').replace('-', '0') # get the market capitilization

            # Handle empty or invalid market values
            try:
                market_cap = float(market_cap) / 1000 # Convert to billions
                market_cap = round(market_cap, 2)
            except ValueError:
                market_cap = None
        
            # Append to the Dataframe
            data = {"Name": name, "MC_USD_Billion": market_cap}
            df = pd.concat([df, pd.DataFrame(data, index = [0])], ignore_index = True)

    return df


def transform(df, csv_path):
    ''' This function accesses the CSV file for exchange rate
    information, and adds three columns to the data frame, each
    containing the transformed version of Market Cap column to
    respective currencies'''

    # First of all get the exchange rates
    exchange_rates = pd.read_csv(csv_path)

    # Convert the rate column to a dictionary to get easier lookup
    rates_dict = dict(zip(exchange_rates['Currency'], exchange_rates['Rate']))

    # Check if the required currencies are available in the csv
    required_currencies = ['GBP', 'EUR', 'INR']
    for currency in required_currencies:
        if currency not in rates_dict:
            raise ValueError(f"Exchange rate for {currency} not found in the CSV.")  

    # Add the new columns based on exchange rate
    df['MC_GBP_Billion'] = df['MC_USD_Billion'] * rates_dict['GBP']
    df['MC_EUR_Billion'] = df['MC_USD_Billion'] * rates_dict['EUR']
    df['MC_INR_Billion'] = df['MC_USD_Billion'] * rates_dict['INR']
    
    # Round the new columns to 2 decimal places
    df = df.round({'MC_GBP_Billion': 2, 'MC_EUR_Billion': 2, 'MC_INR_Billion': 2})

    return df

# Create a function to save the data to a csv
def load_to_csv(df, output_path):
    ''' This function saves the final data frame as a CSV file in
    the provided path. Function returns nothing.'''

    df.to_csv(output_path)

def load_to_db(df, sql_connection, table_name):
    ''' This function saves the final data frame to a database
    table with the provided name. Function returns nothing.'''

    df.to_sql(table_name, sql_connection, if_exists='replace', index=False)

def run_query(query_statement, sql_connection):
    ''' This function runs the query on the database table and
    prints the output on the terminal. Function returns nothing. '''

    print(query_statement)
    query_output = pd.read_sql(query_statement, sql_connection)
    print(query_output)

# Test _1 

# Initiate the ETL Process
log_progress('Preliminaries complete. Initiating ETL process')

# Start the data extraction
df = extract(url, table_attribs)
print(df)

log_progress('Data extraction complete. Initiating Transformation process')

# Start the data transformation 
df = transform(df, csv_path)
log_progress('Data transformation complete. Initiating loading process')
print(df)

# load the data to csv
load_to_csv(df, output_path)
log_progress('Data saved to CSV file')

# Initiate the sql connection
sql_connection = sqlite3.connect('Banks.db')
log_progress('SQL Connection initiated.')

# load the data to database
load_to_db(df, sql_connection, table_name)
log_progress('Data loaded to Database as table. Running the query')

# Create the query statement
query_statement3 = f"SELECT Name, MC_USD_Billion from {table_name} ORDER BY MC_USD_Billion DESC LIMIT 10;"
query_statement2 = f"SELECT AVG(MC_GBP_Billion) FROM {table_name}"
query_statement1 = f"SELECT * FROM {table_name}"

# Run the query statement
run_query(query_statement1, sql_connection)
run_query(query_statement2, sql_connection)
run_query(query_statement3, sql_connection)
log_progress('Process Complete.')

# Close the sql connection
sql_connection.close()
log_progress('Server Connection closed')
