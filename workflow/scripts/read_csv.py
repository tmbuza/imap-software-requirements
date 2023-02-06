
import csv
  
# with open('data/metadata/metadata.csv', 'r') as read_obj:
  
#     # Return a reader object which will
#     # iterate over lines in the given csvfile
#     csv_reader = csv.reader(read_obj)
  
#     # convert string to list
#     list_of_csv = list(csv_reader)
  
#     print(list_of_csv)

import pandas as pd

# df = pd.read_csv('data/metadata/metadata.csv')
# print(df.shape)

METADATA=pd.read_csv('config/SraRunTable.csv').loc[0:2]

ACCLIST=METADATA['Run'].tolist() # Specify the column containing the accession, in this demo is Run
print(ACCLIST)

# samples = (pd.read_csv("config/samples.tsv", sep="\t"))
# print(samples)

# units = (pd.read_csv("config/units.tsv", sep="\t"))
# print(units)