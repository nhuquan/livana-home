import 'package:flutter/material.dart';
import 'package:livana/model/product.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _langTabController;
  final PageController _screenshotController = PageController();
  int _currentScreenshot = 0;

  @override
  void initState() {
    super.initState();
    _langTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _langTabController.dispose();
    _screenshotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // ── App bar with gradient ──────────────────────────────────────
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 900) {
                  return _buildWideLayout(context);
                } else {
                  return _buildNarrowLayout(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
                      : [const Color(0xFFF0F4FF), const Color(0xFFE8ECFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Hero image
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
              child: Image.asset(
                widget.product.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                    Icons.image_outlined,
                    size: 80,
                    color: Colors.white30),
              ),
            ),
            // Bottom fade
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      title: Text(
        widget.product.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: screenshots
          Expanded(
            flex: 5,
            child: _ScreenshotCarousel(
              screenshots: widget.product.screenshots,
              controller: _screenshotController,
              currentIndex: _currentScreenshot,
              onPageChanged: (i) => setState(() => _currentScreenshot = i),
            ),
          ),
          const SizedBox(width: 48),
          // Right: details
          Expanded(
            flex: 5,
            child: _DetailsPanel(product: widget.product),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ScreenshotCarousel(
            screenshots: widget.product.screenshots,
            controller: _screenshotController,
            currentIndex: _currentScreenshot,
            onPageChanged: (i) => setState(() => _currentScreenshot = i),
          ),
          const SizedBox(height: 32),
          _DetailsPanel(product: widget.product),
        ],
      ),
    );
  }
}

// ─── Screenshot carousel ──────────────────────────────────────────────────────

class _ScreenshotCarousel extends StatelessWidget {
  final List<String> screenshots;
  final PageController controller;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const _ScreenshotCarousel({
    required this.screenshots,
    required this.controller,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasScreenshots = screenshots.isNotEmpty;

    return Column(
      children: [
        // ── Main carousel ──────────────────────────────────────────────
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: !hasScreenshots
                ? _PlaceholderSlide(isDark: isDark)
                : PageView.builder(
                    controller: controller,
                    onPageChanged: onPageChanged,
                    itemCount: screenshots.length,
                    itemBuilder: (context, index) => _ScreenshotSlide(
                      path: screenshots[index],
                      isDark: isDark,
                    ),
                  ),
          ),
        ),

        if (hasScreenshots && screenshots.length > 1) ...[
          const SizedBox(height: 16),
          // ── Dot indicators ─────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(screenshots.length, (i) {
              final active = i == currentIndex;
              return GestureDetector(
                onTap: () => controller.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          // ── Thumbnail strip ────────────────────────────────────────────
          SizedBox(
            height: 64,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: screenshots.length,
              itemBuilder: (context, i) {
                final active = i == currentIndex;
                return GestureDetector(
                  onTap: () => controller.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: active
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: _ScreenshotSlide(
                            path: screenshots[i], isDark: isDark),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _ScreenshotSlide extends StatelessWidget {
  final String path;
  final bool isDark;

  const _ScreenshotSlide({required this.path, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _PlaceholderSlide(isDark: isDark),
    );
  }
}

class _PlaceholderSlide extends StatelessWidget {
  final bool isDark;

  const _PlaceholderSlide({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E1B4B), const Color(0xFF0F172A)]
              : [const Color(0xFFEEF2FF), const Color(0xFFE0E7FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.screenshot_monitor_rounded,
              size: 56,
              color: isDark ? Colors.white24 : Colors.black12),
          const SizedBox(height: 12),
          Text(
            'Screenshots coming soon',
            style: TextStyle(
              color: isDark ? Colors.white38 : Colors.black26,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Details panel ────────────────────────────────────────────────────────────

class _DetailsPanel extends StatefulWidget {
  final Product product;

  const _DetailsPanel({required this.product});

  @override
  State<_DetailsPanel> createState() => _DetailsPanelState();
}

class _DetailsPanelState extends State<_DetailsPanel>
    with SingleTickerProviderStateMixin {
  late TabController _langTab;

  @override
  void initState() {
    super.initState();
    final hasVi = widget.product.descriptionVi != null;
    _langTab = TabController(length: hasVi ? 2 : 1, vsync: this);
  }

  @override
  void dispose() {
    _langTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = widget.product;
    final hasVi = product.descriptionVi != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Title ─────────────────────────────────────────────────────────
        Text(
          product.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),

        // ── Type chip ─────────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF).withOpacity(0.12),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            product.type == 'game' ? '🎮 Game' : '📱 App',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6C63FF),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // ── Language tabs ─────────────────────────────────────────────────
        if (hasVi) ...[
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(4),
            child: TabBar(
              controller: _langTab,
              indicator: BoxDecoration(
                color: isDark ? const Color(0xFF6C63FF) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: isDark ? Colors.white : const Color(0xFF6C63FF),
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: '🇬🇧  English'),
                Tab(text: '🇻🇳  Tiếng Việt'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: TabBarView(
              controller: _langTab,
              children: [
                _DescriptionText(text: product.description, isDark: isDark),
                _DescriptionText(text: product.descriptionVi!, isDark: isDark),
              ],
            ),
          ),
        ] else ...[
          _DescriptionText(text: product.description, isDark: isDark),
          const SizedBox(height: 16),
        ],

        const SizedBox(height: 28),
        Divider(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.07)),
        const SizedBox(height: 24),

        // ── Store buttons ─────────────────────────────────────────────────
        const Text(
          'Download',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (product.iosUrl != null)
              _StoreButton(
                icon: Icons.apple,
                title: 'App Store',
                subtitle: 'Available on',
                url: product.iosUrl!,
                color: const Color(0xFF007AFF),
              ),
            if (product.androidUrl != null)
              _StoreButton(
                icon: Icons.android,
                title: 'Google Play',
                subtitle: 'Get it on',
                url: product.androidUrl!,
                color: const Color(0xFF34A853),
              ),
            if (product.url != null)
              _StoreButton(
                icon: Icons.language_rounded,
                title: 'Web App',
                subtitle: 'Open in browser',
                url: product.url!,
                color: const Color(0xFF6C63FF),
              ),
          ],
        ),

        const SizedBox(height: 24),
        // ── Privacy policy ────────────────────────────────────────────────
        TextButton.icon(
          onPressed: () =>
              Navigator.pushNamed(context, '/products/${product.id}/privacy'),
          icon: const Icon(Icons.shield_outlined, size: 16),
          label: const Text('Privacy Policy'),
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
        ),
      ],
    );
  }
}

class _DescriptionText extends StatelessWidget {
  final String text;
  final bool isDark;

  const _DescriptionText({required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        height: 1.7,
        color: isDark ? Colors.grey[300] : Colors.grey[700],
      ),
    );
  }
}

class _StoreButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String url;
  final Color color;

  const _StoreButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.color,
  });

  @override
  State<_StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<_StoreButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color
                : (isDark
                    ? widget.color.withOpacity(0.12)
                    : widget.color.withOpacity(0.08)),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovered
                  ? widget.color
                  : widget.color.withOpacity(0.25),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _hovered ? Colors.white : widget.color,
                size: 28,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: _hovered
                          ? Colors.white70
                          : widget.color.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: _hovered ? Colors.white : widget.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
