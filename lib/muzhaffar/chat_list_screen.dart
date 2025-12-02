import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chats = [
      {
        "item": "MacBook Air M4 2024",
        "username": "Anonym123",
        "time": "13:13",
      },
      {
        "item": "ASUS ROG Zephyrus G14",
        "username": "Anonym123",
        "time": "11:34",
      },
      {
        "item": "Lenovo Ideapad 3i",
        "username": "Abc321",
        "time": "10:43",
      },
      {
        "item": "Camera", // Since your image shows "Moname234 @Rentee" without item name
        "username": "Moname234 @Rentee",
        "time": "08:17",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (context, index) => const Divider(height: 0),
        itemBuilder: (_, i) {
          final chat = chats[i];
          
          final String item = chat["item"] as String;
          final String username = chat["username"] as String;
          final String time = chat["time"] as String;
          
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  chatName: username.replaceAll(" @Rentee", ""),
                  itemName: item,
                  itemPrice: "\$20/day",
                  isRenter: true,
                ),
              ),
            ),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: _getAvatarColor(username),
                    child: Text(
                      username.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Time
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getAvatarColor(String username) {
    final colors = [
      Colors.blue.shade700,
      Colors.green.shade700,
      Colors.orange.shade700,
      Colors.purple.shade700,
    ];
    
    String cleanUsername = username.split(' ').first;
    return colors[cleanUsername.hashCode % colors.length];
  }
}