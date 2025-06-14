import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OurWorkScreen extends StatelessWidget {
  const OurWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool isSmallScreen = MediaQuery.of(context).size.width < 768;

    // Sample data for work items
    final workItems = [
      {
        'title': 'DailyWisdom',
        'imagePath': 'assets/images/dailyWisdom.png',
        'url':
            'https://play.google.com/store/apps/details?id=dev.livana.dailywisdom'
      },
      {
        'title': 'SoundGround',
        'imagePath': 'assets/images/soundGround.png',
        'url':
            'https://play.google.com/store/apps/details?id=dev.livana.soundground',
      },
      {
        'title': 'Flappy',
        'imagePath': 'assets/images/flappy.png',
        'url': 'https://flappy.livana.dev/',
      },
      {
        'title': 'StarHunter',
        'imagePath': 'assets/images/starHunter.png',
        'url': 'https://nhuquan.github.io/starHunter/',
      },
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Push CTA to bottom
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          // Allows the work items grid/row to take available space
          child: SingleChildScrollView(
            // In case there are many items
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isSmallScreen)
                  Text(
                    // Title only on small screens above cards
                    'Our Work',
                    style: textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 36 : 48,
                    ),
                  ),
                if (isSmallScreen) const SizedBox(height: 30),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 600) {
                      // Mobile: Vertical list
                      return Column(
                        children: workItems
                            .map((item) => _WorkItemCard(
                                  title: item['title']!,
                                  imagePath: item['imagePath']!,
                                  url: item['url']!,
                                  isSmall: true,
                                ))
                            .toList(),
                      );
                    } else {
                      // Desktop: Row of cards
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: workItems
                            .map((item) => Expanded(
                                  child: _WorkItemCard(
                                      title: item['title']!,
                                      imagePath: item['imagePath']!,
                                      url: item['url']!),
                                ))
                            .toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Let\'s build something beautiful.',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 24 : 32,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                  child: const Text('Contact Us'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WorkItemCard extends StatelessWidget {
  final String title;
  final String url;
  final String
      imagePath; // You'll need to add placeholder images to your assets
  final bool isSmall;

  const _WorkItemCard(
      {required this.title,
      required this.imagePath,
      this.isSmall = false,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: isSmall ? 16 / 12 : 3 / 4, // Adjust aspect ratio as needed
      child: Card(
        color: Colors.grey[900], // Placeholder color
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(isSmall ? 8.0 : 12.0),
        child: InkWell(
          onTap: () async {
            if (!await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            )) {
              throw Exception('Could not launch $url');
            }
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                // Placeholder if no image
                color: Colors.grey[800],
                alignment: Alignment.center,
                child: Icon(Icons.image_outlined,
                    size: 50, color: Colors.grey[600]),
              ),
              // Placeholder for image:
              Image.asset(imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey[900]!, Colors.grey[900]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmall ? 18 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
