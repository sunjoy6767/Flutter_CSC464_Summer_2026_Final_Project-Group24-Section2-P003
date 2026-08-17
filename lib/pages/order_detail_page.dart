import 'package:flutter/material.dart';

import '../models/order_model.dart';
import '../utils/currency_formatter.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key, required this.order});

  final OrderModel order;

  String _formatDate(DateTime? date) {
    if (date == null) return 'Just now';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Customer', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(order.customerName, style: theme.textTheme.bodyLarge),
          Text(order.customerPhone, style: theme.textTheme.bodyMedium),
          Text(order.customerAddress, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Status', style: theme.textTheme.titleMedium),
              Chip(label: Text(order.status)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Placed ${_formatDate(order.createdAt)}',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Text('Items', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          ...order.items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${item.name} × ${item.quantity}',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    formatBdt(item.price * item.quantity),
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: theme.textTheme.titleMedium),
              Text(
                formatBdt(order.total),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
