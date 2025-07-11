import 'package:flutter/material.dart';

import '../main.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: <Widget>[
          Text(
            'Where innovation serves humanity.',
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 36 : 48,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Ở hiền gặp lành - One good turn deserves another\n\n'
            'At Livana, we understand that in the modern world, technology is often driven by money. '
            'While money is important, it should not be the only motivation.\n'
            'Hence, we have deliberately chosen to focus our time and energy on building things that truly matter. '
            'Our aim is to create products and services that have a meaningful and '
            'positive impact on both people\'s lives and the society.\n'
            'We believe that real value is created from good deeds and we are rewarded enough simply by doing them.\n',
            style: textTheme.titleLarge?.copyWith(
              fontSize: isSmallScreen ? 16 : 18,
              height: 1.6,
              color: kTextColor.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('SMS / Zalo / Whatsapp: (+84) 981-682-904')),
              );
            },
            child: const Text('Chat with us'),
          ),
        ],
      ),
    );
  }
}
