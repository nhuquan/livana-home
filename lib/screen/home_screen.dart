import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livana/l10n/app_localizations.dart';

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
              AppLocalizations.of(context)!.homeSlogan,
              style: textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: isSmallScreen ? 36 : 48,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.homeValues,
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
                   SnackBar(
                      content: Text(AppLocalizations.of(context)!.contactNumberSnackBar)),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.chatWithUs,
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
