import 'package:flutter/material.dart';

class RenteeHomeContent extends StatelessWidget {
  final Color roleColor;

  const RenteeHomeContent({
    Key? key,
    required this.roleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}