import pandas
import recipe_and_ingredients
from pandas import ExcelWriter
from pandas import ExcelFile

document = pandas.read_excel("braformatlivsmedelsdata.xlsx",sheet_name='Ra_500food')

x = recipe_and_ingredients.createRecipe("test", ('Aubergine',50) , ('Potato, raw',60), 
                ('Cucumber',10), ('Biscuit',30))

y = recipe_and_ingredients.createRecipe("test2",('Pumpkin, raw',2) , ('Potato, raw',4), 
                ('Nutella, nut cream',1000), ('Cold chocolate',1))

z = recipe_and_ingredients.createRecipe("test2", ('Cold chocolate', 50), ('Cold chocolate', 50))

def getTotalFat(recipe):
    total = 0
    tmp = 0
    for i in recipe.ingredients:
        tmp = (float(i[0].fat) / 100) * float(i[1])
        total = total + tmp
        tmp = 0
    return total

def getTotalProtein(recipe):
    total = 0
    tmp = 0
    for i in recipe.ingredients:
        tmp = (float(i[0].protein) / 100) * float(i[1])
        total = total + tmp
        tmp = 0
    return total

def getTotalCarbs(recipe):
    total = 0
    tmp = 0
    for i in recipe.ingredients:
        tmp = (float(i[0].carbohydrates) / 100) * float(i[1])
        total = total + tmp
        tmp = 0
    return total

def getTotalKcal(recipe):
    total = 0
    tmp = 0
    for i in recipe.ingredients:
        tmp = (float(i[0].kcal) / 100) * float(i[1])
        total = total + tmp
        tmp = 0
    return total * 0.2390057361

print(getTotalProtein(z))