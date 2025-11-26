import 'package:flutter/material.dart';
import 'search_screen.dart'; // SIMPLE IMPORT - same folder
import '/raden/edit_listing.dart';

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
              "PinjamTech",
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

// ... REST OF AMIRA'S ORIGINAL CODE REMAINS UNCHANGED ...
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