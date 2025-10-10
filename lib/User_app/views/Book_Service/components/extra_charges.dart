import 'package:flutter/material.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';

class ExtraCharges extends StatefulWidget {
  final VendorServiceModel service;
  final double distance;

  const ExtraCharges({super.key, required this.service, required this.distance});

  @override
  State<ExtraCharges> createState() => _ExtraChargesState();
}

class _ExtraChargesState extends State<ExtraCharges> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.blue[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Base Price', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('£${(widget.service.kilometerPrice).toStringAsFixed(0)}/mile', style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              const Text('Extra Mile Charge', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('£${widget.service.extraMilesCharges.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Distance', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('${widget.distance.toStringAsFixed(2)} miles', style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              const Text('Waiting Charge', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('£${widget.service.extraTimeWaitingCharge.toStringAsFixed(0)}/min', style: const TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}