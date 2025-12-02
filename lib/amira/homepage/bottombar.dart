// bottom_bar.dart (Amira folder) with role-switch integration
import 'package:flutter/material.dart';
import '../homepage/home_page.dart';
import '../../muzhaffar/rentee_home.dart';
import '../../muzhaffar/role_switch_bottom_sheet.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  // Default role is renter
  String _currentRole = 'renter';

  final Map<String, Map<String, dynamic>> _roleData = {
    'renter': {
      'name': 'Renter',
      'color': Colors.blue,
    },
    'rentee': {
      'name': 'Rentee',
      'color': Colors.green,
    },
  };

  // Show bottom sheet to switch roles
  void _switchRole(String newRole) {
    setState(() {
      _currentRole = newRole;
    });
    Navigator.of(context).pop();
  }

  void _showRoleSwitchSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return RoleSwitchBottomSheet(
          currentRole: _currentRole,
          roleData: _roleData,
          onSwitchRole: _switchRole,
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildContent(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: _roleData[_currentRole]!['color'],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onLongPress: _showRoleSwitchSheet,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: _roleData[_currentRole]!['color'],
                child: Text(
                  _currentRole == 'renter' ? 'R' : 'E',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Dynamically show content based on role
  Widget _buildContent() {
    if (_selectedIndex == 0) {
      return _currentRole == 'renter'
          ? const HomePage() // Amira’s renter homepage
          : RenteeHomeContent(roleColor: _roleData['rentee']!['color']); // Muzhaffar’s rentee homepage
    } else {
      // Default placeholder for other tabs
      return Center(child: Text('Tab $_selectedIndex'));
    }
  }
}
