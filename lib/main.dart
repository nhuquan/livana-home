import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livana/pages/landing_page.dart';
import 'package:livana/pages/onboarding_page.dart';
import 'package:livana/pages/product_listing_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => LandingPage(),
        '/onboarding': (context) => OnboardingPage(),
        '/products': (context) => ProductListingPage(),
      },
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}
