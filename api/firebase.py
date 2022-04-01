import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from Recipe import Recipe
from flask import Flask
from flask_restful import Resource, Api, reqparse
import json

app = Flask(__name__)
api = Api(app)

#ALL returns ALL RECIPES
# ? == space in curl request

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

x = Recipe("Granola", ('Granola bar',50) , ('Potato, raw',60), 
                ('Nutella, nut cream',10), ('Cold chocolate',30))

carbonara = Recipe("Carbonara", ('Bacon',160), ('Pasta, raw',400), ('Egg',180),('Parmesan',85))
baconAndEgg = Recipe("Bacon and Eggs", ('Bacon',160),('Egg',180))
nutCream = Recipe("Nut cream",('Nutella, nut cream',100))

def addData(recipe:Recipe):
    ref = db.collection(u"Recipes").document(recipe.name)
    if(ref.get().exists):
        print("Recipe couldn't be added, choose another name!")
        return
    ref.set({'ingredients' : ["(" + str(i[1]) + "g" + ", " + i[0].name + ")" for i in recipe.ingredients]})
    ref.update({db.field_path('Total CO2-eq') : "{:.2f}".format(recipe.getTotalCo2())})
    ref.update({db.field_path('nutrition') : ["Fat: " + str(recipe.getTotalFat()), 
                                              "Carbs: " + str(recipe.getTotalCarbs()),                                             
                                              "Protein: " + str(recipe.getTotalProtein()),
                                              "Kcal: " + str(recipe.getTotalKcal())]})
    ref.update({db.field_path('name') : recipe.name})

def getRecipes(name): 
    result = db.collection('Recipes').document(name).get()
    if result.exists:
        return (result.to_dict())
    return None

def getCollection():
    docs = db.collection('Recipes').get()
    a = list()
    for i in docs:
        a.append(i.to_dict())
    return a

def recipeContains(string):
    reference = db.collection('Recipes').get()
    recipes = list()
    for j in reference:
        if j.to_dict()['name'] == string:
            recipes.append(j.to_dict()['name'])
    if recipes == []:
        for i in reference:
            temp = i.to_dict()
            l = list(temp['ingredients'])
            for x in l:
                if(string in x):
                    recipes.append(temp['name'])
    return recipes
    
    
def deleteRecipes(name):
    db.collection('Recipes').document(name).delete()
            
class RecipeGet(Resource):
    def get(self,name):
        if(name == 'all'):
            hej = getCollection()
            return {'data': hej},200
        
        recipes = getRecipes(name)
        if(recipes != None):
            return recipes,200
        result = recipeContains(name)
        if result != []:
            return result,200
        return "bajs"

class RecipePost(Resource):
    def post(self,name,ingredients):
        pass
    

class userSaved(Resource):
    pass

api.add_resource(RecipeGet,'/recipes/<string:name>')
api.add_resource(RecipePost,'/recipes/<string:name>/<string:ingredients>')
#print(getRecipes('test1'))

if __name__ == "__main__":
    app.run(debug=True)

# print(getCollection())

# print(recipeContains('Bacon'))



