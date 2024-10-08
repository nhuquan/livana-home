import 'package:flutter/material.dart';
import 'package:livana/pages/landing_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: menuItems
            .map((item) => ListTile(
                  onTap: () {
                    scaffoldKey.currentState?.openEndDrawer();
                    if (item == 'Products') {
                      Navigator.of(context).pushNamed('/products');
                    }
                    if (item == 'Home') {
                      Navigator.of(context).pushNamed('/home');
                    }
                  },
                  title: Text(item),
                ))
            .toList(),
      ),
    );
  }
}
