import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crunchtime/views/RecipeCard.dart';

void main() {
  testWidgets('RecipeCard tests', (WidgetTester tester) async {
    Map<String, dynamic> test = {
      "name": "Carbonara",
      "description": "Nått",
      "ingredients": ["Bacon", "Pasta"],
      "amount": [150, 100],
      "nutrition": ["Fat: 24", "Carbs: 4", "Protein: 24", "Kcal: 5"],
      "user": "Yes",
      "img": "baconegg.jpeg",
      "Total CO2-eq": "0.34"
    };

    await tester.pumpWidget(RecipeCard(test));
  });
}
