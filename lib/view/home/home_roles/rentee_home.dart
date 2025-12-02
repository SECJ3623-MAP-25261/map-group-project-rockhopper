import 'package:flutter/material.dart';
import 'package:pinjamtech_app/view/messaging/rentee_chat_list_screen.dart'; 

class RenteeHome extends StatelessWidget {
  const RenteeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "PinjamTech",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Changed to green
              ),
            ),
            const SizedBox(height: 10),

            _buildUserInfo(context),

            const SizedBox(height: 20),
            const Text(
              "Rentee Dashboard",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green),
            ),

            const SizedBox(height: 20),
            const Text(
              "My Active Rentals",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // ACTIVE RENTALS GRID
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
                  child: const Center(
                    child: Icon(Icons.devices, size: 40, color: Colors.grey),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
            const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _quickActionCircle(Icons.search, "Browse"),
                _quickActionCircle(Icons.favorite, "Favorites"),
                _quickActionCircle(Icons.history, "History"),
                _quickActionCircle(Icons.settings, "Settings"),
              ],
            ),

            const SizedBox(height: 30),
            const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            _activityItem("Rented MacBook Pro", "2 days ago"),
            _activityItem("Returned iPhone 15", "1 week ago"),
            _activityItem("Rented PS5", "2 weeks ago"),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  //           USER INFO
  // ------------------------------
  Widget _buildUserInfo(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Hello!", style: TextStyle(fontSize: 14)),
          const SizedBox(height: 4),

          Row(
            children: [
              const Text("Jaafar",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1), // Green for Rentee
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: const Text(
                  'Rentee', // Rentee role
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      subtitle: const Text(
        "Manage your rental items", // Same subtitle
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),

      // CHAT + PROFILE ICONS
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CHAT ICON
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RenterChatListScreen()),
              );
            },
            child: Container(
              height: 48,
              width: 48,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.grey[300],
              ),
              child: const Icon(Icons.chat_bubble_outline, size: 26),
            ),
          ),

          // PROFILE ICON
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.grey[300],
            ),
            child: const Icon(Icons.person, size: 30),
          ),
        ],
      ),
    );
  }

  // ------------------------------
  //       QUICK ACTION CIRCLE
  // ------------------------------
  Widget _quickActionCircle(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green, width: 2), // Green border
            color: Colors.green.withOpacity(0.1), // Green background
          ),
          child: Icon(icon, color: Colors.green, size: 24), // Green icon
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // ------------------------------
  //        ACTIVITY ITEM
  // ------------------------------
  Widget _activityItem(String title, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.history, color: Colors.green), // Green icon
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                Text(time,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}