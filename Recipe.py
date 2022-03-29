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
            str += "|" + i[0].name + "," + i[0].co2 + "|"
        return str
    
    def toFirebase(self):
        return {'name' : self.name , 'ingredients' : self.toString(), 'total co2': self.getCo2()}

    