import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String gender;
  final String phone;

  const ProfilePage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.gender,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 10),
          const Center(
            child: Icon(Icons.person, size: 100, color: Colors.blueGrey),
          ),
          const SizedBox(height: 10),
          Text(
            email,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: $firstName $lastName'),
                Text('Username: $username'),
                Text('Gender: $gender'),
                Text('Phone: $phone'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
