import 'package:flutter/material.dart';

/// Placeholder add/edit product form — to be filled in later.
/// Pass [productId] to edit an existing product, or omit it to add a new one.
class AddEditProductPage extends StatelessWidget {
  const AddEditProductPage({super.key, this.productId});

  final String? productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productId == null ? 'Add Product' : 'Edit Product'),
      ),
      body: const Center(child: Text('Product form coming soon')),
    );
  }
}
