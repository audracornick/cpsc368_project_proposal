
def combine_sql_files(create_table_file, health_expend_insert_file, output_file):
    # Open and read each of the SQL files
    with open(create_table_file, 'r', encoding='utf-8') as create_file:
        create_table_content = create_file.read()
    
    with open(health_expend_insert_file, 'r', encoding='utf-8') as health_file:
        health_expend_insert_content = health_file.read()

    # Combine all the SQL contents into one file
    with open(output_file, 'w', encoding='utf-8') as output:
        # Write the create table statement first
        output.write("-- Health Expenditures\n")
        output.write(create_table_content)
        output.write("\n\n")
        
        # Write the health expenditure insert statements
        output.write("-- Surgical Wait Times\n")
        output.write(health_expend_insert_content)
        output.write("\n\n")

# Example usage:
combine_sql_files('health_expend_insert.sql', 'wait_time_insert.sql', 'project_database.sql')