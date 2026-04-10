import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final int pageIndex;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final List<Map<String, dynamic>> pageConfig = [
      {
        'iconBg': isDark ? const Color(0xFF1B5E20) : const Color(0xFFE8F5E9),
        'accent': colorScheme.primary,
        'decoColor': colorScheme.primary.withValues(alpha: 0.1),
      },
      {
        'iconBg': isDark ? const Color(0xFF01579B) : const Color(0xFFE3F2FD),
        'accent': colorScheme.secondary,
        'decoColor': colorScheme.secondary.withValues(alpha: 0.1),
      },
      {
        'iconBg': isDark ? const Color(0xFFE65100) : const Color(0xFFFFF3E0),
        'accent': const Color(0xFFFF9800),
        'decoColor': const Color(0xFFFF9800).withValues(alpha: 0.1),
      },
    ];

    final config = pageConfig[pageIndex];
    final iconBgColor = config['iconBg'] as Color;
    final accentColor = config['accent'] as Color;
    final decoColor = config['decoColor'] as Color;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0D1117) : Colors.white,
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -80,
            child:
                Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [decoColor, decoColor.withValues(alpha: 0)],
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 1000.ms)
                    .scale(begin: const Offset(0.5, 0.5)),
          ),
          Positioned(
            top: 100,
            left: -40,
            child:
                Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accentColor.withValues(alpha: 0.05),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 800.ms)
                    .scale(begin: const Offset(0.3, 0.3)),
          ),
          Positioned(
            bottom: 80,
            right: -20,
            child:
                Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accentColor.withValues(alpha: 0.08),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 500.ms, duration: 600.ms)
                    .scale(begin: const Offset(0.2, 0.2)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: iconBgColor,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withValues(alpha: 0.2),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                color: accentColor.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: accentColor.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Icon(item.icon, size: 56, color: accentColor),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 700.ms, curve: Curves.easeOut)
                      .scale(
                        begin: const Offset(0.6, 0.6),
                        curve: Curves.elasticOut,
                      )
                      .shimmer(
                        delay: 1200.ms,
                        duration: 1500.ms,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: index == pageIndex ? 32 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index == pageIndex
                              ? accentColor
                              : accentColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                  const SizedBox(height: 32),
                  Text(
                        item.title,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF1E293B),
                            ),
                        textAlign: TextAlign.center,
                      )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 500.ms)
                      .slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 16),
                  Text(
                        item.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 500.ms)
                      .slideY(begin: 0.3, end: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
