import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../utils/currency_formatter.dart';
import 'order_detail_page.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  // Fixed filter vocabulary: every order is created with status "placed";
  // the others are set by manually editing a document's status field in
  // the Firebase console (there's no in-app status-change action).
  static const _statusFilters = [
    ('All', null),
    ('Placed', 'placed'),
    ('Processing', 'processing'),
    ('Delivered', 'delivered'),
    ('Cancelled', 'cancelled'),
  ];

  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final orders = _selectedStatus == null
        ? orderProvider.orders
        : orderProvider.ordersByStatus(_selectedStatus!);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: _statusFilters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final (label, value) = _statusFilters[index];
                return ChoiceChip(
                  label: Text(label),
                  selected: _selectedStatus == value,
                  onSelected: (isSelected) {
                    setState(() {
                      _selectedStatus = isSelected ? value : null;
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: orders.isEmpty
                ? Center(
                    child: Text(
                      'No orders yet',
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: orders.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Card(
                        child: ListTile(
                          title: Text(order.customerName),
                          subtitle: Text(
                            '${order.items.length} item(s) • ${order.status}',
                          ),
                          trailing: Text(
                            formatBdt(order.total),
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => OrderDetailPage(order: order),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
