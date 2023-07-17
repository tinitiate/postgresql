import csv
import subprocess

def convert_oracle_to_postgresql(sql_statement):
    # Construct the ora2pg command with necessary options
    command = ['ora2pg', '-t', 'SQL', '-c', 'oracle_db_connection_string', '-o', 'postgresql_output.sql']
    
    # Pass the SQL statement as input to ora2pg
    process = subprocess.Popen(command, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
    stdout, stderr = process.communicate(input=sql_statement)
    
    # Check for any errors
    if process.returncode != 0:
        print(f"Error occurred while converting Oracle SQL to PostgreSQL SQL:\n{stderr}")
    else:
        print("Conversion successful.")
    
    # Return the converted PostgreSQL SQL
    with open('postgresql_output.sql', 'r') as file:
        return file.read()

# Usage example
oracle_sql = "SELECT * FROM my_table"
postgresql_sql = convert_oracle_to_postgresql(oracle_sql)
print("PostgreSQL SQL:")
print(postgresql_sql)
    

def read_csv(filename):
    with open(filename, 'r', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            id_value = row['id']
            notes = row['notes']
            sql_statement = row['sql_statement']
            
            # Process the data and generate new values
            new_sql = f"NEW SQL for ID {id_value}"
            status = "Processed"
            
            # Update the row with new values
            row['new_sql'] = new_sql
            row['status'] = status
            
            # Print the updated row
            print(row)
            
            # Write the updated row to a new CSV file
            write_csv('updated_data.csv', reader.fieldnames, row)
            
def write_csv(filename, fieldnames, row):
    with open(filename, 'a', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        
        # Write the header if the file is empty
        if csvfile.tell() == 0:
            writer.writeheader()
        
        # Write the updated row
        writer.writerow(row)
        
# Usage example
filename = 'data.csv'
read_csv(filename)
