import 'package:flutter/material.dart';

class QuickReplies extends StatelessWidget {
  final Function(String) onReplySelected;

  const QuickReplies({super.key, required this.onReplySelected});

  @override
  Widget build(BuildContext context) {
    final replies = [
      "Hi! Is this still available?",
      "Is the price negotiable?",
      "Where can we meet?",
      "Can I pay in installments?",
      "Is the product has any defect?",
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What would you like to ask? Try these:",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          
          // Horizontal scrollable list
          SizedBox(
            height: 50, // Fixed height for horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: replies.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    right: index < replies.length - 1 ? 8 : 0,
                  ),
                  child: ElevatedButton(
                    onPressed: () => onReplySelected(replies[index]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      replies[index],
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}