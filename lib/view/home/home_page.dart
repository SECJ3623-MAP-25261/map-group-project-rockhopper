/*import 'package:flutter/material.dart';
import '../profile/profile.dart';
import 'home_roles/role_switch_bottom_sheet.dart'; // import your role switch sheet
import '../listings/createlist.dart';
import 'search_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// ---------------------- HOME PAGE ----------------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  String currentRole = 'renter';

  final Map<String, Map<String, dynamic>> roleData = {
    'renter': {'name': 'Renter', 'color': Colors.blue},
    'rentee': {'name': 'Rentee', 'color': Colors.green},
  };

  @override
  Widget build(BuildContext context) {
    // Dynamically select pages based on role
    final List<Widget> pages = [
      const HomeContent(),
      const CreateList(),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 2) {
            // Profile icon tapped normally
            setState(() => currentIndex = index);
          } else {
            setState(() => currentIndex = index);
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 28),
            label: "Rent",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onLongPress: () {
                // Show role switch sheet on long press
                showModalBottomSheet(
                  context: context,
                  builder: (context) => RoleSwitchBottomSheet(
                    currentRole: currentRole,
                    roleData: roleData,
                    onSwitchRole: (newRole) {
                      setState(() {
                        currentRole = newRole;
                        currentIndex = 0; // switch to home content after role change
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: const Icon(Icons.person, size: 28),
            ),
            label: "Profile",
          ),
        ],
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
      ),
    );
  }
}

// ---------------------- HOME CONTENT ----------------------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: const [
        Center(
          child: Text(
            "PinjamTech",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(height: 20),
        SearchDevice(),
        SizedBox(height: 20),
        CategoryCircleSection(),
        SizedBox(height: 20),
        ItemCardList(),
      ],
    );
  }
}
class SearchDevice extends StatelessWidget {
  const SearchDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Search field tapped"); // Debug print
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 12.0),
              child: Icon(Icons.search, color: Colors.grey),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Search Devices",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.chat_bubble_outline, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- CATEGORY SECTION ----------------------
class CategoryCircleSection extends StatelessWidget {
  const CategoryCircleSection({super.key});

  Widget circleItem(String text) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[300],
        ),
        const SizedBox(height: 8),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hi Amira 👋",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              "View all",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            circleItem("Tablets"),
            circleItem("Laptops"),
            circleItem("Phones"),
            circleItem("XR/VR"),
          ],
        ),
      ],
    );
  }
}

// ---------------------- ITEM CARD LIST ----------------------
class ItemCardList extends StatelessWidget {
  const ItemCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ItemCard(
          name: "Lenovo Ideapad 3",
          price: "RM 8/day",
          available: true,
          duration: "Up to 60 days",
        ),
        SizedBox(height: 20),
        ItemCard(
          name: "Acer Nitro V15",
          price: "RM 10/day",
          available: false,
          duration: "Up to 60 days",
        ),
      ],
    );
  }
}

// ---------------------- ITEM CARD ----------------------
class ItemCard extends StatelessWidget {
  final String name;
  final String price;
  final bool available;
  final String duration;

  const ItemCard({
    super.key,
    required this.name,
    required this.price,
    required this.available,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Text(price),
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 12,
                color: available ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 6),
              Text(available ? "Available" : "Not Available"),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.timer, size: 14, color: Colors.orange),
              const SizedBox(width: 6),
              Text(duration),
            ],
          ),
        ],
      ),
    );
  }
}
*/
