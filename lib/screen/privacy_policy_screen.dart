import 'package:flutter/material.dart';
import 'package:livana/model/product.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final Product product;

  const PrivacyPolicyScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy for ${product.title}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last Updated: 30 December 2025',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to ${product.title}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'At LIVANA COMPANY LIMITED, we take your privacy seriously. This privacy policy outlines how we collect, use, and protect your personal information when you use ${product.title}.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              '1. Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Since ${product.title} is an advice generator app, we do not collect any personal data or information from you.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '2. Data Usage',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "As mentioned above, we do not collect or store any personal data. Since the app doesn't have any input field to collect data from user, meaning all your data remain on your device, and no information is transmitted to us or any third-party service.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '3. Third-Party Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${product.title} does not use any third-party services, analytics, or advertising networks that would collect data from your device.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '4. Security',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Since ${product.title} does not collect any personal data, there is no risk of your personal information being compromised. Your device is responsible for ensuring the security of your stored data.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '5. Changes to This Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We may update our privacy policy from time to time. Any changes will be reflected in this document. It is recommended that you check this page periodically for any updates. If we make significant changes to this policy, we will notify you in the app.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '6. Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'If you have any questions or concerns about this privacy policy, feel free to contact us at:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Email: daniel@livana.dev \nAddress: Thôn 4, Xã Thi Sơn, Huyện Kim Bảng, Tỉnh Hà Nam, Việt Nam',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              'By using ${product.title}, you agree to this privacy policy and the terms outlined here.',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
