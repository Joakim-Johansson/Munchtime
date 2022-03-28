import 'package:crunchtime/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xff009624),
          backgroundColor: const Color(0xff121212),
          bottomAppBarColor: const Color(0xff009624),
          focusColor: const Color(0xff003300),
        ),
        home: NavBar());
  }
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
      bottomNavigationBar: BottomNavigationBar(
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
              Icons.settings,
              color: _activeColor,
            ),
            label: "Settings",
            icon: Icon(
              Icons.settings,
              color: _color,
            ),
          ),
        ],
      ),
      body: Navigator(
        key: _pageNavigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
