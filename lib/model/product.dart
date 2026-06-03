class Product {
  final String id;
  final String title;
  final String description;
  final String? descriptionVi;
  final String imagePath;
  final String? url;
  final String? iosUrl;
  final String? androidUrl;
  final String? privacyPolicyUrl;
  final String type;
  final List<String> screenshots;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    this.descriptionVi,
    required this.imagePath,
    this.url,
    this.iosUrl,
    this.androidUrl,
    this.privacyPolicyUrl,
    required this.type,
    this.screenshots = const [],
  });
}
