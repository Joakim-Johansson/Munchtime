import pandas
from pandas import ExcelWriter
from pandas import ExcelFile
import re
import json

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
            str += "(" + i[0].name + "," + i[0].co2 + ")" + "\n"
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



document = pandas.read_excel("food.xlsx",sheet_name='Ra_500food')

co2 = []

#for i in range(500):
    #co2.append(float(document['CO2-eq/kg'][i]))


# m = sum(co2) / len(co2)

# print(min(co2))
# print(m)
# print(max(co2))