import 'package:flutter/material.dart';
import 'package:livana/data/products.dart';
import 'package:livana/l10n/app_localizations.dart';
import 'package:livana/model/product.dart';

class OurWorkScreen extends StatefulWidget {
  const OurWorkScreen({super.key});

  @override
  State<OurWorkScreen> createState() => _OurWorkScreenState();
}

class _OurWorkScreenState extends State<OurWorkScreen> {
  String _selectedCategory = 'app'; // 'app' or 'game'

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool isSmallScreen = MediaQuery.of(context).size.width < 768;

    final filteredItems =
        allProducts.where((item) => item.type == _selectedCategory).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Push CTA to bottom
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 2,
          // Allows the work items grid/row to take available space
          child: SingleChildScrollView(
            // In case there are many items
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isSmallScreen)
                  Text(
                    // Title only on small screens above cards
                    AppLocalizations.of(context)!.ourWork,
                    style: textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 36 : 48,
                    ),
                  ),
                if (isSmallScreen) const SizedBox(height: 30),

                // Tab Selection Logic
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTabButton(
                          context, AppLocalizations.of(context)!.apps, 'app'),
                      const SizedBox(width: 20),
                      _buildTabButton(
                          context, AppLocalizations.of(context)!.games, 'game'),
                    ],
                  ),
                ),

                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount;
                    double childAspectRatio;

                    if (constraints.maxWidth < 600) {
                      crossAxisCount = 2; // Mobile
                      childAspectRatio =
                          0.65; // Taller cards for mobile to avoid overflow
                    } else if (constraints.maxWidth < 1200) {
                      crossAxisCount = 4; // Tablet
                      childAspectRatio = 0.70;
                    } else {
                      crossAxisCount = 6; // Big screen
                      childAspectRatio = 0.75;
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return _WorkItemCard(
                          product: item,
                          isSmall: constraints.maxWidth < 600,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)!.letsBuildSomething,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 18 : 32,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 10 : 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                  child: Text(AppLocalizations.of(context)!.contactUsButton),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(BuildContext context, String title, String key) {
    final bool isSelected = _selectedCategory == key;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDarkMode ? Colors.white : Colors.black;
    final inactiveColor = Colors.grey;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = key;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 2,
              width: 30, // Fixed width underline
              color: activeColor,
            )
          else
            Container(
              height: 2,
              width: 30, // Fixed width underline
              color: Colors.transparent,
            ),
        ],
      ),
    );
  }
}

class _WorkItemCard extends StatelessWidget {
  final Product product;
  final bool isSmall;

  const _WorkItemCard({
    required this.product,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900], // Placeholder color
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/products/${product.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5, // Give image slightly more space
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: Colors.grey[800],
                    alignment: Alignment.center,
                    child: Icon(Icons.image_outlined,
                        size: 50, color: Colors.grey[600]),
                  ),
                  Image.asset(product.imagePath, fit: BoxFit.cover),
                ],
              ),
            ),
            Expanded(
                flex: 4, // More text space
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey[900]!, Colors.grey[850]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Top align text
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmall
                              ? 15
                              : 18, // Slightly smaller text on mobile
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2, // Allow title to wrap
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Flexible(
                        // Use Flexible instead of fixed height/text constraints
                        child: Text(
                          product.description,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: isSmall ? 11 : 12,
                          ),
                          maxLines: 4, // Allow more lines for description
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
