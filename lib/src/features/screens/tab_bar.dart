import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/src/features/screens/home_Screen.dart';
import 'package:weather_app/src/features/screens/search_city_weather_screen.dart';

class TabNavigationBar extends StatefulWidget {
  const TabNavigationBar({super.key});
  static const routeName = 'tab-bar';

  @override
  State<TabNavigationBar> createState() => _TabNavigationBarState();
}

class _TabNavigationBarState extends State<TabNavigationBar> {
  int pageIndex = 0;

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [
    HomeScreen(),
    SearchCityWeather(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  dialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Do you want to Exit ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        final value = await showDialog(
            context: (context),
            builder: (context) => AlertDialog(
                  title: const Text('Do you want to exit ?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Yes'),
                    ),
                  ],
                ));

        if (value != null) {
          return Future.value(value).then((_) {
            SystemNavigator.pop();
            return value;
          });
        } else {
          return false;
        }
      }),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(size: 20),
          unselectedIconTheme: IconThemeData(size: 20),
          backgroundColor: const Color.fromRGBO(0, 36, 59, 1),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: const Color.fromRGBO(0, 36, 59, 1),
              icon: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.white : Colors.grey),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor: const Color.fromRGBO(0, 36, 59, 1),
              icon: Icon(Icons.search, color: _selectedIndex == 1 ? Colors.white : Colors.grey),
              label: "",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          showSelectedLabels: true,
        ),
      ),
    );
  }
}
