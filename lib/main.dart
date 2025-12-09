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
  runApp(ThemeSwitcherWidget());
}

final supabase = Supabase.instance.client;

// Define your accent color
const Color kAccentColor = Color(0xFFFFA500); // Example orange
// Light Theme Colors
const Color kLightBackgroundColor = Colors.white;
const Color kLightTextColor = Colors.black;
const Color kLightButtonBackgroundColor = Colors.black;
const Color kLightButtonTextColor = Colors.white;

// Dark Theme Colors
const Color kDarkBackgroundColor = Colors.black;
const Color kDarkTextColor = Colors.white;
const Color kDarkButtonBackgroundColor = Colors.white;
const Color kDarkButtonTextColor = Colors.black;

const Color kFormFieldBackgroundColor =
Color(0xFFF0F0F0); // Light grey for form fields
const Color kFormFieldTextColor = Colors.black;
const Color kButtonBackgroundColor = Colors.white;
const Color kButtonTextColor = Colors.black;

class ThemeSwitcherWidget extends StatefulWidget {
  const ThemeSwitcherWidget({super.key});

  @override
  _ThemeSwitcherWidgetState createState() => _ThemeSwitcherWidgetState();
}

class _ThemeSwitcherWidgetState extends State<ThemeSwitcherWidget> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyApp(
      themeMode: _themeMode,
      toggleTheme: _toggleTheme,
    );
  }
}


class MyApp extends StatelessWidget {
  final ThemeMode themeMode;
  final VoidCallback toggleTheme;

  const MyApp({super.key, required this.themeMode, required this.toggleTheme});


  @override
  Widget build(BuildContext context) {

    final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: kAccentColor,
      scaffoldBackgroundColor: kLightBackgroundColor,
      textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme).apply(
        bodyColor: kLightTextColor,
        displayColor: kLightTextColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: kLightTextColor,
            textStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kLightButtonBackgroundColor,
          foregroundColor: kLightButtonTextColor,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
      ),
      dividerColor: Colors.grey[300],
      appBarTheme: AppBarTheme(
        color: kLightBackgroundColor,
        iconTheme: IconThemeData(color: kLightTextColor),
      ),
    );

    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: kAccentColor,
      scaffoldBackgroundColor: kDarkBackgroundColor,
      textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme).apply(
        bodyColor: kDarkTextColor,
        displayColor: kDarkTextColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: kDarkTextColor,
            textStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkButtonBackgroundColor,
          foregroundColor: kDarkButtonTextColor,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
      ),
      dividerColor: Colors.grey[800],
      appBarTheme: AppBarTheme(
        color: kDarkBackgroundColor,
        iconTheme: IconThemeData(color: kDarkTextColor),
      ),
    );


    return MaterialApp(
      title: 'Livana Software',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreenScaffold(
            body: HomeScreen(), currentRoute: '/', toggleTheme: toggleTheme),
        '/services': (context) => MainScreenScaffold(
            body: ServicesScreen(),
            currentRoute: '/services',
            toggleTheme: toggleTheme),
        '/product': (context) => MainScreenScaffold(
            body: OurWorkScreen(),
            currentRoute: '/product',
            toggleTheme: toggleTheme),
        '/contact': (context) => MainScreenScaffold(
            body: ContactFormScreen(),
            currentRoute: '/contact',
            toggleTheme: toggleTheme),
      },
    );
  }
}

class MainScreenScaffold extends StatelessWidget {
  final Widget body;
  final String currentRoute;
  final VoidCallback toggleTheme;
  const MainScreenScaffold(
      {super.key,
        required this.body,
        required this.currentRoute,
        required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:
    ResponsiveAppBar(currentRoute: currentRoute, toggleTheme: toggleTheme),
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
  final VoidCallback toggleTheme;

  const ResponsiveAppBar(
      {super.key, required this.currentRoute, required this.toggleTheme});

  Widget _navItem(BuildContext context, String title, String routeName) {
    final bool isActive = currentRoute == routeName;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

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
            color: textColor,
            decoration:
                isActive ? TextDecoration.underline : TextDecoration.none,
            decorationColor: textColor,
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
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;
      final borderColor = isDarkMode ? Colors.white : Colors.black;
      final textColor = isDarkMode ? Colors.white : Colors.black;

      return AppBar(
        automaticallyImplyLeading:
            false, //remove back button if pages are pushed
        elevation: 0,
        titleSpacing: isDesktop ? 40 : 20,
        title: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: Text('Livana',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor)),
        ),
        actions: <Widget>[
          if (isDesktop) ...[
            _navItem(context, 'Home', '/'),
            _navItem(context, 'Our Services', '/services'),
            _navItem(context, 'Our Work', '/product'),
            _navItem(context, 'Work With Us', '/contact'),
          ],
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: toggleTheme,
          ),
          if (!isDesktop)
            IconButton(
                onPressed: () {
                  _showFullScreenMenu(context);
                },
                icon: Icon(
                  Icons.menu,
                  size: 30,
                )),
          SizedBox(width: isDesktop ? 40 : 20),
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDarkMode ? kDarkTextColor.withOpacity(0.7) : kLightTextColor.withOpacity(0.7);

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
            color: isActive ? activeColor : kAccentColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? kDarkBackgroundColor.withOpacity(0.98) : kLightBackgroundColor.withOpacity(0.98);

    return Scaffold(
      backgroundColor: backgroundColor,
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
