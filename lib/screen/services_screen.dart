import 'package:flutter/material.dart';

import '../main.dart'; // For colors

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      // In case content overflows on small screens
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Our Services',
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 36 : 48,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Livana is a full-service software company that helps'
            'companies to face the challenge in their digital '
            'transformation journey. Our expertise is in working directly '
            'with our client as an extension of their team to support rapid '
            'growth and help bring projects to life.',
            style: textTheme.titleLarge?.copyWith(
              fontSize: isSmallScreen ? 16 : 18,
              height: 1.6,
              color: kTextColor.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 40),
          _ServiceExpansionTile(
            title: 'Software delivery',
            children: [
              'Web',
              'Mobile',
              'Backend systems',
              'Game',
            ],
          ),
          _ServiceExpansionTile(
            title: 'Team augmentation',
            children: ['Tech-lead', 'Fullstack engineer', 'QA', 'UX/UI'],
          ),
          _ServiceExpansionTile(
            title: 'Consultant',
            children: ['Training', 'Adhoc support', 'On demand session'],
          ),
        ],
      ),
    );
  }
}

class _ServiceExpansionTile extends StatelessWidget {
  final String title;
  final List<String> children;

  const _ServiceExpansionTile({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Override expansion tile icon color
      data: Theme.of(context).copyWith(
          unselectedWidgetColor:
              kTextColor.withOpacity(0.7), // Icon color when collapsed
          colorScheme: ColorScheme.dark(
              primary: kTextColor.withOpacity(0.7)) // Icon color when expanded
          ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(vertical: 8.0),
        title: Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        collapsedIconColor: kTextColor,
        iconColor: kTextColor,
        shape: const Border(
            bottom: BorderSide(
                color: Colors.transparent)), // Remove default bottom border
        collapsedShape:
            const Border(bottom: BorderSide(color: Colors.transparent)),
        children: children
            .map((item) => ListTile(
                  contentPadding: const EdgeInsets.only(
                      left: 24, top: 0, bottom: 0, right: 16),
                  title: Text('• $item',
                      style: TextStyle(
                          fontSize: 16, color: kTextColor.withOpacity(0.8))),
                ))
            .toList(),
      ),
    );
  }
}
