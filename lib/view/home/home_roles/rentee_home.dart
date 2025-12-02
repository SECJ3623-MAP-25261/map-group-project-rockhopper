import 'package:flutter/material.dart';
import '../../home/search_screen.dart';

class RenteeHome extends StatelessWidget {
  const RenteeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("PinjamTech", textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 10),
            _buildUserInfo(),
            const SizedBox(height: 20),
            const SearchDevice(),
            const SizedBox(height: 20),
            const DeviceAds(),
            const SizedBox(height: 20),
            const RentalOptionsSection(),
            const SizedBox(height: 30),
            const CategorySection(),
            const SizedBox(height: 20),
            const CategoryItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Hello!", style: TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text("Jaafar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: const Text('Rentee', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green)),
              ),
            ],
          ),
        ],
      ),
      subtitle: const Text("Find amazing devices to rent", style: TextStyle(fontSize: 14, color: Colors.grey)),
      trailing: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.grey[300]),
        child: const Icon(Icons.person, size: 30),
      ),
    );
  }
}

// Include your SearchDevice, DeviceAds, RentalOptionsSection, CategorySection, CategoryItems here exactly as in your code.


// ==========================================================
//                       SEARCH BAR
// ==========================================================
class SearchDevice extends StatelessWidget {
  const SearchDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: const IgnorePointer(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search Device",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.filter_list),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================================
//                        DEVICE ADS
// ==========================================================
class DeviceAds extends StatelessWidget {
  const DeviceAds({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _adImage(),
            _adImage(),
            _adImage(),
            _adImage(),
          ],
        ),
      ),
    );
  }

  Widget _adImage() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 250,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

// ==========================================================
//                   RENTAL OPTIONS SECTION
// ==========================================================
class RentalOptionsSection extends StatelessWidget {
  const RentalOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            "What do you want to rent?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 30,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            _rentalOption(Icons.phone_android, "Phones"),
            _rentalOption(Icons.laptop_mac, "Laptops"),
            _rentalOption(Icons.tablet_mac, "Tablets"),
            _rentalOption(Icons.watch, "Watches"),
            _rentalOption(Icons.vrpano, "VR Headsets"),
          ],
        ),
      ],
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
        Text(label, style: const TextStyle(fontSize: 12)),
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _categoryItem(Icons.phone_android, "Phones"),
          _categoryItem(Icons.laptop_mac, "Laptops"),
          _categoryItem(Icons.tablet_mac, "Tablets"),
          _categoryItem(Icons.watch, "Watches"),
        ],
      ),
    );
  }

  Widget _categoryItem(IconData icon, String label) {
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
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
