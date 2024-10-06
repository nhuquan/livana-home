import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livana/pages/landing_page.dart';
import 'package:livana/pages/onboarding_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));

  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => LandingPage(),
        '/onboarding': (context) => OnboardingPage(),
      },
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}
