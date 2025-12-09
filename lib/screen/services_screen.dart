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
      child: Container(
        padding: EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          // color: kBackgroundColor,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]
        ),
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
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(vertical: 8.0),
      title: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                        fontSize: 16, )),
              ))
          .toList(),
    );
  }
}
