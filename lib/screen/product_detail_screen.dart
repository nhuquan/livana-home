import 'package:flutter/material.dart';
import 'package:livana/model/product.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(product.imagePath),
            const SizedBox(height: 16.0),
            Text(
              product.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24.0),
            _buildLinkButton(
              context,
              'Web Version',
              product.url,
            ),
            _buildLinkButton(
              context,
              'iOS App',
              product.iosUrl,
            ),
            _buildLinkButton(
              context,
              'Android App',
              product.androidUrl,
            ),
            _buildLinkButton(
              context,
              'Privacy Policy',
              product.privacyPolicyUrl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkButton(BuildContext context, String title, String? url) {
    if (url == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () async {
          if (!await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.externalApplication,
          )) {
            throw Exception('Could not launch $url');
          }
        },
        child: Text(title),
      ),
    );
  }
}
