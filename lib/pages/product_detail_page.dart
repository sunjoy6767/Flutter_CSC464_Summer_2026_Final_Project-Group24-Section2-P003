import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../utils/currency_formatter.dart';

/// Placeholder product detail screen — to be filled in later.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Center(
        child: Text(
          '${product.name}\n${formatBdt(product.price)}\n\n(Details coming soon)',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
