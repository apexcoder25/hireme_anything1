import 'package:flutter/material.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';

class VehicleFeatures extends StatefulWidget {
  final VendorServiceModel service;

  const VehicleFeatures({super.key, required this.service});

  @override
  State<VehicleFeatures> createState() => _VehicleFeaturesState();
}

class _VehicleFeaturesState extends State<VehicleFeatures> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.directions_car, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Vehicle Features',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Wheelchair Access', style: TextStyle(fontSize: 14, color: Colors.black54)),
          trailing: widget.service.wheelChair == 'true'
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Aircon', style: TextStyle(fontSize: 14, color: Colors.black54)),
          trailing: widget.service.aironFitted == 'true'
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
        ),
      ],
    );
  }
}