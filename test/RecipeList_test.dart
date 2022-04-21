import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crunchtime/views/RecipeList.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('RecipeList works', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDfZUtf8OSxoOytCivkWZycf5nBulEtREI",
        appId: "1:585359346972:android:31e610f23394e2922c3ed9",
        messagingSenderId: "585359346972",
        projectId: "Munchtime",
      ),
    );

    await tester.pumpWidget(RecipeList());

    final titleFinder = find.text("Recipes");

    expect(titleFinder, findsOneWidget);
  });
}
