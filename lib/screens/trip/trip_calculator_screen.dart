import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import 'trip_summary_screen.dart';

class TripCalculatorScreen extends StatefulWidget {
  const TripCalculatorScreen({super.key});

  @override
  State<TripCalculatorScreen> createState() => _TripCalculatorScreenState();
}

class _TripCalculatorScreenState extends State<TripCalculatorScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _avgKmLitreController = TextEditingController();
  final TextEditingController _pkrLitreController = TextEditingController();
  final TextEditingController _tollParkingController = TextEditingController();
  final TextEditingController _foodSnacksController = TextEditingController();

  int _peopleCount = 1;
  String _selectedVehicle = 'Civic';
  bool _showDistance = false;

  final List<Map<String, dynamic>> _vehicles = [
    {
      'name': 'Alto',
      'km': 18.0,
      'price': 275.0,
      'icon': Icons.directions_car_rounded,
    },
    {
      'name': 'Passo',
      'km': 16.0,
      'price': 275.0,
      'icon': Icons.directions_car_rounded,
    },
    {
      'name': 'Civic',
      'km': 14.0,
      'price': 275.0,
      'icon': Icons.directions_car_rounded,
    },
    {
      'name': 'City',
      'km': 13.0,
      'price': 275.0,
      'icon': Icons.directions_car_rounded,
    },
    {
      'name': 'Corolla',
      'km': 13.0,
      'price': 275.0,
      'icon': Icons.directions_car_rounded,
    },
    {
      'name': 'Swift',
      'km': 16.0,
      'price': 275.0,
      'icon': Icons.directions_car_rounded,
    },
    {
      'name': 'WagonR',
      'km': 16.0,
      'price': 275.0,
      'icon': Icons.directions_car_rounded,
    },
    {
      'name': 'Mehran',
      'km': 18.0,
      'price': 275.0,
      'icon': Icons.directions_car_rounded,
    },
    {
      'name': 'Cultus',
      'km': 16.0,
      'price': 275.0,
      'icon': Icons.directions_car_rounded,
    },
    {
      'name': 'Other',
      'km': 14.0,
      'price': 275.0,
      'icon': Icons.directions_car_rounded,
    },
  ];

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _distanceController.dispose();
    _avgKmLitreController.dispose();
    _pkrLitreController.dispose();
    _tollParkingController.dispose();
    _foodSnacksController.dispose();
    super.dispose();
  }

  void _onRouteChanged() {
    if (_fromController.text.isNotEmpty && _toController.text.isNotEmpty) {
      setState(() {
        _showDistance = true;
      });
    } else {
      setState(() {
        _showDistance = false;
      });
    }
  }

  void _navigateToSummary() {
    double? distance;

    if (_distanceController.text.isNotEmpty) {
      distance = double.tryParse(_distanceController.text);
    } else if (_showDistance) {
      distance = 350;
    }

    if (distance == null || distance <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _showDistance
                ? 'Tap "Use this distance" or enter distance manually'
                : 'Please enter distance',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final avgKmLitre = double.tryParse(_avgKmLitreController.text) ?? 0;
    final pkrLitre = double.tryParse(_pkrLitreController.text) ?? 0;
    final tollParking = double.tryParse(_tollParkingController.text) ?? 0;
    final foodSnacks = double.tryParse(_foodSnacksController.text) ?? 0;

    if (avgKmLitre <= 0 || pkrLitre <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a vehicle'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final fuelCost = (distance / avgKmLitre) * pkrLitre;
    final extraCosts = tollParking + foodSnacks;
    final totalCost = fuelCost + extraCosts;
    final perPerson = _peopleCount > 0 ? totalCost / _peopleCount : totalCost;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripSummaryScreen(
          fromLocation: _fromController.text,
          toLocation: _toController.text,
          distance: distance!,
          vehicle: _selectedVehicle,
          avgKmLitre: avgKmLitre,
          pkrLitre: pkrLitre,
          tollParking: tollParking,
          foodSnacks: foodSnacks,
          peopleCount: _peopleCount,
          totalCost: totalCost,
          perPerson: perPerson,
          fuelCost: fuelCost,
        ),
      ),
    );
  }

  void _selectVehicle(Map<String, dynamic> vehicle) {
    setState(() {
      _selectedVehicle = vehicle['name'];
      _avgKmLitreController.text = vehicle['km'].toString();
      _pkrLitreController.text = vehicle['price'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: isDark ? null : const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Plan your Trip",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Split fuel costs effortlessly with your friends',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[800],
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ROUTE DETAILS',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 8,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          Icons.location_pin,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _fromController,
                          onChanged: (_) => _onRouteChanged(),
                          decoration: const InputDecoration(
                            hintText: 'From (e.g., Lahore)',
                            border: UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF3B82F6),
                                width: 2,
                              ),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          Icons.navigation,
                          color: colorScheme.secondary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _toController,
                          onChanged: (_) => _onRouteChanged(),
                          decoration: const InputDecoration(
                            hintText: 'To (e.g., Islamabad)',
                            border: UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF3B82F6),
                                width: 2,
                              ),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
            const SizedBox(height: 20),
            if (_showDistance) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'TOTAL DISTANCE',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '350 km',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'estimated via M-2 motorway',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 24),
            Text(
              'Vehicle Presets',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ).animate().fadeIn(delay: 250.ms),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = _vehicles[index];
                  final isSelected = _selectedVehicle == vehicle['name'];
                  return GestureDetector(
                    onTap: () => _selectVehicle(vehicle),
                    child: Container(
                      width: 90,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary
                            : (isDark
                                  ? AppColors.surfaceDark
                                  : const Color(0xFFF8F9FA)),
                        borderRadius: BorderRadius.circular(24),
                        border: isSelected
                            ? null
                            : Border.all(
                                color: isDark
                                    ? Colors.grey[700]!
                                    : Colors.grey[200]!,
                              ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            vehicle['name'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : null,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: (300 + index * 50).ms);
                },
              ),
            ),
            const SizedBox(height: 12),
            if (_avgKmLitreController.text.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.surfaceDark
                            : const Color(0xF3F4F5),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.speed_rounded,
                            size: 18,
                            color: Color(0xFF10B981),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Avg KM/L',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.black,
                                  fontSize: 8,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _avgKmLitreController.text,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.surfaceDark
                            : const Color(0xF3F4F5),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.local_gas_station_rounded,
                            size: 18,
                            color: Color(0xFF10B981),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PKR / LITRE',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: isDark
                                          ? Colors.grey[400]
                                          : Colors.black,
                                      fontSize: 8,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _pkrLitreController.text,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : const Color(0xF3F4F5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05)),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TRAVELLING BUDDIES',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Number of People',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: isDark ? Colors.grey[400] : Colors.black,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          onPressed: _peopleCount > 1
                              ? () {
                                  setState(() {
                                    _peopleCount--;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.remove_rounded),
                          style: IconButton.styleFrom(
                            backgroundColor: colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            foregroundColor: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 40,
                          child: Text(
                            '$_peopleCount',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton.filled(
                          onPressed: () {
                            setState(() {
                              _peopleCount++;
                            });
                          },
                          icon: const Icon(Icons.add_rounded),
                          style: IconButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : const Color(0xF3F4F5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05)),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_long),
                      const SizedBox(width: 8),
                      Text(
                        'Extra Costs',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ).animate().fadeIn(delay: 550.ms),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _CostInput(
                    icon: Icons.toll_rounded,
                    label: 'Tolls & Parking',
                    controller: _tollParkingController,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  _CostInput(
                    icon: Icons.restaurant_rounded,
                    label: 'Food & Snacks',
                    controller: _foodSnacksController,
                    color: Colors.grey,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _navigateToSummary,
                label: const Text('Calculate Trip Cost'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: colorScheme.primary,
                ),
              ),
            ).animate().fadeIn(delay: 650.ms),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
    String? prefix,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Icon(icon, color: color),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CostInput extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final Color color;

  const _CostInput({
    required this.icon,
    required this.label,
    required this.controller,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Text(
            'PKR',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
