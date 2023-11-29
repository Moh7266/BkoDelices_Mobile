import 'package:delice_bko/Pages/accueil.dart';
import 'package:delice_bko/Pages/commandes.dart';
import 'package:delice_bko/Pages/notification.dart';
import 'package:delice_bko/Pages/profile.dart';
import 'package:flutter/material.dart';

// / Flutter code sample for [BottomNavigationBar].

// void main() => runApp(const BottomNavigationBarExampleApp());


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() =>
      _BottomNavBarState();
}

class _BottomNavBarState
    extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    PageAccueil(),
    PageNotification(),
    PageCommandes(),
    PageProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 0.0,
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify_sharp),
            label: 'Commandes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
