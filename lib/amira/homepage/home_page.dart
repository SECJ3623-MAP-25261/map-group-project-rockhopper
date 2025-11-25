import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

// Main HomeScreen with BottomNavigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    Center(child: Text("Rent Page", style: TextStyle(fontSize: 24))),
    Center(child: Text("Profile Page", style: TextStyle(fontSize: 24))),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 28),
            label: 'Rent',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Your original HomePage code
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 20),

          // App Title
          const Center(
            child: Text(
              "PT",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: const [
                SizedBox(height: 20),
                SearchDevice(),
                SizedBox(height: 20),
                CategoryCircleSection(),
                SizedBox(height: 20),
                ItemCardList(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class SearchDevice extends StatelessWidget {
  const SearchDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search Devices",
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}

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
        Text(text,
            style: const TextStyle(
              fontSize: 12,
            ))
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
              "HI",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text("View all"),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            circleItem("Tablets"),
            circleItem("Laptops"),
            circleItem("Phones"),
            circleItem("camera"),
          ],
        ),
      ],
    );
  }
}

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
          Text(name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          Text(price),
          Row(
            children: [
              Icon(Icons.circle,
                  size: 12, color: available ? Colors.green : Colors.red),
              const SizedBox(width: 6),
              Text(available ? "Available" : "Not Available"),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.star, size: 14, color: Colors.yellow),
              SizedBox(width: 6),
              Text("Up to 60 days")
            ],
          ),
        ],
      ),
    );
  }
}


class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.add_circle, color: Colors.white, size: 32),
          Icon(Icons.bar_chart, color: Colors.white, size: 30),
          Icon(Icons.person, color: Colors.white, size: 30),
        ],
      ),
    );
  }
}
