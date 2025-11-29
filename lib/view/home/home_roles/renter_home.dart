import 'package:flutter/material.dart';

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

// ----------------------------------------------------
// HOME PAGE + ROLE SWITCH
// ----------------------------------------------------
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
    // Pages change based on CURRENT ROLE
    List<Widget> pages = [
      currentRole == "renter"
          ? const RenterHomeContent(roleColor: Colors.blue)
          : const HomeContent(), // two types of home screens
      const CreateList(),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],

      // ----------------- NAVIGATION BAR -----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
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
                // ROLE SWITCH BOTTOM SHEET
                showModalBottomSheet(
                  context: context,
                  builder: (context) => RoleSwitchBottomSheet(
                    currentRole: currentRole,
                    roleData: roleData,
                    onSwitchRole: (newRole) {
                      setState(() {
                        currentRole = newRole;
                        currentIndex = 0;
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
      ),
    );
  }
}

// ----------------------------------------------------
// ROLE SWITCH SHEET
// ----------------------------------------------------
class RoleSwitchBottomSheet extends StatelessWidget {
  final String currentRole;
  final Map<String, Map<String, dynamic>> roleData;
  final Function(String) onSwitchRole;

  const RoleSwitchBottomSheet({
    super.key,
    required this.currentRole,
    required this.roleData,
    required this.onSwitchRole,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: roleData.keys.map((role) {
          return ListTile(
            title: Text(roleData[role]!['name']),
            trailing: currentRole == role
                ? const Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () => onSwitchRole(role),
          );
        }).toList(),
      ),
    );
  }
}

// ----------------------------------------------------
// RENTER HOME CONTENT (2x2 grid + circles)
// ----------------------------------------------------
class RenterHomeContent extends StatelessWidget {
  final Color roleColor;

  const RenterHomeContent({
    super.key,
    required this.roleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          "Renter Dashboard",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: roleColor,
          ),
        ),

        const SizedBox(height: 20),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ----------------------------------------------------
// ORIGINAL HOME CONTENT
// ----------------------------------------------------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
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
        CategoryCircleSection(),
      ],
    );
  }
}

// ----------------------------------------------------
// CATEGORY SECTION
// ----------------------------------------------------
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
        const Text(
          "Categories",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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

// ----------------------------------------------------
// ITEM LISTING PAGE (dummy for now)
// ----------------------------------------------------
class CreateList extends StatelessWidget {
  const CreateList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Create New Listing Page"));
  }
}

// ----------------------------------------------------
// PROFILE PAGE
// ----------------------------------------------------
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Page"),
    );
  }
}
