import 'package:flutter/material.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';

class ServiceFeaturesWidget extends StatelessWidget {
  final Service service;

  const ServiceFeaturesWidget({
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
          decoration: BoxDecoration(
            color: Colors.yellow.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "⭐ Service Features",
            style: TextStyle(color: Colors.yellow.shade700, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 10),
        if (_hasAnyFeatures())
          Column(children: _buildAllFeatures())
        else
          _noDataWidget("No specific service features listed"),
      ],
    );
  }

  bool _hasAnyFeatures() {
    return service.features != null ||
        service.carriageDetails != null ||
        service.fleetInfo != null ||
        service.fleetDetails != null ||
        service.equipmentSelection != null ||
        service.businessProfile != null ||
        service.areasCovered?.isNotEmpty == true ||
        service.serviceCoverage?.isNotEmpty == true ||
        service.boatType != null ||
        service.seats != null ||
        service.luggageCapacity != null ||
        service.venueName?.isNotEmpty == true ||
        service.listingTitle?.isNotEmpty == true;
  }

  List<Widget> _buildAllFeatures() {
    List<Widget> features = [];

    // Service Title / Venue Name
    if (service.venueName?.isNotEmpty == true) {
      features.add(_buildFeatureRow(Icons.location_city, "Venue: ${service.venueName}"));
    } else if (service.listingTitle?.isNotEmpty == true) {
      features.add(_buildFeatureRow(Icons.title, "Service: ${service.listingTitle}"));
    }

    // Bouncy Castle Specific
    if (service.equipmentSelection != null) {
      final eq = service.equipmentSelection!;
      features.add(_buildFeatureRow(Icons.celebration, "Equipment: ${eq.inflatableType ?? 'Bouncy Castle'}"));
      if (eq.name?.isNotEmpty == true) features.add(_buildFeatureRow(Icons.badge, eq.name!));
      if (eq.description?.isNotEmpty == true) {
        features.add(_buildFeatureRow(Icons.info, eq.description!, isExpandable: true));
      }
      if (eq.theme != null) features.add(_buildFeatureRow(Icons.palette, "Theme: ${eq.theme}"));
      features.add(_buildFeatureRow(Icons.group, "Max Capacity: ${eq.capacity?.maximum ?? '?'}"));
      features.add(_buildFeatureRow(Icons.group_add, "Recommended: ${eq.capacity?.recommended ?? '?'}"));
      if (eq.minAge != null || eq.maxAge != null) {
        features.add(_buildFeatureRow(Icons.child_friendly, "Age: ${eq.minAge ?? 0} - ${eq.maxAge ?? 'All'} years"));
      }
      if (eq.ageGroup != null) features.add(_buildFeatureRow(Icons.face, "Age Group: ${eq.ageGroup}"));
    }

    // Boat Specific
    if (service.boatType != null) {
      features.add(_buildFeatureRow(Icons.sailing, "Boat Type: ${service.boatType}"));
    }
    if (service.hireType != null) {
      features.add(_buildFeatureRow(Icons.schedule, "Hire Type: ${service.hireType!.replaceAll('-', ' ').toUpperCase()}"));
    }

    // General Features
    if (service.features != null) {
      final f = service.features!;
      if (f.airConditioning == true) features.add(_buildFeatureRow(Icons.ac_unit, "Air Conditioning"));
      if (f.wifi == true) features.add(_buildFeatureRow(Icons.wifi, "WiFi Available"));
      if (f.tv == true) features.add(_buildFeatureRow(Icons.tv, "Television"));
      if (f.toilet == true) features.add(_buildFeatureRow(Icons.wc, "Toilet"));
      if (f.musicSystem == true) features.add(_buildFeatureRow(Icons.music_note, "Music System"));
      if (f.cateringFacilities == true) features.add(_buildFeatureRow(Icons.restaurant, "Catering"));
      if (f.sunDeck == true) features.add(_buildFeatureRow(Icons.wb_sunny, "Sun Deck"));
      if (f.overnightStayCabins == true) features.add(_buildFeatureRow(Icons.hotel, "Overnight Cabins"));
    }

    // Horse Carriage
    if (service.carriageDetails != null) {
      final c = service.carriageDetails!;
      features.add(_buildFeatureRow(Icons.directions_car, "Carriage: ${c.carriageType}"));
      features.add(_buildFeatureRow(Icons.event_seat, "Seats: ${c.seats}"));
      features.add(_buildFeatureRow(Icons.pets, "Horses: ${c.horseCount}"));
      if (c.decorationOptions.isNotEmpty) {
        features.add(_buildFeatureRow(Icons.celebration, "Decorations: ${c.decorationOptions.join(', ')}", isExpandable: true));
      }
    }

    // Seating & Luggage
    if (service.seats != null && service.seats! > 0) {
      features.add(_buildFeatureRow(Icons.event_seat, "Seats: ${service.seats} passengers"));
    }
    if (service.luggageCapacity != null) {
      final l = service.luggageCapacity!;
      int total = l.largeSuitcases + l.mediumSuitcases + l.smallSuitcases;
      if (total > 0) features.add(_buildFeatureRow(Icons.luggage, "Luggage: $total suitcases"));
    }

    // Coverage Areas
    if (service.serviceCoverage?.isNotEmpty == true) {
      features.add(_buildFeatureRow(Icons.location_on, "Coverage: ${service.serviceCoverage!.length} areas"));
    } else if (service.areasCovered?.isNotEmpty == true) {
      features.add(_buildFeatureRow(Icons.map, "Service Areas: ${service.areasCovered!.length} locations"));
    }

    return features;
  }

  Widget _buildFeatureRow(IconData icon, String text, {bool isExpandable = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.yellow.shade100, borderRadius: BorderRadius.circular(6)),
            child: Icon(icon, size: 16, color: Colors.yellow.shade700),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              maxLines: isExpandable ? null : 2,
              overflow: isExpandable ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _noDataWidget(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        message,
        style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
      ),
    );
  }
}