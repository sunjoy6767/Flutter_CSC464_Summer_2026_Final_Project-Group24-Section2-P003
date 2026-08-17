import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../utils/currency_formatter.dart';
import '../widgets/product_image.dart';

/// Full product detail screen: large image, info, and Add to Cart.
/// Products are read-only here — they're never created/edited/deleted from
/// the app UI, only via the seed script.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  void _addToCart(BuildContext context) {
    context.read<CartProvider>().addToCart(product);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${product.name} added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 1.3,
            child: ProductImage(
              imageUrl: product.imageUrl,
              category: product.category,
              iconSize: 72,
              borderRadius: 16,
            ),
          ),
          const SizedBox(height: 20),
          Text(product.name, style: theme.textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(product.category, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          Text(
            formatBdt(product.price),
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text('Description', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(product.description, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 28),
          ElevatedButton.icon(
            onPressed: () => _addToCart(context),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
