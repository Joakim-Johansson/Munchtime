class JsonRecipe {
  final String title;
  final String description;
  final List<List<Object>> ingredients;
  final List<String> instructions;

  JsonRecipe(this.title, this.description, this.ingredients, this.instructions);

  JsonRecipe.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        ingredients = json['ingredients'],
        instructions = json['instructions'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'ingredients': ingredients,
        'instructions': instructions,
      };
}
