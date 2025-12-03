import 'package:flutter/material.dart';
import '../home/components/component.dart' show MyTextBox;
import '../settings/settings.dart';
import '../home/my_favorite.dart';
import 'user_model.dart';

class RenteeProfile extends StatefulWidget {
  const RenteeProfile({super.key});

  @override
  State<RenteeProfile> createState() => _RenteeProfileState();
}

class _RenteeProfileState extends State<RenteeProfile> {
  // Initial user data
  UserProfile user = UserProfile(
    firstName: 'Jaafar',
    lastName: 'Baba',
    username: 'JAABAR',
    email: 'yourname@gmail.com',
    phone: '011349283',
    gender: 'Male',
    bio: 'This is your bio. Share a little about yourself!',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 10),

          // Profile Picture
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange[200],
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 15),

          // User Name
          Center(
            child: Text(
              user.firstName,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          const SizedBox(height: 5),

          // User Email
          Center(
            child: Text(
              user.email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Bio Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              user.bio,
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),

          // Profile Options
          MyTextBox(
            text: 'My Address',
            sectionName: 'Rentee',
            onPressed: () async {
              // Navigate to settings and get updated profile
              final updatedUser = await Navigator.push<UserProfile>(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(user: user),
                ),
              );
              if (updatedUser != null) {
                setState(() {
                  user = updatedUser; // update UI
                });
              }
            },
          ),
          const SizedBox(height: 10),

          MyTextBox(
            text: 'My History',
            sectionName: 'Rentee',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyFavourite()),
              );
            },
          ),
          const SizedBox(height: 10),

          MyTextBox(
            text: 'Settings',
            sectionName: 'Rentee',
            onPressed: () async {
              final updatedUser = await Navigator.push<UserProfile>(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(user: user),
                ),
              );
              if (updatedUser != null) {
                setState(() {
                  user = updatedUser;
                });
              }
            },
          ),
          const SizedBox(height: 10),

          MyTextBox(
            text: 'Help & Support',
            sectionName: 'Rentee',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
