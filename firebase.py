import firebase_admin
import recipe_and_ingredients
from firebase_admin import credentials
from firebase_admin import firestore
import nutrient_func as nt

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

x = recipe_and_ingredients.createRecipe("TESTing", ('Granola bar',150) , ('Potato, raw',60), 
                ('Nutella, nut cream',110), ('Cold chocolate',30))

#db.collection('Recipes').add({'ingredients' : ["(" + str(i[1]) + "g" + ", " + i[0].name + ")" for i in x.ingredients]})
#db.collection('Recipes').document('sBTC2DQb8IEK7ZiHPxgr').add({'co2' : [i.co2 for i in x.ingredients]})
def getTotalco2(recipe):
    total = 0
    tmp = 0
    for i in recipe.ingredients:
        tmp = (float(i[0].co2) / 1000) * float(i[1])
        total = total + tmp
        tmp = 0
    return total

#TODO: ordentliga värden
def climate_grade(recipe):
    co2 = getTotalco2(recipe)
    tmp = ""
    if (co2 < 0.5):
        tmp = "5"
    elif (co2 < 1.5):
        tmp = "4"
    elif (co2 < 2.5):
        tmp = "3"
    elif (co2 < 3.5):
        tmp = "2"
    else:
        tmp = "1"
    return tmp + "/5"


def addData(recipe):
    ref = db.collection(u"Recipes").document(recipe.name)
    if(ref.get().exists):
        print("Recipe couldn't be added, choose another name!")
        return
    ref.set({'ingredients' : ["(" + str(i[1]) + "g" + ", " + i[0].name + ")" for i in x.ingredients]})
    ref.update({db.field_path('Climate grade') : (climate_grade(recipe))})
    ref.update({db.field_path('nutrition') : ["Fat: " + str(nt.getTotalFat(recipe)//1), 
                                              "Carbs: " + str(nt.getTotalCarbs(recipe)//1),                                             
                                              "Protein: " + str(nt.getTotalProtein(recipe)//1),
                                              "Kcal: " + str(nt.getTotalKcal(recipe)//1)]})

def getRecipes(): 
    result = db.collection('Recipes').document('TESTing').get()
    if result.exists:
        print(result.to_dict())

def getCollection():
    docs = db.collection('Recipes').get()
    for i in docs:
        print(i.to_dict())

#getRecipes()
#getCollection()

addData(x)

