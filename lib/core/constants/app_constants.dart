import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Trip Splitter';

  static const List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Plan Your Trip',
      description:
          'Enter your starting point and destination to calculate the perfect route for your journey.',
      icon: Icons.add_road_rounded,
    ),
    OnboardingItem(
      title: 'Track Expenses',
      description:
          'Add fuel costs, toll fees, food expenses, and any other trip-related costs easily.',
      icon: Icons.receipt_long_rounded,
    ),
    OnboardingItem(
      title: 'Share & Export',
      description:
          'Share your trip details on WhatsApp or export as PDF to keep a record of your expenses.',
      icon: Icons.ios_share_rounded,
    ),
  ];
}

class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}
