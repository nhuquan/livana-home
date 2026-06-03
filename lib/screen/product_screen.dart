import 'package:flutter/material.dart';
import 'package:livana/data/products.dart';
import 'package:livana/l10n/app_localizations.dart';
import 'package:livana/model/product.dart';
import 'package:url_launcher/url_launcher.dart';

class OurWorkScreen extends StatefulWidget {
  const OurWorkScreen({super.key});

  @override
  State<OurWorkScreen> createState() => _OurWorkScreenState();
}

class _OurWorkScreenState extends State<OurWorkScreen>
    with SingleTickerProviderStateMixin {
  String _selectedCategory = 'app';
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _switchCategory(String key) {
    if (_selectedCategory == key) return;
    setState(() => _selectedCategory = key);
    _animController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 768;
    final filteredItems =
        allProducts.where((p) => p.type == _selectedCategory).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          if (isSmallScreen) ...[
            Text(
              AppLocalizations.of(context)!.ourWork,
              style: textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Crafted with care. Built to last.',
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            ),
            const SizedBox(height: 28),
          ],

          // ── Tab bar ──────────────────────────────────────────────────────
          _CategoryTabBar(
            selected: _selectedCategory,
            onSelect: _switchCategory,
            context: context,
          ),
          const SizedBox(height: 32),

          // ── Grid ─────────────────────────────────────────────────────────
          AnimatedBuilder(
            animation: _animController,
            builder: (context, child) => FadeTransition(
              opacity: _animController,
              child: child,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                double childAspectRatio;

                if (constraints.maxWidth < 600) {
                  crossAxisCount = 1;
                  childAspectRatio = 1.55;
                } else if (constraints.maxWidth < 1000) {
                  crossAxisCount = 2;
                  childAspectRatio = 1.2;
                } else if (constraints.maxWidth < 1400) {
                  crossAxisCount = 3;
                  childAspectRatio = 1.15;
                } else {
                  crossAxisCount = 4;
                  childAspectRatio = 1.2;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) => _ProductCard(
                    product: filteredItems[index],
                    index: index,
                  ),
                );
              },
            ),
          ),

          // ── CTA ───────────────────────────────────────────────────────────
          const SizedBox(height: 64),
          _CtaBanner(isSmallScreen: isSmallScreen),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

// ─── Category tab bar ────────────────────────────────────────────────────────

class _CategoryTabBar extends StatelessWidget {
  final String selected;
  final void Function(String) onSelect;
  final BuildContext context;

  const _CategoryTabBar({
    required this.selected,
    required this.onSelect,
    required this.context,
  });

