import 'package:flutter/material.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';

class VehicleSpecificationsWidget extends StatelessWidget {
  final Service service;

  const VehicleSpecificationsWidget({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
          child: Text(" Specifications", style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 15),
        if (_hasAnySpecs())
          Column(children: _buildAllSpecs())
        else
          _noDataWidget("No specifications available"),
      ],
    );
  }

  bool _hasAnySpecs() {
    return service.fleetInfo != null ||
        service.fleetDetails != null ||
        service.carriageDetails != null ||
        service.makeAndModel != null ||
        service.seats != null ||
        service.luggageCapacity != null ||
        service.equipmentSelection != null ||
        service.boatType != null ||
        service.venueName?.isNotEmpty == true;
  }

  List<Widget> _buildAllSpecs() {
    List<Widget> specs = [];

    // Venue Name (for Venue Hire)
    if (service.venueName?.isNotEmpty == true) {
      specs.add(_buildSpecRow("Venue Name", service.venueName!));
    }

    // Bouncy Castle
    if (service.equipmentSelection != null) {
      final e = service.equipmentSelection!;
      specs.add(_buildSpecRow("Type", e.inflatableType ?? "Bouncy Castle"));
      if (e.name?.isNotEmpty == true) specs.add(_buildSpecRow("Name", e.name!));
      specs.add(_buildSpecRow("Max Guests", "${e.capacity?.maximum ?? '?'}"));
      specs.add(_buildSpecRow("Recommended", "${e.capacity?.recommended ?? '?'}"));
      if (e.minAge != null || e.maxAge != null) {
        specs.add(_buildSpecRow("Age Range", "${e.minAge ?? '0'} - ${e.maxAge ?? 'All'} years"));
      }
      if (e.theme != null) specs.add(_buildSpecRow("Theme", e.theme!));
    }

    // Boat
    if (service.makeAndModel != null) specs.add(_buildSpecRow("Make & Model", service.makeAndModel!));
    if (service.boatType != null) specs.add(_buildSpecRow("Boat Type", service.boatType!));
    if (service.seats != null) specs.add(_buildSpecRow("Passenger Capacity", "${service.seats}"));

    // Standard Fleet Info
    if (service.fleetInfo != null) {
      final f = service.fleetInfo!;
      specs.add(_buildSpecRow("Vehicle", f.makeAndModel));
      specs.add(_buildSpecRow("Seats", "${f.seats}"));
      specs.add(_buildSpecRow("Luggage", "${f.luggageCapacity}"));
      if (f.firstRegistered != null) specs.add(_buildSpecRow("Year", "${f.firstRegistered!.year}"));
      if (f.airConditioning == true) specs.add(_buildSpecRow("Air Conditioning", "Yes"));
      if (f.wheelchairAccessible == true) specs.add(_buildSpecRow("Wheelchair Access", "Yes"));
    }

    // Older Fleet Details
    if (service.fleetDetails != null) {
      final fd = service.fleetDetails!;
      specs.add(_buildSpecRow("Vehicle", fd.makeModel));
      specs.add(_buildSpecRow("Year", "${fd.year.year}"));
      specs.add(_buildSpecRow("Seats", "${fd.seats}"));
      specs.add(_buildSpecRow("Luggage", "${fd.luggageCapacity}"));
    }

    // Horse Carriage
    if (service.carriageDetails != null) {
      final c = service.carriageDetails!;
      specs.add(_buildSpecRow("Carriage Type", c.carriageType));
      specs.add(_buildSpecRow("Seats", "${c.seats}"));
      specs.add(_buildSpecRow("Horses", "${c.horseCount}"));
      specs.add(_buildSpecRow("Carriages", "${c.numberOfCarriages}"));
    }

    return specs;
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _noDataWidget(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(text, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
    );
  }
}