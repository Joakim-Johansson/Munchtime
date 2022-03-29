import pandas
from pandas import ExcelWriter
from pandas import ExcelFile
import re

class Recipe:
    def __init__(self, name, id, ingredients):
        self.id = id
        self.ingredients = ingredients
        self.name = name

    def getCo2(self):
        sum = 0
        for element in self.ingredients:
            sum = sum + float(element[0].co2)
        return sum
        
    def toString(self):
        str = ""
        for i in self.ingredients:
            str += "|" + i[0].name + "," + i[0].co2 + "|"
        return str
    
    def toFirebase(self):
        return {'name' : self.name , 'ingredients' : self.toString(), 'total co2': self.getCo2()}
    
class Ingredient:
    def __init__(self,name,co2):
        self.name = name
        self.co2 = co2 

    def toFirebase(self):
        return {'name':self.name, 'co2':self.co2}
        

def getDataFromIngredient(ingredient):
    document = pandas.read_excel("food.xlsx",sheet_name='Ra_500food')
    row = document.loc[ingredient == document['Name']]


    name = "".join(filter(lambda x: not x.isdigit(), row['Name'].to_string())).strip()
    co2 = re.sub(r".[0-9]","",row['CO2-eq/kg'].to_string(),1).replace(" ","")

    obj = Ingredient(name,co2)
    return obj



def createRecipe(name, *ingredients):
    ings = list()
    for ing in ingredients:
        ings.append((getDataFromIngredient(ing[0]), ing[1]))
    return Recipe(name,1,ings)


x = createRecipe(('Granola bar',2) , ('Potato, raw',4), 
                ('Nutella, nut cream',100), ('Cold chocolate',1))

print(x.toString())
print(x.toFirebase())

# list = list()
# list.append("List of foods")

# for i in document.index:
#     if(',' in document['Name'][i]):
#         temp = re.search(r"^.*?(?=\,)", document['Name'][i])[0]
#     else:
#         temp = document['Name'][i]
#     shouldAdd = True
#     for element in list:
#         if temp == element:
#             shouldAdd = False
#     if shouldAdd:
#         list.append(temp)


# def lookup(element, list):
#     for e in list:
#         if(e == element):
#             print("Found " + element)
#             return
#     print("Couldn't found " + element)

# lookup('Chicken',list)
# lookup('Nocco',list)

# print(list)

# string = "chicken, haha"
# out = re.search(r"^.*?(?=\,)", string)[0]

# print(out)

# regex = ','