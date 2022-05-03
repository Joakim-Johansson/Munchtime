import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crunchtime/views/RecipeCard.dart';
import 'package:crunchtime/FirebaseMock.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  testWidgets('RecipeCard tests', (WidgetTester tester) async {
    setupFirebaseAuthMocks();
    await Firebase.initializeApp();
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

    final title = find.text("Carbonara");
    final desc = find.text("Nått");
    final ingredients = find.text("Bacon");
    final amount = find.text("Fat: 24");

    expect(title, findsOneWidget);
    expect(desc, findsNothing);
    expect(ingredients, findsNothing);
    expect(amount, findsNothing);

    final stack = find.byType(Stack);

    expect(stack, findsOneWidget);
  });
}
