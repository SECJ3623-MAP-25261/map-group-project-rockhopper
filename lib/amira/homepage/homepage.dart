import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'search_screen.dart'; 
>>>>>>> Stashed changes
import '/raden/edit_listing.dart';
import '/raden/cart_manager.dart';
import '/raden/renting_cart.dart';
import '/raden/rentee_listing.dart';



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
          Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text(
      "PinjamTech",
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    ),
    const SizedBox(width: 10),

Stack(
  children: [
    GestureDetector(
      onTap: () {
        // Navigate to cart screen (placeholder)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RentingCartScreen(),
          ),
        );
      },
      child: const Icon(Icons.shopping_cart, size: 28),
    ),
    Positioned(
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Text(
          CartManager().cart.length.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    ),
  ],
),

  ],
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


<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "what do you want to rent?",
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
            circleItem("xR/VR Box"),
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
      children: [
        const ItemCard(
          name: "Lenovo Ideapad 3",
          price: "RM 8/day",
          available: true,
          duration: "Up to 60 days",
          category: "laptop",
          description: "The smarter choice for mobility\n Pre-installed genuine Windows Office 2024 ",
          imagePath: "https://cdn.nbplaza.com.my/img/p/5/2/4/9/3/52493-large_default.jpg",
        ),
<<<<<<< Updated upstream
        const SizedBox(height: 20),
        const ItemCard(
=======
        
        SizedBox(height: 20),
        ItemCard(
>>>>>>> Stashed changes
          name: "Acer Nitro V15",
          price: "RM 10/day",
          available: false,
          duration: "Up to 60 days",
          condition: "Rarely used",
          category: "laptop",
        ),

TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditListing(
          name: "Acer Nitro V15",
          price: "RM 10/day",
          available: false,
          duration: "Up to 60 days",
          condition: "Rarely used",
          description:
          "This is the Acer Nitro V15, it’s Acer’s entry-level 15-inch gaming laptop, and it’s targeted towards gamers who are looking for the best specs without breaking the bank. In fact, it’s cheaper than the famous Helios 300 lineup and it competes directly with the MSI Bravo 15 and the Dell G5 15 SE.",
          category: "Laptop",
        ),
      ),
    );
  },
  child: const Text(
    ' Edit ',
    style: TextStyle(
      color: Colors.blue,
      fontSize: 14,
    ),
  ),
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
  final String? condition;
  final String? description;
  final String? category;
  final String? imagePath; 

  const ItemCard({
    super.key,
    required this.name,
    required this.price,
    required this.available,
    required this.duration,
    this.condition,
    this.description,
    this.category,
    this.imagePath,
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
          // IMAGE HOLDER
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(20),
              image: imagePath != null
                  ? DecorationImage(
                      image: AssetImage(imagePath!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imagePath == null
                ? const Icon(Icons.image, size: 70, color: Colors.white)
                : null,
          ),

          const SizedBox(height: 10),

          // NAME
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),

          // PRICE
          Text(price),

          // AVAILABILITY
          Row(
            children: [
              Icon(Icons.circle,
                  size: 12, color: available ? Colors.green : Colors.red),
              const SizedBox(width: 6),
              Text(available ? "Available" : "Not Available"),
            ],
          ),

          const SizedBox(height: 4),

          // DURATION DISPLAY
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: Colors.yellow),
              const SizedBox(width: 6),
              Text(duration),
            ],
          ),

          const SizedBox(height: 10),

          // dynamic data
          // BUTTONS SECTION
Align(
  alignment: Alignment.centerRight,
  child: Row(
    mainAxisSize: MainAxisSize.min, // only take needed width
    children: [
      // Edit Button
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditListing(
                name: name,
                price: price,
                available: available,
                duration: duration,
                condition: condition ?? "Not specified",
                description: description ?? "No description provided.",
                category: category ?? "Uncategorized",
                imagePath: imagePath,
              ),
            ),
          );
        },
        child: const Text(
          'Edit',
          style: TextStyle(color: Colors.blue, fontSize: 14),
        ),
      ),

      // Rent Button
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RenteeListing(
                name: name,
                price: price,
                bookedSlots: [
                  DateTime.utc(2025, 11, 5),
                  DateTime.utc(2025, 11, 7),
                  DateTime.utc(2025, 11, 20),
                ],
              ),
            ),
          );
        },
        child: const Text(
          'Rent',
          style: TextStyle(color: Colors.blue, fontSize: 14),
        ),
      ),
    ],
  ),
),

        ],
      ),
    );
  }
}
<<<<<<< Updated upstream


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
 
=======
>>>>>>> Stashed changes
