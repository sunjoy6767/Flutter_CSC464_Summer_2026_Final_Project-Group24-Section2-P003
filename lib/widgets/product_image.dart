import 'package:flutter/material.dart';

IconData _categoryIcon(String category) {
  switch (category) {
    case 'Peripherals':
      return Icons.keyboard;
    case 'Storage':
      return Icons.sd_storage;
    case 'Accessories':
      return Icons.cable;
    default:
      return Icons.devices_other;
  }
}

/// A product's image loaded from [imageUrl]. Falls back to a tinted
/// category icon when the URL is empty or fails to load — no external image
/// assets or file storage involved, just a plain network fetch.
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageUrl,
    required this.category,
    this.iconSize = 40,
    this.borderRadius = 12,
  });

  final String imageUrl;
  final String category;
  final double iconSize;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Explicitly sized (not just DecoratedBox's shrink-wrap) so this can
    // never silently collapse to nothing when swapped in by errorBuilder —
    // it always fills exactly the space Image.network would have.
    final fallback = SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Icon(
            _categoryIcon(category),
            size: iconSize,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );

    if (imageUrl.isEmpty) return fallback;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.colorScheme.primary,
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => fallback,
      ),
    );
  }
}
