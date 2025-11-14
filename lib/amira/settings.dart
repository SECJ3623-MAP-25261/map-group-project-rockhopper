import 'package:flutter/material.dart';
import 'edit_profile.dart' show EditProfile;
import 'payment_method.dart';
class SettingsPage extends StatefulWidget{
    const SettingsPage({super.key});


  @override
  State<SettingsPage> createState() => _SettingsPageState();
}


  bool isSwitched = false;
class _SettingsPageState extends State<SettingsPage>{
  bool isSwitched = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.pink, // optional
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Add navigation to Edit Profile page
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfile()),
    );
              },
              
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Payment Method'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentApp()),
    );
              },
            ),
  Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
          ]
  ),
            

            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notification'),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value){
                setState((){
                  isSwitched = value;
                });
              }),
              
    ),

    ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Theme'),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value){
                setState((){
                  isSwitched = value;
                });
              }),
              
    ),

    ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
              },
            ),
            
          
            const SizedBox(height: 20),
            ElevatedButton(

              onPressed: () {
                Navigator.pop(context); // Go back
              },
              child: const Text('Log Out'),
            ),
          ],
        ),

      ),
    );
  }
}