import csv
import pandas as pd

def csv_to_sql(csv_filename, sql_filename, table_name):
    with open(csv_filename, newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        headers = next(reader)  # Extract column names
        
        with open(sql_filename, 'w', encoding='utf-8') as sqlfile:
            for row in reader:
                formatted_values = []
                
                for value in row:
                    # Convert empty values or 'NA' to NULL
                    if value.strip() == '' or value.strip().upper() == 'NA':
                        formatted_values.append('NULL')
                    # Check if value is numeric (integer or float) and avoid quotes
                    elif value.replace('.', '', 1).isdigit():
                        formatted_values.append(value)
                    else:
                        # Escape single quotes inside text values
                        escaped_value = value.replace("'", "''")
                        formatted_values.append(f"'{escaped_value}'")

                insert_statement = f"INSERT INTO {table_name} ({', '.join(headers)}) VALUES ({', '.join(formatted_values)});\n"
                sqlfile.write(insert_statement)


# Example of using the function with specific files
csv_to_sql('preprocessed_health_data.csv', 'health_expend_insert.sql', 'HealthExpenditures')
