import 'package:flutter/cupertino.dart';
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
                DeviceAds(),
                SizedBox(height: 20),
                CategorySection(),
                CategoryItems(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================================
//                        USER INFO
// ==========================================================

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
              color: Colors.blue,
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

// ==========================================================
//                       SEARCH BAR
// ==========================================================

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

// ==========================================================
//                        WIDGET HELPERS
// ==========================================================

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

Widget _rentalOption(IconData icon, String label) {
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

// ==========================================================
//                        DEVICE ADS
// ==========================================================

class DeviceAds extends StatelessWidget {
  const DeviceAds({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _adImage("assets/images/rent.jpg"),
                _adImage("assets/images/vrheadset.jpg"),
                _adImage("assets/images/phone2.jpg"),
                _adImage("assets/images/gaminglaptop.png"),
                _adImage("assets/images/device1.jpg"),
                _adImage("assets/images/device2.png"),
                _adImage("assets/images/device3.png"),
                _adImage("assets/images/device4.png"),
              ],
            ),
          ),
        ),

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

        const SizedBox(height: 10),

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
}

// ==========================================================
//                       CATEGORY SECTION
// ==========================================================

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Categories",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "See All",
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================================
//                       CATEGORY ITEMS
// ==========================================================

class CategoryItems extends StatelessWidget {
  const CategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: SizedBox(
        height: 100,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _categoryItem(Icons.phone_android, "Phones"),
              _categoryItem(Icons.laptop_mac, "Laptops"),
              _categoryItem(Icons.tablet_mac, "Tablets"),
              _categoryItem(Icons.watch, "Watches"),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _categoryItem(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue[100],
            child: Icon(icon, size: 30, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
