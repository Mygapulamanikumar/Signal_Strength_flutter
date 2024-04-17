import 'package:flutter/material.dart';
import 'UIScreen/contentDisplayUI.dart';
import 'UIScreen/graphUI.dart';
import 'UIScreen/logsContentUI.dart';
import 'UIScreen/mapUI.dart';
import 'BottomNavBar.dart';
import 'appbar.dart';

class MainCanvas extends StatefulWidget {
  const MainCanvas({super.key});

  @override
  State<MainCanvas> createState() => MainCanvasState();
}

class MainCanvasState extends State<MainCanvas> {
  int _selectedIndex = 0;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        _navigatorKey.currentState!.pushNamed('/live');
        break;
      case 1:
        _navigatorKey.currentState!.pushNamed('/logs');
        break;
      case 2:
        _navigatorKey.currentState!.pushNamed('/graph');
        break;
      case 3:
        _navigatorKey.currentState!.pushNamed('/map');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      backgroundColor: Colors.black45,
      body: Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          late Widget page;
          switch (_selectedIndex) {
            case 0:
              page = const contentDisplayUI();
            case 1:
              page = const logsContentUI();
            case 2:
              page = const graphUI();
              break;
            case 3:
              page = const mapUI();
          }

          return MaterialPageRoute(builder: (_) => page);
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        routeNames: const ['/live','/logs', '/graph', '/map'],
      ),
    );
  }
}
