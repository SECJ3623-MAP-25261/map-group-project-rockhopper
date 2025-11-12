import 'package:flutter/material.dart';
import 'account management-SPRINT1/user role/user_role.dart';
import 'account management-SPRINT1/user role/renter_home_page.dart';
import 'account management-SPRINT1/user role/rentee_home_page.dart';

void main() {
  runApp(const RoleSwitchApp());
}

class RoleSwitchApp extends StatelessWidget {
  const RoleSwitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Role Switch Demo',
      home: HomeController(),
    );
  }
}

class HomeController extends StatefulWidget {
  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  UserRole _role = UserRole.renter;
  int _selectedIndex = 0;

  void _switchRole(UserRole newRole) {
    setState(() {
      _role = newRole;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showRoleSwitchDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Switch Role',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Switch to Renter'),
                onTap: () {
                  _switchRole(UserRole.renter);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.house),
                title: const Text('Switch to Rentee'),
                onTap: () {
                  _switchRole(UserRole.rentee);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getHomePage() {
    switch (_role) {
      case UserRole.renter:
        return const RenterHomePage();
      case UserRole.rentee:
        return const RenteeHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getHomePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          const BottomNavigationBarItem(icon: Icon(Icons.navigation), label: 'Home'),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onLongPress: _showRoleSwitchDialog,
              child: const Icon(Icons.person),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
