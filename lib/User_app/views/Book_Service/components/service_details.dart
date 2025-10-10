import 'package:flutter/material.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';

class ServiceDetails extends StatefulWidget {
  final VendorServiceModel service;

  const ServiceDetails({super.key, required this.service});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.service.serviceName ?? 'N/A',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Remove logic
              },
              child: const Text(
                'Remove',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Service Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Service Type', style: TextStyle(fontSize: 14, color: Colors.black54)),
          subtitle: Text(
            '${widget.service.categoryId.categoryName} - ${widget.service.subcategoryId.subcategoryName}',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Make & Model', style: TextStyle(fontSize: 14, color: Colors.black54)),
          subtitle: Text(
            widget.service.makeAndModel ?? 'N/A',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Registration', style: TextStyle(fontSize: 14, color: Colors.black54)),
          subtitle: Text(
            widget.service.registrationNo,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}