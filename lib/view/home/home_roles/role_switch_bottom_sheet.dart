import 'package:flutter/material.dart';

class RoleSwitchBottomSheet extends StatelessWidget {
  final String currentRole;
  final Map<String, Map<String, dynamic>> roleData;
  final Function(String) onSwitchRole;

  const RoleSwitchBottomSheet({
    Key? key,
    required this.currentRole,
    required this.roleData,
    required this.onSwitchRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Switch Role',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Long press the profile icon to switch roles anytime',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          // Current Role
          ListTile(
            leading: CircleAvatar(
              backgroundColor: roleData[currentRole]!['color'],
              child: Text(
                currentRole == 'renter' ? 'R' : 'E',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              roleData[currentRole]!['name'],
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              currentRole == 'renter' 
                  ? 'Browse and rent items'
                  : 'List and manage your items',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: roleData[currentRole]!['color'],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Current',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Divider
          const Divider(),
          const SizedBox(height: 8),
          
          // Alternative Role
          ListTile(
            leading: CircleAvatar(
              backgroundColor: currentRole == 'renter' 
                  ? roleData['rentee']!['color']
                  : roleData['renter']!['color'],
              child: Text(
                currentRole == 'renter' ? 'E' : 'R',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              currentRole == 'renter' 
                  ? roleData['rentee']!['name']
                  : roleData['renter']!['name'],
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              currentRole == 'renter' 
                  ? 'List and manage your items'
                  : 'Browse and rent items',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            onTap: () {
              onSwitchRole(currentRole == 'renter' ? 'rentee' : 'renter');
            },
          ),
        ],
      ),
    );
  }
}