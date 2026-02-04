class Product {
  final String title;
  final String description;
  final String imagePath;
  final String? url;
  final String? iosUrl;
  final String? androidUrl;
  final String? privacyPolicyUrl;
  final String type;

  const Product({
    required this.title,
    required this.description,
    required this.imagePath,
    this.url,
    this.iosUrl,
    this.androidUrl,
    this.privacyPolicyUrl,
    required this.type,
  });
}
