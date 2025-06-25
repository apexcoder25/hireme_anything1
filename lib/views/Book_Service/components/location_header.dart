import 'package:flutter/material.dart';

class LocationHeader extends StatefulWidget {
  final String fromLocation;
  final String toLocation;
  final double distance;

  const LocationHeader({
    super.key,
    required this.fromLocation,
    required this.toLocation,
    required this.distance,
  });

  @override
  State<LocationHeader> createState() => _LocationHeaderState();
}

class _LocationHeaderState extends State<LocationHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'From ${widget.fromLocation} to ${widget.toLocation}, Distance: ${widget.distance.toStringAsFixed(2)} miles',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        TextButton(
          onPressed: () {
                 Navigator.pop(context);
          },
          child: const Text(
            'Change Location',
            style: TextStyle(color: Colors.blue, fontSize: 14),
          ),
        ),
      ],
    );
  }
}