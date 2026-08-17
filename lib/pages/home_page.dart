import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'add_edit_product_page.dart';
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _categories = ['Peripherals', 'Storage', 'Accessories'];

  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final products = _selectedCategory == null
        ? productProvider.products
        : productProvider.productsByCategory(_selectedCategory!);

    return Scaffold(
      appBar: AppBar(title: const Text('ByteShop')),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final selected = _selectedCategory == category;
                return ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  onSelected: (isSelected) {
                    setState(() {
                      _selectedCategory = isSelected ? category : null;
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? Center(
                    child: Text(
                      'No products yet',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.72,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddEditProductPage()));
        },
        tooltip: 'Add product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
