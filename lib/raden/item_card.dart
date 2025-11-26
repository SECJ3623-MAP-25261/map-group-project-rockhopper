import 'package:flutter/material.dart';
import 'rentee_listing.dart'; // import the RenteeListing page

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
          // Image placeholder
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 10),
          Text(name,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
          const SizedBox(height: 10),

          // ✅ RENT BUTTON
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
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
                "Rent",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
