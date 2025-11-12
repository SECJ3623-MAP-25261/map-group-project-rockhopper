import 'package:flutter/material.dart';
import 'user_role.dart';

class RoleController extends ChangeNotifier {
  UserRole _role = UserRole.renter;
  UserRole get role => _role;

  void switchRole(UserRole newRole) {
    _role = newRole;
    notifyListeners();
  }
}
