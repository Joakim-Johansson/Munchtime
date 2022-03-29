import firebase_admin
import api_test
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

x = api_test.createRecipe("test", ('Granola bar',2) , ('Potato, raw',4), 
                ('Nutella, nut cream',100), ('Cold chocolate',1))

db.collection('Recipes').add(x.toFirebase())


