import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    final double horizontalPadding = isSmallScreen ? 24.0 : 48.0;
    final double verticalPadding = isSmallScreen ? 32.0 : 64.0;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
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
              'The Buddha taught that real success comes from earning your living honestly, peacefully, and without harming others.\n\n'
              'At Livana Software, we understand that in the modern world, technology is often driven by money. '
              'While money is important, it should not be the only motivation. '
              'Hence, we have deliberately chosen to focus our time and energy on building things that truly matter. '
              'Our aim is to create products and services that have a meaningful and '
              'positive impact on both people\'s lives and the society. '
              'We believe that real value is created from good deeds and we are rewarded enough simply by doing them.',
              style: GoogleFonts.inter(
                fontSize: isSmallScreen ? 16 : 18,
                height: 1.7,
                fontWeight: FontWeight.w400,
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
              child: Text(
                'Chat with us',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
            ),
          ],
        ),
      ),
    );
  }
}
