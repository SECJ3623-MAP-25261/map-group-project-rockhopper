import 'package:flutter/material.dart';
import '../home/components/component.dart' show MyTextBox;
import '../settings/settings.dart'; 
import '../home/my_favorite.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  
  //edit field
  Future<void> editField(String field) async{

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', 
        ),
        
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          //profile pic
            
          Padding(
  padding: const EdgeInsets.only(left: 16.0),
  child: Row(
    children: [
      Icon(Icons.person, size: 100),
    ],
  ),
),

    
          //user email
           Text(
            'yourname@gmail.com',
            style: TextStyle(
            fontSize: 10.0,
            color: Colors.grey[700],
            
           )
           ),
           const SizedBox(height: 10),
          //user details
    Container(
      width: 150,
      height: 150,
       decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(100),
       ),
        padding : const EdgeInsets.only(left: 10.0),
           
            child:Text(
              'Bio',
              style: TextStyle(color: Colors.grey[600]),
              
            ),
          ), 
    
         
          //My Favourites
          MyTextBox(
            text: 'My Address',
           sectionName: 'username', 
           onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  },
           ),
        // My Favourites
MyTextBox(
  text: 'My History',
  sectionName: 'username', 
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyFavourite()),
    );
  },
),

// Settings
MyTextBox(

  text: 'Settings',
  sectionName: 'username', 
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  },
),

MyTextBox(

  text: 'Help & Support',
  sectionName: 'username', 
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  },
),


 // Settings 

          
        ],
      ),
    );
  }
}