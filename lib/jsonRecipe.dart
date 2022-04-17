class JsonRecipe {
  final String name;
  final String user;
  // final String description;
  final List<String> ingredients;
  final List<int> amount;
  // final List<String> instructions;

  JsonRecipe(
    this.name,
    this.user /*this.description*/,
    this.ingredients,
    this.amount,
    /*this.instructions*/
  );

  JsonRecipe.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        user = json['user'],
        // description = json['description'],
        ingredients = json['ingredients'],
        amount = json['amount']
  // instructions = json['instructions']
  ;

  Map<String, dynamic> toJson() => {
        'name': name,
        'user': user,
        //  'description': description,
        'ingredients': ingredients,
        'amount': amount,
        // 'instructions': instructions,
      };
}
