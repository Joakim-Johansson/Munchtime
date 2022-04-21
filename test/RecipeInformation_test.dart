import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crunchtime/widgets/RecipeInformation.dart';

void main() {
  testWidgets('Test of RecipeInformation Widget', (WidgetTester tester) async {
    final list = ["(Test, 130g)", "(Amazing, 40g)", "Nice 30"];
    List<String> createdList = RecipeInformation.translateIngredients(list);

    expect(createdList[0], "Test, 130g");
    expect(createdList[1], "Amazing, 40g");
    expect(createdList[2], "ice 3");
  });
}
