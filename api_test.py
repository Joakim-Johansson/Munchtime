import pandas
from pandas import ExcelWriter
from pandas import ExcelFile


# response_API = requests.get('http://www7.slv.se/apilivsmedel/LivsmedelService.svc/Livsmedel/Klassificering/20170101')

# print(response_API.status_code)



document = pandas.read_excel("livsmedelsdatabas.xlsx",sheet_name='Ra_500food')

for i in document.index:
    print(document['Name'][i])

string = "chicken, haha"

print(string[0:','])

regex = ','





