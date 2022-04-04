import 'package:crunchtime/provider/google_sign_in.dart';
import 'package:crunchtime/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      // apiKey: "AAAAiEoizRw:APA91bEdylRZhbitZi2wHIPF4fQA5KUrl7i8Cnd34bkEZlm5G8WdHbbcKSNSxdHjJ6bFiloci8H1nphIR9mV_4fSTnyTDShlvayC4HpKS7sHCHsD0JOuybzi_e5Boc7KI7hm8pP_rjPn",
      apiKey: "AIzaSyDfZUtf8OSxoOytCivkWZycf5nBulEtREI",
      appId: "1:585359346972:android:31e610f23394e2922c3ed9",
      messagingSenderId: "585359346972",
      projectId: "Munchtime",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 82, 183, 136),
            backgroundColor: Color.fromARGB(255, 250, 255, 251),
            bottomAppBarColor: Color.fromARGB(255, 82, 183, 136),
            focusColor: Color.fromARGB(255, 27, 67, 50),
            fontFamily: 'OpenSans'),
        home: NavBar(),
        ),
  );
  }

class NavBar extends StatefulWidget {
  // May not need to be stateful at all
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final GlobalKey<NavigatorState> _pageNavigatorKey =
      GlobalKey<NavigatorState>();
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    Color _activeColor = Theme.of(context).focusColor;
    Color _color = Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          unselectedItemColor: _color,
          selectedItemColor: _activeColor,
          currentIndex: _currentindex,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          onTap: (index) {
            switch (index) {
              case 0:
                _pageNavigatorKey.currentState!.pushNamed("/home");
                break;
              case 1:
                _pageNavigatorKey.currentState!.pushNamed("/recipelist");
                break;
              case 2:
                _pageNavigatorKey.currentState!.pushNamed("/group");
                break;
            }
            setState(() {
              _currentindex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home,
                color: _activeColor,
              ),
              label: "Home",
              icon: Icon(
                Icons.home,
                color: _color,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.restaurant_menu,
                color: _activeColor,
              ),
              label: "Recipes",
              icon: Icon(Icons.restaurant_menu, color: _color),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.group,
                color: _activeColor,
              ),
              label: "Group",
              icon: Icon(
                Icons.group,
                color: _color,
              ),
            ),
          ],
        ),
      ),
      body: Navigator(
        key: _pageNavigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
