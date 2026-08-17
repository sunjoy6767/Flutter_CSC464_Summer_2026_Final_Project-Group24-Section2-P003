import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../utils/currency_formatter.dart';
import 'product_form_page.dart';

/// Full product detail screen with Edit and Delete actions.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  Future<void> _edit(BuildContext context) async {
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => ProductFormPage(product: product)),
    );
    if (saved == true && context.mounted) {
      // The edited data now lives in Firestore; the snapshot held by this
      // page is stale, so return to the live-updating list instead of
      // showing outdated details.
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete product?'),
        content: Text('This will permanently delete "${product.name}".'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await context.read<ProductProvider>().deleteProduct(product.id);
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(content: Text('Product deleted')),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to delete product: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () => _edit(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete',
            onPressed: () => _delete(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
          const SizedBox(height: 20),
          Text('Stock', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text('${product.stock} units', style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