  @override
  Widget build(BuildContext buildContext) {
    final isDark = Theme.of(buildContext).brightness == Brightness.dark;
    return Row(
      children: [
        _TabChip(
          label: AppLocalizations.of(buildContext)!.apps,
          icon: Icons.apps_rounded,
          isSelected: selected == 'app',
          isDark: isDark,
          onTap: () => onSelect('app'),
        ),
        const SizedBox(width: 12),
        _TabChip(
          label: AppLocalizations.of(buildContext)!.games,
          icon: Icons.sports_esports_rounded,
          isSelected: selected == 'game',
          isDark: isDark,
          onTap: () => onSelect('game'),
        ),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _TabChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isDark ? Colors.white : Colors.black;
    final activeBg = isDark ? Colors.white12 : Colors.black.withOpacity(0.07);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color:
                isSelected ? activeColor.withOpacity(0.3) : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: isSelected ? activeColor : Colors.grey),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? activeColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Product card ─────────────────────────────────────────────────────────────

// Subtle per-card accent colours (cycles through the list)
const _cardAccents = [
  Color(0xFF6C63FF), // violet
  Color(0xFF00B4D8), // sky
  Color(0xFF06D6A0), // mint
  Color(0xFFFF6B6B), // coral
  Color(0xFFFFB703), // amber
  Color(0xFFE040FB), // purple
  Color(0xFF4CC9F0), // cyan
  Color(0xFFFF9F1C), // orange
];

class _ProductCard extends StatefulWidget {
  final Product product;
  final int index;

  const _ProductCard({required this.product, required this.index});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _hovered = false;

  Color get _accent => _cardAccents[widget.index % _cardAccents.length];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1A1A2E) : Colors.white;
    final borderColor = _hovered
        ? _accent.withOpacity(0.7)
        : (isDark ? Colors.white10 : Colors.black.withOpacity(0.08));

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, '/products/${widget.product.id}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: _accent.withOpacity(0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Image ──────────────────────────────────────────────────
                _CardImage(product: widget.product, accent: _accent),

                // ── Text body ──────────────────────────────────────────────
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title + accent dot
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _accent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.product.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // description (EN)
                        Expanded(
                          child: Text(
                            widget.product.description,
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.5,
                              color:
                                  isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // ── Store badges ────────────────────────────────────
                        _StoreBadgeRow(product: widget.product),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Product product;
  final Color accent;

  const _CardImage({required this.product, required this.accent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient backdrop
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent.withOpacity(0.25),
                  accent.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Product image
          Image.asset(
            product.imagePath,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Center(
              child: Icon(Icons.image_outlined,
                  size: 48, color: accent.withOpacity(0.4)),
            ),
          ),
          // Subtle bottom fade
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1A1A2E).withOpacity(0.8)
                        : Colors.white.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreBadgeRow extends StatelessWidget {
  final Product product;

  const _StoreBadgeRow({required this.product});

  @override
  Widget build(BuildContext context) {
    final hasIos = product.iosUrl != null;
    final hasAndroid = product.androidUrl != null;
    if (!hasIos && !hasAndroid) return const SizedBox.shrink();

    return Row(
      children: [
        if (hasIos) ...[
          _StoreBadge(
            icon: Icons.apple,
            label: 'App Store',
            url: product.iosUrl!,
            color: const Color(0xFF007AFF),
          ),
          if (hasAndroid) const SizedBox(width: 8),
        ],
        if (hasAndroid)
          _StoreBadge(
            icon: Icons.android,
            label: 'Google Play',
            url: product.androidUrl!,
            color: const Color(0xFF34A853),
          ),
      ],
    );
  }
}

class _StoreBadge extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color color;

  const _StoreBadge({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
  });

  @override
  State<_StoreBadge> createState() => _StoreBadgeState();
}

class _StoreBadgeState extends State<_StoreBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withOpacity(0.15)
                : widget.color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.color.withOpacity(_hovered ? 0.5 : 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 13, color: widget.color),
              const SizedBox(width: 4),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── CTA banner ──────────────────────────────────────────────────────────────

class _CtaBanner extends StatelessWidget {
  final bool isSmallScreen;

  const _CtaBanner({required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 24 : 48,
        vertical: isSmallScreen ? 32 : 48,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E1B4B), const Color(0xFF0F172A)]
              : [const Color(0xFFF0F4FF), const Color(0xFFEEF2FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.07)
              : const Color(0xFF6C63FF).withOpacity(0.15),
        ),
      ),
      child: isSmallScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CtaContent(textTheme: textTheme, isDark: isDark),
                const SizedBox(height: 20),
                _CtaButton(context: context),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _CtaContent(textTheme: textTheme, isDark: isDark),
                ),
                _CtaButton(context: context),
              ],
            ),
    );
  }
}

class _CtaContent extends StatelessWidget {
  final TextTheme textTheme;
  final bool isDark;

  const _CtaContent({required this.textTheme, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.letsBuildSomething,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Have an idea? Let\'s turn it into reality together.',
          style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
              fontSize: 15),
        ),
      ],
    );
  }
}

class _CtaButton extends StatelessWidget {
  final BuildContext context;

  const _CtaButton({required this.context});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.pushNamed(context, '/contact'),
      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
      label: Text(AppLocalizations.of(context).contactUsButton),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
