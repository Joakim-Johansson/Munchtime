import 'package:crunchtime/FirebaseMock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crunchtime/views/RecipeList.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('RecipeList works', (WidgetTester tester) async {
    setupFirebaseAuthMocks();
    await Firebase.initializeApp();

    await tester.pumpWidget(RecipeList());

    final titleFinder = find.text("Recipes");

    expect(titleFinder, findsOneWidget);
  });
}
