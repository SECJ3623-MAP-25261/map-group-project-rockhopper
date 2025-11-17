import 'package:flutter/material.dart';

class EditListingPage extends StatefulWidget {
  const EditListingPage({super.key});

  @override
  State<EditListingPage> createState() => _EditListingPageState();
}

class _EditListingPageState extends State<EditListingPage> {
  // Fake demo data (Replace with real data later)
  final List<String> images = [
    "https://via.placeholder.com/400",
    "https://via.placeholder.com/401",
    "https://via.placeholder.com/402",
  ];

  final List<Map<String, String>> bookedUsers = [
    {"name": "Ali", "date": "12 Nov – 14 Nov"},
    {"name": "Sarah", "date": "20 Nov – 22 Nov"},
  ];

  DateTime? selectedDate;

  void _openEditPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const _DummyEditPage(),
      ),
    );
  }

  void _deleteListing() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Listing"),
        content:
            const Text("Are you sure you want to delete this rental item?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // go back after deletion
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Rental Item"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == "edit") _openEditPage();
              if (value == "delete") _deleteListing();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "edit", child: Text("Edit Listing")),
              const PopupMenuItem(
                  value: "delete",
                  child: Text(
                    "Delete Listing",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          )
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ---- IMAGES GALLERY ----
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, i) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(images[i], fit: BoxFit.cover),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ---- TITLE ----
          const Text(
            "Sony A6000 Camera",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // ---- PRICE ----
          const Text(
            "RM45 / day",
            style: TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),

          const SizedBox(height: 20),

          // ---- DESCRIPTION ----
          const Text("Description",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            "A compact mirrorless camera, rarely used. Perfect for travel and video.",
          ),

          const SizedBox(height: 20),

          // ---- CONDITION ----
          const Text("Condition",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("Rarely Used"),

          const SizedBox(height: 20),

          // ---- CATEGORY ----
          const Text("Category",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("Electronics / Camera"),

          const SizedBox(height: 20),

          // ---- DURATION ----
          const Text("Max Duration",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("3 days"),

          const SizedBox(height: 25),

          // ---- BOOKING SLOT PICKER ----
          ElevatedButton(
            onPressed: pickDate,
            child: const Text("Pick Booking Date"),
          ),

          if (selectedDate != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Selected: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                style: const TextStyle(color: Colors.green),
              ),
            ),

          const SizedBox(height: 30),

          // ---- USERS WHO BOOKED ----
          const Text(
            "Users Who Booked",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),

          ...bookedUsers.map((u) {
            return Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(u["name"]!),
                subtitle: Text("Booked: ${u["date"]}"),
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Dummy edit page (replace later)
class _DummyEditPage extends StatelessWidget {
  const _DummyEditPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Listing")),
      body: const Center(child: Text("Edit Page (Coming Soon)")),
    );
  }
}
