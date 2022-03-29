import firebase_admin
import api_test
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

x = api_test.createRecipe("test", ('Granola bar',50) , ('Potato, raw',60), 
                ('Nutella, nut cream',10), ('Cold chocolate',30))



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

def addData(recipe):
    ref = db.collection(u"Recipes").document(recipe.name)
    if(ref.get().exists):
        print("Recipe couldn't be added, choose another name!")
        return
    ref.set({'ingredients' : ["(" + str(i[1]) + "g" + ", " + i[0].name + ")" for i in x.ingredients]})
    ref.update({db.field_path('CO2-eq/kg') : [i[0].co2 for i in x.ingredients]})
    ref.update({db.field_path('Total CO2-eq') : "{:.2f}".format(getTotalco2(recipe))})

addData(x)

