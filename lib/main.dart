import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'account_management_sprint1/account_recovery/forgot_password.dart';

enum UserRole { renter, rentee }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const RoleSwitchApp());
}

class RoleSwitchApp extends StatelessWidget {
  const RoleSwitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Role Switch Demo',
      debugShowCheckedModeBanner: false,
      home: const HomeController(),
    );
  }
}

class HomeController extends StatefulWidget {
  const HomeController({super.key});

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
              const Text(
                'Switch Role',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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

// Example pages for Renter and Rentee
class RenterHomePage extends StatelessWidget {
  const RenterHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordPage(),
            ),
          );
        },
        child: const Text("Go to Forgot Password"),
      ),
    );
  }
}

class RenteeHomePage extends StatelessWidget {
  const RenteeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordPage(),
            ),
          );
        },
        child: const Text("Go to Forgot Password"),
      ),
    );
  }
}
