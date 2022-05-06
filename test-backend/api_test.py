import unittest
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from pyrsistent import inc
import requests

URL =  "https://cohesive-photon-346611.ew.r.appspot.com/"


class TestPost(unittest.TestCase):
    def test_post_success(self):
        body = {"name":"BaconAndEggs",
            "user":"Benjamin",
            "ingredients":["Bacon","Egg"],
            "amount":[100,100],
            "instruction":["Fry the bacon", "Fry the eggs", "Plate and enjoy"],
            "img":"bacon.jpg"
            }
        response = requests.post(URL + "recipes", json = body)
        self.assertTrue(response.status_code == 200)
        requests.delete(URL + "delete/BaconAndEggs/Benjamin")
    
    def test_post_fail(self):
        incompleteBody = {"name":"",
            "user":"",
            "amount":[],
            "instruction":[],
            "img":""
            }
        response = requests.post(URL + "recipes", json = incompleteBody)
        print(response.text)
        self.assertTrue(response.text == {"Error": "Missing argument"})
        
    