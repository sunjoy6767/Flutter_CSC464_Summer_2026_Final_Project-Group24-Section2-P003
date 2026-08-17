import 'package:flutter/material.dart';

import '../models/order_model.dart';
import '../utils/currency_formatter.dart';
import 'order_history_page.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmed'), automaticallyImplyLeading: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                size: 72,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text('Order placed!', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Thanks, ${order.customerName}. Your order total is '
                '${formatBdt(order.total)}.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Continue Shopping'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const OrderHistoryPage(),
                    ),
                    (route) => route.isFirst,
                  );
                },
                child: const Text('View My Orders'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
