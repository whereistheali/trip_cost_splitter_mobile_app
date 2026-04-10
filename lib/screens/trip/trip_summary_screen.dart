import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class TripSummaryScreen extends StatelessWidget {
  final String fromLocation;
  final String toLocation;
  final double distance;
  final String vehicle;
  final double avgKmLitre;
  final double pkrLitre;
  final double tollParking;
  final double foodSnacks;
  final int peopleCount;
  final double totalCost;
  final double perPerson;
  final double fuelCost;

  const TripSummaryScreen({
    super.key,
    required this.fromLocation,
    required this.toLocation,
    required this.distance,
    required this.vehicle,
    required this.avgKmLitre,
    required this.pkrLitre,
    required this.tollParking,
    required this.foodSnacks,
    required this.peopleCount,
    required this.totalCost,
    required this.perPerson,
    required this.fuelCost,
  });

  String _generateShareText() {
    return '''
🚗 Trip Cost Summary

📍 Route: $fromLocation → $toLocation
📏 Distance: ${distance.toStringAsFixed(1)} km
🚙 Vehicle: $vehicle

💰 Total Cost: Rs ${totalCost.toStringAsFixed(0)}
👥 People: $peopleCount
💵 Each Pays: Rs ${perPerson.toStringAsFixed(0)}

📊 Cost Breakdown:
⛽ Fuel: Rs ${fuelCost.toStringAsFixed(0)}
🛣️ Tolls & Parking: Rs ${tollParking.toStringAsFixed(0)}
🍔 Food & Snacks: Rs ${foodSnacks.toStringAsFixed(0)}

Calculated via Trip Cost Splitter App
''';
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _generateShareText()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Summary copied to clipboard!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _shareViaWhatsApp(BuildContext context) {
    final text = Uri.encodeComponent(_generateShareText());
    final url = 'whatsapp://send?text=$text';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Share: $text'), backgroundColor: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final extraCosts = tollParking + foodSnacks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Summary'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colorScheme.primary, colorScheme.secondary],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Each Pays',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rs ${perPerson.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SummaryStat(
                        label: 'Total',
                        value: 'Rs ${totalCost.toStringAsFixed(0)}',
                        icon: Icons.account_balance_wallet_rounded,
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      _SummaryStat(
                        label: 'People',
                        value: '$peopleCount',
                        icon: Icons.people_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),
            const SizedBox(height: 24),
            Text(
              'Route Details',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
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
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.circle,
                          color: colorScheme.primary,
                          size: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                            ),
                            Text(
                              fromLocation.isEmpty
                                  ? 'Not specified'
                                  : fromLocation,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    height: 20,
                    child: CustomPaint(
                      size: const Size(double.infinity, 20),
                      painter: _DashedLinePainter(color: colorScheme.primary),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: colorScheme.secondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                            ),
                            Text(
                              toLocation.isEmpty ? 'Not specified' : toLocation,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.05),
            const SizedBox(height: 16),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                      : [const Color(0xFFE0F2FE), const Color(0xFFBAE6FD)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size(double.infinity, 180),
                    painter: _RouteMapPainter(color: colorScheme.primary),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_car_rounded,
                          size: 36,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${distance.toStringAsFixed(1)} km',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$fromLocation → $toLocation',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 24),
            Text(
              'Trip Summary',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ).animate().fadeIn(delay: 250.ms),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
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
                children: [
                  _TripSummaryItem(
                    icon: Icons.directions_car_rounded,
                    label: 'Vehicle',
                    value: vehicle,
                    color: const Color(0xFF3B82F6),
                  ),
                  const SizedBox(height: 12),
                  _TripSummaryItem(
                    icon: Icons.straighten_rounded,
                    label: 'Distance',
                    value: '${distance.toStringAsFixed(1)} km',
                    color: const Color(0xFF10B981),
                  ),
                  const SizedBox(height: 12),
                  _TripSummaryItem(
                    icon: Icons.speed_rounded,
                    label: 'Fuel Efficiency',
                    value: '${avgKmLitre.toStringAsFixed(1)} km/L',
                    color: const Color(0xFFF59E0B),
                  ),
                  const SizedBox(height: 12),
                  _TripSummaryItem(
                    icon: Icons.local_gas_station_rounded,
                    label: 'Fuel Price',
                    value: 'Rs ${pkrLitre.toStringAsFixed(0)}/L',
                    color: const Color(0xFFEF4444),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.05),
            const SizedBox(height: 24),
            Text(
              'Cost Breakdown',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ).animate().fadeIn(delay: 350.ms),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
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
                children: [
                  _CostBreakdownItem(
                    label: 'Base Fuel Cost',
                    value: 'Rs ${fuelCost.toStringAsFixed(0)}',
                    color: const Color(0xFF10B981),
                    icon: Icons.local_gas_station_rounded,
                  ),
                  const Divider(height: 24),
                  _CostBreakdownItem(
                    label: 'Tolls & Parking',
                    value: 'Rs ${tollParking.toStringAsFixed(0)}',
                    color: const Color(0xFF4ECDC4),
                    icon: Icons.toll_rounded,
                  ),
                  const Divider(height: 24),
                  _CostBreakdownItem(
                    label: 'Food & Snacks',
                    value: 'Rs ${foodSnacks.toStringAsFixed(0)}',
                    color: const Color(0xFFFFBE0B),
                    icon: Icons.restaurant_rounded,
                  ),
                  const Divider(height: 24),
                  _CostBreakdownItem(
                    label: 'Total Amount',
                    value: 'Rs ${totalCost.toStringAsFixed(0)}',
                    color: colorScheme.primary,
                    icon: Icons.account_balance_wallet_rounded,
                    isBold: true,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.05),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _copyToClipboard(context),
                    icon: const Icon(Icons.copy_rounded),
                    label: const Text('Copy'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _shareViaWhatsApp(context),
                    icon: const Icon(Icons.share_rounded),
                    label: const Text('Share'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: const Color(0xFF25D366),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 450.ms),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

class _TripSummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _TripSummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _CostBreakdownItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;
  final bool isBold;

  const _CostBreakdownItem({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? color : null,
          ),
        ),
      ],
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;

  _DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startX = 22;

    while (startX < size.width - 22) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }

    canvas.drawCircle(
      Offset(22, size.height / 2),
      4,
      paint..style = PaintingStyle.fill,
    );
    canvas.drawCircle(Offset(size.width - 22, size.height / 2), 4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RouteMapPainter extends CustomPainter {
  final Color color;

  _RouteMapPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0.15, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.5,
      size.width * 0.5,
      size.height * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.3,
      size.width * 0.85,
      size.height * 0.3,
    );

    canvas.drawPath(path, paint);

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.7),
      10,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.3),
      10,
      dotPaint,
    );

    final carPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final carPath = Path();
    carPath.addOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.35),
        width: 24,
        height: 16,
      ),
    );
    canvas.drawPath(carPath, carPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
