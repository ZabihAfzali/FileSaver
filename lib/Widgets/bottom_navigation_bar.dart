import 'package:flutter/material.dart';



class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Albums',
      style: optionStyle,
    ),
    Text(
      'Index 1: Contacts',
      style: optionStyle,
    ),
    Text(
      'Index 2: Passwords',
      style: optionStyle,
    ),
    Text(
      'Index 3: Browser',
      style: optionStyle,
    ),
    Text(
      'Index 4: Settings',
      style: optionStyle,
    ),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album_outlined),
            label: 'Album',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.contacts,
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: 'Passwords',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.screen_search_desktop),
            label: 'Browser',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey.shade200,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
