import 'package:flutter/material.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';

class ServiceImage extends StatefulWidget {
  final VendorServiceModel service;

  const ServiceImage({super.key, required this.service});

  @override
  State<ServiceImage> createState() => _ServiceImageState();
}

class _ServiceImageState extends State<ServiceImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(
                widget.service.serviceImage.isNotEmpty
                    ? widget.service.serviceImage[0]
                    : 'https://via.placeholder.com/150',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '£${(widget.service.kilometerPrice).toStringAsFixed(0)}/mile',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}