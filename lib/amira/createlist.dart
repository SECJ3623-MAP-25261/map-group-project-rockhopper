//create new list


import 'package:flutter/material.dart';

String? selectedCategory;

class CreateList extends StatefulWidget {
  
  const CreateList({Key? key}) : super(key: key);
  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('New Listing'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // <-- Icon for leading button
        onPressed: () {
          Navigator.pop(context); // Example action
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Publish action
          },
          child: const Text(
            'Publish',
            style: TextStyle(color: Colors.white), // Ensure it's visible on AppBar
          ),
        ),
      ],
    ),
    body: SingleChildScrollView(
      //add photos section (circle)
     padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //add photo section
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.camera_alt, 
                  size: 40, 
                  color: Colors.white,
                  ),
              ),
            ),
            const SizedBox(height: 20),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Rental Price per Day',
                border: OutlineInputBorder(),
                prefixText: '\RM',
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Deposit',
                border: OutlineInputBorder(),
                prefixText: '\RM',
              ),
              keyboardType: TextInputType.number,
            ),
            //category section, slide down menu
             const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: 'Category',
                      border:OutlineInputBorder(),  
                    ),
              value: selectedCategory,
              items: <String>['Tablets', 'Laptops', 'Phones', 'XR/VR Box']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedCategory = newValue;
          });
        },
      ),
            //condition section, slide down menu
            const SizedBox(height: 20),
           DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: 'Category',
                      border:OutlineInputBorder(),  
                    ),
              value: selectedCategory,
              items: <String>['Tablets', 'Laptops', 'Phones', 'XR/VR Box']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedCategory = newValue;
          });
        },
      ),
                
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Rent Duration',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Specification',
                border: OutlineInputBorder(),
              ),
            ),
           const Text(
            'Location',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
           )
          ],
        ),
      
      // Your page content here
    ),
  );
}
}