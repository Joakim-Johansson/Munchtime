
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

db.collection('test').add({'name':'Misha'})


document = pandas.read_excel("braformatlivsmedelsdata.xlsx",sheet_name='Ra_500food')


