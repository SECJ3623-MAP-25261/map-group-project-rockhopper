import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:flutter/widgets.dart';
import 'homepage.dart';
=======
//import 'package:flutter/widgets.dart';
import 'home_page.dart';
>>>>>>> Stashed changes

class BottomBar extends StatefulWidget{
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();

}

class _BottomBarState extends State<BottomBar>{
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text('Index 1: business'),
    Text('Index 1: School'),
    Text('Index 1: School'),

  ];

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}