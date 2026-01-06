import pandas as pd

df_cols = pd.read_csv('loan.csv', nrows=1, low_memory=False)
columnas = df_cols.columns.tolist()

sql_query = "CREATE TABLE loans (\n"
for col in columnas:
    sql_query += f'  "{col}" TEXT, \n'
sql_query = sql_query.rstrip(",\n") + "\n);"


print(sql_query)