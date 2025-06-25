import 'package:flutter/material.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';

class CancellationPolicy extends StatefulWidget {
  final VendorServiceModel service;

  const CancellationPolicy({super.key, required this.service});

  @override
  State<CancellationPolicy> createState() => _CancellationPolicyState();
}

class _CancellationPolicyState extends State<CancellationPolicy> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.cancel_outlined, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Cancellation Policy',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            '${widget.service.cancellationPolicyType} (Most Flexible) Maximum Timeline: 48 hours',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('48+ hours before pickup', style: TextStyle(fontSize: 14, color: Colors.black54)),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.green[100],
                  child: const Text('100% Refund', style: TextStyle(color: Colors.green, fontSize: 14)),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('24-48 hours before pickup', style: TextStyle(fontSize: 14, color: Colors.black54)),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.yellow[100],
                  child: const Text('80% Refund', style: TextStyle(color: Colors.yellow, fontSize: 14)),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Less than 24 hours', style: TextStyle(fontSize: 14, color: Colors.black54)),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.red[100],
                  child: const Text('0% Refund', style: TextStyle(color: Colors.red, fontSize: 14)),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Cancellation requests must be made through the platform for proper processing\n'
                '• Refund processing time may take 5-7 business days depending on your payment method.\n'
                '• For special circumstances, please contact our customer support team.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}