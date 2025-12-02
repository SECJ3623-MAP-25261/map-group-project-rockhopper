import 'package:flutter/material.dart';
import '../models/device_model.dart'; // Add this import

class ProductDetailScreen extends StatefulWidget {
  final Device device;

  const ProductDetailScreen({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _imageController = PageController();
  int _currentImageIndex = 0;
  int _rentalDays = 1;
  DateTime? _startDate;
  DateTime? _endDate;

  // Sample images for the product
  final List<String> _productImages = [
    'https://via.placeholder.com/400x300/4A90E2/FFFFFF?text=Product+Front',
    'https://via.placeholder.com/400x300/50E3C2/FFFFFF?text=Product+Side',
    'https://via.placeholder.com/400x300/9013FE/FFFFFF?text=Product+Back',
    'https://via.placeholder.com/400x300/F5A623/FFFFFF?text=Product+Angle',
  ];

  @override
  void initState() {
    super.initState();
    // Set default dates
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 1));
  }

  void _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026, 12, 31),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        _endDate = picked.add(Duration(days: _rentalDays));
      });
    }
  }

  void _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime(2026, 12, 31),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
        if (_startDate != null) {
          _rentalDays = picked.difference(_startDate!).inDays;
        }
      });
    }
  }

  void _updateRentalDays(int days) {
    setState(() {
      _rentalDays = days;
      if (_startDate != null) {
        _endDate = _startDate!.add(Duration(days: days));
      }
    });
  }

  void _proceedToRent() {
    // Calculate total cost
    final totalCost = widget.device.pricePerDay * _rentalDays;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Rental'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Device: ${widget.device.name}'),
            Text('Duration: $_rentalDays days'),
            Text('Total Cost: RM ${totalCost.toStringAsFixed(2)}'),
            if (_startDate != null && _endDate != null)
              Text('Period: ${_startDate!.day}/${_startDate!.month}/${_startDate!.year} → ${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Successfully rented ${widget.device.name} for $_rentalDays days!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Confirm Rent'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("=== PRODUCT DETAIL SCREEN LOADED ===");
    print("Device: ${widget.device.name}");
    print("Price: RM ${widget.device.pricePerDay}/day");
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'PRODUCT INFO',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            _buildImageCarousel(),
            const SizedBox(height: 24),

            // Price and Basic Info
            _buildPriceAndInfo(),
            const SizedBox(height: 20),

            // Specifications
            _buildSpecifications(),
            const SizedBox(height: 20),

            // Description
            _buildDescription(),
            const SizedBox(height: 20),

            // Rental Process Box
            _buildRentalProcess(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[100],
          ),
          child: PageView.builder(
            controller: _imageController,
            itemCount: _productImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(_productImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Image Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_productImages.length, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentImageIndex == index ? Colors.blue : Colors.grey[300],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPriceAndInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RM ${widget.device.pricePerDay.toStringAsFixed(0)}/day',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Rent Up to ${widget.device.maxRentalDays} days',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                widget.device.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 12,
                  color: widget.device.isAvailable ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.device.isAvailable ? 'Available' : 'Not Available',
                  style: TextStyle(
                    color: widget.device.isAvailable ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Brand: ${widget.device.brand}'),
              const SizedBox(height: 4),
              Text('Condition: ${widget.device.condition}'),
              const SizedBox(height: 4),
              const Text('Memory: 8GB RAM, 256GB SSD'),
              const SizedBox(height: 4),
              const Text('Color: Space Gray'),
              const SizedBox(height: 4),
              const Text('Year: 2024'),
              const SizedBox(height: 4),
              const Text('Processor: Apple M2 Chip'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: const Text(
            'Brand new laptop with licensed Adobe Photoshop tools and Lightroom. Perfect for students and professionals who need reliable performance for design work, programming, and everyday tasks. Comes with original packaging and all accessories.',
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 104, 100, 100),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRentalProcess() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rental Process',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 24, 103, 194),
            ),
          ),
          const SizedBox(height: 16),

          // Rental Duration
          Row(
            children: [
              const Text(
                'Rental Duration',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        controller: TextEditingController(text: _rentalDays.toString()),
                        onChanged: (value) {
                          final days = int.tryParse(value) ?? 1;
                          if (days > 0 && days <= widget.device.maxRentalDays) {
                            _updateRentalDays(days);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text('days'),
            ],
          ),
          const SizedBox(height: 16),

          // Dates
          const Text(
            'Dates',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _selectStartDate,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _startDate != null
                              ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                              : 'Select Start Date',
                          style: TextStyle(
                            color: _startDate != null ? Colors.black : Colors.grey,
                          ),
                        ),
                        const Icon(Icons.calendar_today, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward, size: 16),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _selectEndDate,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _endDate != null
                              ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                              : 'Select End Date',
                          style: TextStyle(
                            color: _endDate != null ? Colors.black : Colors.grey,
                          ),
                        ),
                        const Icon(Icons.calendar_today, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              // Chat Button
              Expanded(
                flex: 2,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Chat feature coming soon!')),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  icon: const Icon(Icons.chat, color: Colors.blue),
                  label: const Text(
                    'Chat',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Rent Now Button
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: widget.device.isAvailable ? _proceedToRent : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Rent Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }
}