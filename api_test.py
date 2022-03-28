import pandas
from pandas import ExcelWriter
from pandas import ExcelFile
import re



# response_API = requests.get('http://www7.slv.se/apilivsmedel/LivsmedelService.svc/Livsmedel/Klassificering/20170101')

# print(response_API.status_code)



document = pandas.read_excel("livsmedelsdatabas.xlsx",sheet_name='Ra_500food')

list = list()
list.append("List of foods")

for i in document.index:
    if(',' in document['Name'][i]):
        temp = re.search(r"^.*?(?=\,)", document['Name'][i])[0]
    else:
        temp = document['Name'][i]
    shouldAdd = True
    for element in list:
        if temp == element:
            shouldAdd = False
    if shouldAdd:
        list.append(temp)


def lookup(element, list):
    for e in list:
        if(e == element):
            print("Found " + element)
            return
    print("Couldn't found " + element)

lookup('Chicken',list)
lookup('Nocco',list)

print(list)

# string = "chicken, haha"
# out = re.search(r"^.*?(?=\,)", string)[0]

# print(out)

# regex = ','





