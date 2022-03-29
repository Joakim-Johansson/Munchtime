class Ingredient:
    def __init__(self,name,co2,fat,protein,kcal,carbohydrates):
        self.name = name
        self.co2 = co2 
        self.fat = fat
        self.protein = protein
        self.carbohydrates = carbohydrates
        self.kcal = kcal
        
    def toFirebase(self):
        return {'name':self.name, 'co2':self.co2, 'fat':self.fat, 'protein':self.protein, 'kcal':self.kcal}