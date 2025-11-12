import 'package:flutter/material.dart';

enum UserRole { renter, rentee }

class RoleController extends ChangeNotifier {
  UserRole _role = UserRole.renter;
  UserRole get role => _role;

  void switchRole(UserRole newRole) {
    _role = newRole;
    notifyListeners();
  }
}

class RenterHomePage extends StatelessWidget {
  const RenterHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('🏠 Renter Home Page', style: TextStyle(fontSize: 24)),
    );
  }
}

class RenteeHomePage extends StatelessWidget {
  const RenteeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('📦 Rentee Home Page', style: TextStyle(fontSize: 24)),
    );
  }
}
