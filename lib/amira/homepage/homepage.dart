import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: const [
                UserInfo(),
                SizedBox(height: 10),
                SearchDevice(),
                Deviceads(),
             

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Padding(
        padding: EdgeInsets.only(bottom: 7),
        child: Text("Hello!"),
      ),
      subtitle: Text(
        "Jaafar",
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
      trailing: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: const DecorationImage(
                image: AssetImage(AppStyle.profile),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[100],
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppStyle {
  static const String profile = "assets/images/profilepic.png";
}

class SearchDevice extends StatelessWidget {
  const SearchDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search Device",
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),

        // Icons: CupertinoButton for iOS-style
        prefixIcon: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Icon(Icons.search),
        ),

        suffixIcon: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Icon(Icons.filter_list),
        ),
      ),
    );
  }
}

class Deviceads extends StatelessWidget {
  const Deviceads({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ----------- AD BANNERS -----------
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 160,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _adImage("/assets/images/rent.jpg"),
                  _adImage("/assets/images/vrheadset.jpg"),
                  _adImage("/assets/images/phone2.jpg"),
                  _adImage("/assets/images/gaminglaptop.png"),
                ],
              ),
            ),
          ),
        ),

        // ----------- TITLE -----------
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 16),
          child: Text(
            "What do you want to rent?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // ----------- RENTAL OPTIONS -----------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 40,
            runSpacing: 20,
            children: [
              _rentalOption(Icons.phone_android, "Phones"),
              _rentalOption(Icons.laptop_mac, "Laptops"),
              _rentalOption(Icons.tablet_mac, "Tablets"),
              _rentalOption(Icons.watch, "Watches"),
              _rentalOption(Icons.vrpano, "VR Headsets"),
            ],
          ),
        ),
      ],
    );
  }

  // ---------- AD IMAGE WIDGET ----------
  Widget _adImage(String path) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          path,
          width: 250,
          height: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ---------- RENTAL OPTION ----------
  static Widget _rentalOption(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue[100],
          child: Icon(icon, size: 30, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}


//booking slot, nama, description, condition, price/day






