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
            'At Livana, we understand that in the modern world, technology is often driven by money.\n'
            'While money is important, it should not be the only motivation.\n'
            'We deliberately chosen to focus our energy to build things that truly matter.\n'
            'Our aim is to create product and service that have a meaningful and\n'
            'positive impact for both people\'s live and the society.\n'
            'We believe that value is created from good deed and we are already rewarded for doing it.\n',
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
