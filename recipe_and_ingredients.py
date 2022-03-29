## TODO ändra efter braformatfilen

import pandas
from pandas import ExcelWriter
from pandas import ExcelFile
import re
from Recipe import Recipe
from Ingredient import Ingredient

def getDataFromIngredient(ingredient):
    document = pandas.read_excel("braformatlivsmedelsdata.xlsx",sheet_name='Ra_500food')
    row = document.loc[ingredient == document['Namn']]
    name = "".join(filter(lambda x: not x.isdigit(), row['Namn'].to_string())).strip()
    co2 = re.sub(r"^[0-9]*\s*","",row['Total kg CO2-eq/kg'].to_string(),1)
    fat = re.sub(r"^[0-9]*\s*","",row['Fett (g/100 g)'].to_string(),1)
    protein = re.sub(r"^[0-9]*\s*","",row['Protein (g/100 g)'].to_string(),1)
    carbohydrates = re.sub(r"^[0-9]*\s*","",row['Kulhydrat (g/100 g)'].to_string(),1)
    kcal = re.sub(r"^[0-9]*\s*","",row['Energi (KJ/100 g)'].to_string(),1)

    obj = Ingredient(name,co2,fat,protein,kcal,carbohydrates)
    return obj

def createRecipe(name, *ingredients):
    ings = list()
    for ing in ingredients:
        ings.append((getDataFromIngredient(ing[0]), ing[1]))
    return Recipe(name,1,ings)


#x = createRecipe(('Granola bar',2) , ('Potato, raw',4), 
                #('Nutella, nut cream',100), ('Cold chocolate',1))
