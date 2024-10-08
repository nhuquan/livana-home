import 'package:flutter/material.dart';
import 'package:livana/widgets/app_bar.dart';
import 'package:livana/widgets/drawer.dart';

class ProductListingPage extends StatelessWidget {
  ProductListingPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: MyAppBar(scaffoldKey: _scaffoldKey),
        drawer: isLargeScreen ? null : MyDrawer(scaffoldKey: _scaffoldKey),
        body: const Center(child: Text("product listing page")),
      ),
    );
  }
}
