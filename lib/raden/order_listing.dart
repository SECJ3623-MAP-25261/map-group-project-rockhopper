import 'package:flutter/material.dart';
// ADA PROBLEM SINIIIIIII
class OrderListingScreen extends StatelessWidget {
  const OrderListingScreen({super.key});

  // Dummy past orders
  final List<Map<String, dynamic>> orders = const [
    {
      'name': 'Acer Nitro V15',
      'price': 10,
      'duration': 'Up to 60 days',
      'status': 'yellow', // renting
      'image':
          'https://cdn.uc.assets.prezly.com/26bcc88a-0478-40a1-8f29-cf52ef86196c/nitro_v15_special_angle_2.png',
    },
    {
      'name': 'Lenovo Ideapad 3',
      'price': 8,
      'duration': 'Up to 60 days',
      'status': 'green', // returned
      'image':
          'https://cdn.nbplaza.com.my/img/p/5/2/4/9/3/52493-large_default.jpg',
    },
    {
      'name': 'MacBook Pro',
      'price': 15,
      'duration': 'Up to 30 days',
      'status': 'red', // not received
      'image':
          'https://cdn.mos.cms.futurecdn.net/GeR8TCNH9jNRSurCVxoDaC-1046-80.jpg.webp',
    },
  ];

  Color statusColor(String status) {
    switch (status) {
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: Image.network(order['image'], width: 60, height: 60),
              title: Text(order['name']),
              subtitle: Text('Duration: ${order['duration']} | Price: RM ${order['price']}'),
              trailing: Icon(Icons.circle,
                  color: statusColor(order['status']), size: 16),
            ),
          );
        },
      ),
    );
  }
}
