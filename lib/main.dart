import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livana/screen/contact_screen.dart';
import 'package:livana/screen/home_screen.dart';
import 'package:livana/screen/product_screen.dart';
import 'package:livana/screen/services_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String supabaseUrl =
    'https://xykmitvmzjofzdvmhnui.supabase.co'; // Replace with your actual Supabase URL
const String supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh5a21pdHZtempvZnpkdm1obnVpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk5NDIyNDUsImV4cCI6MjA2NTUxODI0NX0.Zl_xOpW7bJa6xutd6pr3YX0-Jac01TUqtKJWQvyqJZs'; // Replace with your actual

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Required for Supabase init before runApp
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

// Define your accent color
const Color kAccentColor = Color(0xFFFFA500); // Example orange
const Color kBackgroundColor = Colors.black;
const Color kTextColor = Colors.white;
const Color kButtonBackgroundColor = Colors.white;
const Color kButtonTextColor = Colors.black;
const Color kFormFieldBackgroundColor =
    Color(0xFFF0F0F0); // Light grey for form fields
const Color kFormFieldTextColor = Colors.black;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livana',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kAccentColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme:
            GoogleFonts.outfitTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: kTextColor,
          displayColor: kTextColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: kButtonTextColor,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kButtonBackgroundColor,
            foregroundColor: kButtonTextColor,
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
        ),
        dividerColor: Colors.grey[800],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            MainScreenScaffold(body: HomeScreen(), currentRoute: '/'),
        '/services': (context) => MainScreenScaffold(
            body: ServicesScreen(), currentRoute: '/services'),
        '/product': (context) =>
            MainScreenScaffold(body: OurWorkScreen(), currentRoute: '/product'),
        '/contact': (context) => MainScreenScaffold(
            body: ContactFormScreen(), currentRoute: '/contact'),
      },
    );
  }
}

class MainScreenScaffold extends StatelessWidget {
  final Widget body;
  final String currentRoute;

  const MainScreenScaffold(
      {super.key, required this.body, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(currentRoute: currentRoute),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 2000),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: body,
          ),
        ),
      ),
    );
  }
}

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentRoute;

  const ResponsiveAppBar({super.key, required this.currentRoute});

  Widget _navItem(BuildContext context, String title, String routeName) {
    final bool isActive = currentRoute == routeName;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () {
          if (!isActive) {
            Navigator.pushNamed(context, routeName);
          }
        },
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: kTextColor,
            decoration:
                isActive ? TextDecoration.underline : TextDecoration.none,
            decorationColor: kTextColor,
            decorationThickness: 1.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isDesktop = constraints.maxWidth > 768;

      return AppBar(
        automaticallyImplyLeading:
            false, //remove back button if pages are pushed
        backgroundColor: kBackgroundColor,
        elevation: 0,
        titleSpacing: isDesktop ? 40 : 20,
        title: Text(
          'Livana',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: kTextColor),
        ),
        actions: isDesktop
            ? <Widget>[
                _navItem(context, 'Home', '/'),
                _navItem(context, 'Our Services', '/services'),
                _navItem(context, 'Our Work', '/product'),
                _navItem(context, 'Work With Us', '/contact'),
                SizedBox(
                  width: 40,
                )
              ]
            : <Widget>[
                IconButton(
                    onPressed: () {
                      _showFullScreenMenu(context);
                    },
                    icon: Icon(
                      Icons.menu,
                      color: kTextColor,
                      size: 30,
                    )),
                SizedBox(width: 20),
              ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  void _showFullScreenMenu(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return FullScreenMenu(
            currentRoute: currentRoute,
          );
        },
        opaque: false,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }));
  }
}

class FullScreenMenu extends StatelessWidget {
  final String currentRoute;
  const FullScreenMenu({super.key, required this.currentRoute});

  Widget _menuLink(BuildContext context, String title, String routeName) {
    final bool isActive = currentRoute == routeName;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: TextButton(
        onPressed: () {
          Navigator.pop(context); // Close the menu
          if (!isActive) Navigator.pushNamed(context, routeName);
        },
        child: Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isActive ? kTextColor.withOpacity(0.7) : kAccentColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          kBackgroundColor.withOpacity(0.98), // Slightly transparent black
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: kAccentColor, size: 35),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _menuLink(context, 'Home', '/'),
            _menuLink(context, 'Our Services', '/services'),
            _menuLink(context, 'Our Work', '/product'),
            _menuLink(context, 'Work With Us', '/contact'),
          ],
        ),
      ),
    );
  }
}
