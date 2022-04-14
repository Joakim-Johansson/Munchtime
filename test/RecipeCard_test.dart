import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crunchtime/views/RecipeCard.dart';

void main(){
  testWidgets('RecipeCard tests', (WidgetTester tester) async{
    QueryDocumentSnapshot test = QueryDocumentSnapshot();

    await tester.pumpWidget(RecipeCard());
  })
}