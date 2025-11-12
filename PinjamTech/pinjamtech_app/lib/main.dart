import 'package:flutter/material.dart';
import 'account management-SPRINT1/user role/user_role.dart';

void main() {
  runApp(const RoleSwitchApp());
}

class RoleSwitchApp extends StatelessWidget {
  const RoleSwitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PinjamTech',
      debugShowCheckedModeBanner: false,
      home: const RoleSelectionPage(),
    );
  }
}

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  void _selectRole(BuildContext context, UserRole role) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeController(initialRole: role),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to PinjamTech',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'Choose your role:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.handshake_rounded),
                label: const Text('Login as a Renter'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.teal[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _selectRole(context, UserRole.renter),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.shopping_bag_rounded),
                label: const Text('Login as a Rentee'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blue[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _selectRole(context, UserRole.rentee),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeController extends StatefulWidget {
  final UserRole initialRole;
  const HomeController({super.key, required this.initialRole});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  late UserRole _role;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _role = widget.initialRole;
  }

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
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
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
