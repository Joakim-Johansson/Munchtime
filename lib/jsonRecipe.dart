class JsonRecipe {
  final String name;
  final String description;
  final List<String> ingredients;
  final List<int> amount;
  final List<String> instructions;

  JsonRecipe(this.name, this.description, this.ingredients, this.amount,
      this.instructions);

  JsonRecipe.fromJson(Map<String, dynamic> json)
      : name = json['title'],
        description = json['description'],
        ingredients = json['ingredients'],
        amount = json['amount'],
        instructions = json['instructions'];

  Map<String, dynamic> toJson() => {
        'title': name,
        'description': description,
        'ingredients': ingredients,
        'amount': amount,
        'instructions': instructions,
      };
}
