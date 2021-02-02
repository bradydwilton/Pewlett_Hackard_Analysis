# %%
import csv
import pandas as pd
# %%
titles_df = pd.read_csv('./titles.csv')
# %%
titles_df.isnull().sum()
# %%
salaries = pd.read_csv('./salaries.csv')
salaries.isnull().sum()
# %%
salaries.dtypes
# %%
titles_df.dtypes
# %%
employees = pd.read_csv('./employees.csv')
employees.dtypes
# %%
departments = pd.read_csv('./departments.csv')
departments.dtypes
# %%
len(employees)
# %%
len(titles_df)
# %%
dept_emp = pd.read_csv('./dept_emp.csv')
len(dept_emp)
# %%
len(salaries)
# %%
# %%
reader = csv.reader('./titles.csv')
# %%
