import 'package:flutter/material.dart';
import '../models/device_model.dart'; // Add this import
//import 'product_detail_screen.dart'; // Add this import
import '../listings/rentee_listing.dart'; // Add this import

class ProductListScreen extends StatefulWidget {
  final String searchQuery;

  const ProductListScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Device> _devices = [];
  List<Device> _filteredDevices = [];
  bool _isLoading = true;
  
  // Sorting variables
  String _selectedSort = 'name_asc';
  final Map<String, String> _sortOptions = {
    'name_asc': 'Name (A-Z)',
    'name_desc': 'Name (Z-A)',
    'price_asc': 'Price (Low to High)',
    'price_desc': 'Price (High to Low)',
    'available_first': 'Available First',
  };

  // Filter variables
  final Map<String, bool> _brandFilters = {
    'Apple': false,
    'ASUS': false,
    'Acer': false,
    'Dell': false,
    'Lenovo': false,
    'HP': false,
  };
  
  final Map<String, bool> _durationFilters = {
    '1 day': false,
    '7 days': false,
    '14 days': false,
    '60 days': false,
    '100 days': false,
  };
  
  final Map<String, bool> _conditionFilters = {
    'NEW': false,
    'Rarely used': false,
    'Heavily used': false,
  };
  
  double _minPrice = 0;
  double _maxPrice = 20;
  int _activeFilterCount = 0;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  void _loadDevices() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _devices = _getSampleDevices();
        _applySortingAndFiltering();
        _isLoading = false;
      });
    });
  }

  void _applySortingAndFiltering() {
    List<Device> filtered = List.from(_devices);

    // Apply brand filters
    final selectedBrands = _brandFilters.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
        
    if (selectedBrands.isNotEmpty) {
      filtered = filtered.where((device) => selectedBrands.contains(device.brand)).toList();
    }

    // Apply duration filters
    final selectedDurationEntries = _durationFilters.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
        
    if (selectedDurationEntries.isNotEmpty) {
      // Convert duration strings to actual day values for comparison
      final durationMap = {
        '1 day': 1,
        '7 days': 7,
        '14 days': 14,
        '60 days': 60,
        '100 days': 100,
      };
      
      final selectedDurations = selectedDurationEntries
          .map((entry) => durationMap[entry]!)
          .toList();
          
      filtered = filtered.where((device) => selectedDurations.contains(device.maxRentalDays)).toList();
    }

    // Apply condition filters
    final selectedConditions = _conditionFilters.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
        
    if (selectedConditions.isNotEmpty) {
      filtered = filtered.where((device) => selectedConditions.contains(device.condition)).toList();
    }

    // Apply price range filter
    filtered = filtered.where((device) => 
      device.pricePerDay >= _minPrice && device.pricePerDay <= _maxPrice
    ).toList();

    // Apply sorting
    switch (_selectedSort) {
      case 'name_asc':
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'name_desc':
        filtered.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'price_asc':
        filtered.sort((a, b) => a.pricePerDay.compareTo(b.pricePerDay));
        break;
      case 'price_desc':
        filtered.sort((a, b) => b.pricePerDay.compareTo(a.pricePerDay));
        break;
      case 'available_first':
        filtered.sort((a, b) {
          if (a.isAvailable && !b.isAvailable) return -1;
          if (!a.isAvailable && b.isAvailable) return 1;
          return 0;
        });
        break;
    }

    setState(() {
      _filteredDevices = filtered;
      _updateActiveFilterCount();
    });
  }

  void _updateActiveFilterCount() {
    int count = 0;
    
    count += _brandFilters.values.where((value) => value).length;
    count += _durationFilters.values.where((value) => value).length;
    count += _conditionFilters.values.where((value) => value).length;
    
    // Count price filter if not at default values
    if (_minPrice > 0 || _maxPrice < 20) {
      count += 1;
    }
    
    setState(() {
      _activeFilterCount = count;
    });
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ..._sortOptions.entries.map((entry) {
                return ListTile(
                  leading: Radio<String>(
                    value: entry.key,
                    groupValue: _selectedSort,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedSort = value!;
                        _applySortingAndFiltering();
                      });
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(entry.value),
                  onTap: () {
                    setState(() {
                      _selectedSort = entry.key;
                      _applySortingAndFiltering();
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Reset all filters
                          setModalState(() {
                            _brandFilters.updateAll((key, value) => false);
                            _durationFilters.updateAll((key, value) => false);
                            _conditionFilters.updateAll((key, value) => false);
                            _minPrice = 0;
                            _maxPrice = 20;
                          });
                          // Apply changes immediately
                          _applySortingAndFiltering();
                        },
                        child: const Text('Reset All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brand Section
                          _buildFilterSection(
                            title: 'Brand',
                            filters: _brandFilters,
                            onChanged: (key, value) {
                              setModalState(() {
                                _brandFilters[key] = value!;
                              });
                            },
                          ),

                          const SizedBox(height: 24),

                          // Rental Duration Section
                          _buildFilterSection(
                            title: 'Rental Duration',
                            filters: _durationFilters,
                            onChanged: (key, value) {
                              setModalState(() {
                                _durationFilters[key] = value!;
                              });
                            },
                          ),

                          const SizedBox(height: 24),

                          // Price Range Section
                          _buildPriceRangeSection(setModalState),

                          const SizedBox(height: 24),

                          // Condition Section
                          _buildFilterSection(
                            title: 'Condition',
                            filters: _conditionFilters,
                            onChanged: (key, value) {
                              setModalState(() {
                                _conditionFilters[key] = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Apply Filters Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _applySortingAndFiltering();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Apply Filters',
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
            );
          },
        );
      },
    );
  }

  Widget _buildFilterSection({
    required String title,
    required Map<String, bool> filters,
    required Function(String, bool?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filters.entries.map((entry) {
            return FilterChip(
              label: Text(entry.key),
              selected: entry.value,
              onSelected: (selected) => onChanged(entry.key, selected),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceRangeSection(StateSetter setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Range (RM/day)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        RangeSlider(
          values: RangeValues(_minPrice, _maxPrice),
          min: 0,
          max: 20,
          divisions: 20,
          labels: RangeLabels(
            'RM ${_minPrice.toStringAsFixed(0)}',
            'RM ${_maxPrice.toStringAsFixed(0)}',
          ),
          onChanged: (RangeValues values) {
            setModalState(() {
              _minPrice = values.start;
              _maxPrice = values.end;
            });
          },
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('RM ${_minPrice.toStringAsFixed(0)}'),
            Text('RM ${_maxPrice.toStringAsFixed(0)}'),
          ],
        ),
      ],
    );
  }

  List<Device> _getSampleDevices() {
    return [
      Device(
        id: '1',
        name: 'Lenovo Ideapad 3',
        brand: 'Lenovo',
        pricePerDay: 8.0,
        imageUrl: 'https://via.placeholder.com/150x100/4A90E2/FFFFFF?text=Lenovo',
        isAvailable: true,
        maxRentalDays: 60,
        condition: 'Rarely used',
      ),
      Device(
        id: '2',
        name: 'Acer Nitro V15',
        brand: 'Acer',
        pricePerDay: 10.0,
        imageUrl: 'https://via.placeholder.com/150x100/50E3C2/FFFFFF?text=Acer+Nitro',
        isAvailable: false,
        maxRentalDays: 60,
        condition: 'Like new',
      ),
      Device(
        id: '3',
        name: 'MacBook Air M1',
        brand: 'Apple',
        pricePerDay: 15.0,
        imageUrl: 'https://via.placeholder.com/150x100/9013FE/FFFFFF?text=MacBook',
        isAvailable: true,
        maxRentalDays: 30,
        condition: 'NEW',
      ),
      Device(
        id: '4',
        name: 'ASUS ROG Strix',
        brand: 'ASUS',
        pricePerDay: 12.0,
        imageUrl: 'https://via.placeholder.com/150x100/417505/FFFFFF?text=ASUS+ROG',
        isAvailable: true,
        maxRentalDays: 90,
        condition: 'Heavily used',
      ),
      Device(
        id: '5',
        name: 'Dell XPS 13',
        brand: 'Dell',
        pricePerDay: 11.0,
        imageUrl: 'https://via.placeholder.com/150x100/F5A623/FFFFFF?text=Dell+XPS',
        isAvailable: true,
        maxRentalDays: 45,
        condition: 'Rarely used',
      ),
      Device(
        id: '6',
        name: 'HP Pavilion',
        brand: 'HP',
        pricePerDay: 7.0,
        imageUrl: 'https://via.placeholder.com/150x100/BD10E0/FFFFFF?text=HP+Pavilion',
        isAvailable: false,
        maxRentalDays: 30,
        condition: 'Heavily used',
      ),
      Device(
        id: '7',
        name: 'Apple MacBook Pro',
        brand: 'Apple',
        pricePerDay: 18.0,
        imageUrl: 'https://via.placeholder.com/150x100/000000/FFFFFF?text=MacBook+Pro',
        isAvailable: true,
        maxRentalDays: 14,
        condition: 'NEW',
      ),
      Device(
        id: '8',
        name: 'ASUS Zenbook',
        brand: 'ASUS',
        pricePerDay: 9.0,
        imageUrl: 'https://via.placeholder.com/150x100/7ED321/FFFFFF?text=ASUS+Zenbook',
        isAvailable: true,
        maxRentalDays: 100,
        condition: 'Rarely used',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.searchQuery,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Header with Sort and Filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                Text(
                  '${_filteredDevices.length} results',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                // Current Sort Display
                Text(
                  _sortOptions[_selectedSort]!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                // Sort Button
                TextButton.icon(
                  onPressed: _showSortOptions,
                  icon: const Icon(Icons.sort, size: 18),
                  label: const Text('Sort'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
                // Filter Button with badge
                Stack(
                  children: [
                    TextButton.icon(
                      onPressed: _showFilters,
                      icon: const Icon(Icons.filter_list, size: 18),
                      label: const Text('Filter'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                    ),
                    if (_activeFilterCount > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$_activeFilterCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          // Product List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredDevices.isEmpty
                    ? const Center(
                        child: Text(
                          'No devices found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredDevices.length,
                        itemBuilder: (context, index) {
                          final device = _filteredDevices[index];
                          return DeviceCard(device: device);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

// Device Card Widget
class DeviceCard extends StatelessWidget {
  final Device device;

  const DeviceCard({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
        // Navigate to RenteeListing with the device details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RenteeListing(
              name: device.name,
              price: "RM ${device.pricePerDay.toStringAsFixed(0)}/day",
              bookedSlots: [], // You can add actual booked dates here if available
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Image
            Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
                image: DecorationImage(
                  image: NetworkImage(device.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Device Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'RM ${device.pricePerDay.toStringAsFixed(0)}/day',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: device.isAvailable ? Colors.green[50] : Colors.red[50],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: device.isAvailable ? Colors.green : Colors.red,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 8,
                              color: device.isAvailable ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              device.isAvailable ? 'Available' : 'Not Available',
                              style: TextStyle(
                                fontSize: 12,
                                color: device.isAvailable ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Up to ${device.maxRentalDays} days',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Condition: ${device.condition}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}