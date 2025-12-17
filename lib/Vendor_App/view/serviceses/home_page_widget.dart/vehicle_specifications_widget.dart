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
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "🚤 Vehicle Specifications",
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        SizedBox(height: 15),

        // Vehicle Specifications Details
        if (_hasVehicleSpecifications())
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildSpecifications(),
          )
        else
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "No vehicle specifications available",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  bool _hasVehicleSpecifications() {
    switch (service.serviceType.toLowerCase()) {
      case 'boat':
        return service.makeAndModel != null || service.seats != null || service.luggageCapacity != null;
      case 'horse':
        return service.carriageDetails != null;
      case 'funeral':
        return service.fleetDetails != null;
      case 'minibus':
        return service.fleetInfo != null;
      case 'limousine':
      case 'chauffeur':
        return service.fleetInfo != null;
      case 'coach':
        return service.fleetInfo != null || service.fleetDetails != null;
      default:
        return service.fleetInfo != null || 
               service.fleetDetails != null || 
               service.carriageDetails != null;
    }
  }

  List<Widget> _buildSpecifications() {
    switch (service.serviceType.toLowerCase()) {
      case 'boat':
        return _buildBoatSpecifications();
      case 'horse':
        return _buildHorseSpecifications();
      case 'funeral':
        return _buildFuneralSpecifications();
      case 'minibus':
        return _buildMinibusSpecifications();
      case 'limousine':
        return _buildLimousineSpecifications();
      case 'chauffeur':
        return _buildChauffeurSpecifications();
      case 'coach':
        return _buildCoachSpecifications();
      default:
        return _buildGeneralSpecifications();
    }
  }

  List<Widget> _buildBoatSpecifications() {
    List<Widget> specs = [];

    // Boat services use direct properties, not fleetInfo
    if (service.makeAndModel != null) {
      specs.add(_buildSpecRow("Make & Model", service.makeAndModel!));
    }
    if (service.seats != null) {
      specs.add(_buildSpecRow("Seats", "${service.seats} passengers"));
    }
    if (service.luggageCapacity != null) {
      specs.add(_buildSpecRow("Large Suitcases", "${service.luggageCapacity!.largeSuitcases}"));
      specs.add(_buildSpecRow("Medium Suitcases", "${service.luggageCapacity!.mediumSuitcases}"));
      specs.add(_buildSpecRow("Small Suitcases", "${service.luggageCapacity!.smallSuitcases}"));
    }
    if (service.firstRegistered != null) {
      specs.add(_buildSpecRow("First Registered", "${service.firstRegistered!.year}"));
    }
    if (service.boatType != null) {
      specs.add(_buildSpecRow("Boat Type", service.boatType!));
    }
    if (service.hireType != null) {
      specs.add(_buildSpecRow("Hire Type", service.hireType!.replaceAll('-', ' ').toUpperCase()));
    }
    
    // Features from service.features
    if (service.features != null) {
      if (service.features!.airConditioning == true) {
        specs.add(_buildSpecRow("Air Conditioning", 'Yes'));
      }
      if (service.features!.wifi == true) {
        specs.add(_buildSpecRow("WiFi", 'Yes'));
      }
      if (service.features!.toilet == true) {
        specs.add(_buildSpecRow("Toilet", 'Yes'));
      }
    }

    return specs.isNotEmpty ? specs : [_noDataWidget()];
  }

  List<Widget> _buildBoatSpecificationsOld() {
    if (service.fleetInfo == null) return [_noDataWidget()];

    return [
      _buildSpecRow("Make & Model", service.fleetInfo!.makeAndModel),
      _buildSpecRow("Seats", "${service.fleetInfo!.seats} passengers"),
      _buildSpecRow("Luggage Capacity", "${service.fleetInfo!.luggageCapacity}"),
      if (service.fleetInfo!.firstRegistered != null)
        _buildSpecRow("First Registered", "${service.fleetInfo!.firstRegistered!.year}"),
      if (service.fleetInfo!.largeSuitcases != null)
        _buildSpecRow("Large Suitcases", "${service.fleetInfo!.largeSuitcases}"),
      if (service.fleetInfo!.mediumSuitcases != null)
        _buildSpecRow("Medium Suitcases", "${service.fleetInfo!.mediumSuitcases}"),
      if (service.fleetInfo!.smallSuitcases != null)
        _buildSpecRow("Small Suitcases", "${service.fleetInfo!.smallSuitcases}"),
      _buildSpecRow("Air Conditioning", service.fleetInfo!.airConditioning == true ? 'Yes' : 'No'),
      _buildSpecRow("Wheelchair Accessible", service.fleetInfo!.wheelchairAccessible == true ? 'Yes' : 'No'),
      _buildSpecRow("Luggage Space", service.fleetInfo!.luggageSpace == true ? 'Yes' : 'No'),
      if (service.fleetInfo!.wheelchairAccessiblePrice != null)
        _buildSpecRow("Wheelchair Access Price", "£${service.fleetInfo!.wheelchairAccessiblePrice}"),
    ];
  }

  List<Widget> _buildHorseSpecifications() {
    if (service.carriageDetails == null) return [_noDataWidget()];

    return [
      _buildSpecRow("Carriage Type", service.carriageDetails!.carriageType),
      _buildSpecRow("Number of Carriages", "${service.carriageDetails!.numberOfCarriages}"),
      _buildSpecRow("Horse Count", "${service.carriageDetails!.horseCount}"),
      _buildSpecRow("Seats", "${service.carriageDetails!.seats}"),
      _buildSpecRow("Horse Breeds", service.carriageDetails!.horseBreeds.join(", "), isExpandable: true),
      if (service.carriageDetails!.otherHorseBreed.isNotEmpty)
        _buildSpecRow("Other Horse Breed", service.carriageDetails!.otherHorseBreed),
      _buildSpecRow("Horse Colors", service.carriageDetails!.horseColors.join(", "), isExpandable: true),
      if (service.carriageDetails!.otherHorseColor.isNotEmpty)
        _buildSpecRow("Other Horse Color", service.carriageDetails!.otherHorseColor),
      _buildSpecRow("Decoration Options", service.carriageDetails!.decorationOptions.join(", "), isExpandable: true),
      if (service.carriageDetails!.otherDecoration.isNotEmpty)
        _buildSpecRow("Other Decoration", service.carriageDetails!.otherDecoration),
    ];
  }

  List<Widget> _buildFuneralSpecifications() {
    if (service.fleetDetails == null) return [_noDataWidget()];

    return [
      _buildSpecRow("Make & Model", service.fleetDetails!.makeModel),
      _buildSpecRow("Year", "${service.fleetDetails!.year.year}"),
      _buildSpecRow("Seats", "${service.fleetDetails!.seats} passengers"),
      _buildSpecRow("Luggage Capacity", "${service.fleetDetails!.luggageCapacity}"),
    ];
  }

  List<Widget> _buildMinibusSpecifications() {
    if (service.fleetInfo == null) return [_noDataWidget()];

    return [
      _buildSpecRow("Make & Model", service.fleetInfo!.makeAndModel),
      _buildSpecRow("Seats", "${service.fleetInfo!.seats} passengers"),
      _buildSpecRow("Luggage Capacity", "${service.fleetInfo!.luggageCapacity}"),
      if (service.fleetInfo!.firstRegistered != null)
        _buildSpecRow("First Registered", "${service.fleetInfo!.firstRegistered!.year}"),
      _buildSpecRow("Wheelchair Accessible", service.fleetInfo!.wheelchairAccessible == true ? 'Yes' : 'No'),
      _buildSpecRow("Air Conditioning", service.fleetInfo!.airConditioning == true ? 'Yes' : 'No'),
      _buildSpecRow("Luggage Space", service.fleetInfo!.luggageSpace == true ? 'Yes' : 'No'),
      if (service.fleetInfo!.wheelchairAccessiblePrice != null)
        _buildSpecRow("Wheelchair Access Price", "£${service.fleetInfo!.wheelchairAccessiblePrice}"),
      if (service.fleetInfo!.largeSuitcases != null)
        _buildSpecRow("Large Suitcases", "${service.fleetInfo!.largeSuitcases}"),
      if (service.fleetInfo!.mediumSuitcases != null)
        _buildSpecRow("Medium Suitcases", "${service.fleetInfo!.mediumSuitcases}"),
      if (service.fleetInfo!.smallSuitcases != null)
        _buildSpecRow("Small Suitcases", "${service.fleetInfo!.smallSuitcases}"),
    ];
  }

  List<Widget> _buildLimousineSpecifications() {
    if (service.fleetInfo == null) return [_noDataWidget()];

    return [
      _buildSpecRow("Make & Model", service.fleetInfo!.makeAndModel),
      _buildSpecRow("Seats", "${service.fleetInfo!.seats} passengers"),
      _buildSpecRow("Luggage Capacity", "${service.fleetInfo!.luggageCapacity}"),
      if (service.fleetInfo!.firstRegistered != null)
        _buildSpecRow("First Registered", "${service.fleetInfo!.firstRegistered!.year}"),
      _buildSpecRow("Wheelchair Accessible", service.fleetInfo!.wheelchairAccessible == true ? 'Yes' : 'No'),
      _buildSpecRow("Air Conditioning", service.fleetInfo!.airConditioning == true ? 'Yes' : 'No'),
      _buildSpecRow("Luggage Space", service.fleetInfo!.luggageSpace == true ? 'Yes' : 'No'),
      if (service.fleetInfo!.wheelchairAccessiblePrice != null)
        _buildSpecRow("Wheelchair Access Price", "£${service.fleetInfo!.wheelchairAccessiblePrice}"),
      if (service.fleetInfo!.largeSuitcases != null)
        _buildSpecRow("Large Suitcases", "${service.fleetInfo!.largeSuitcases}"),
      if (service.fleetInfo!.mediumSuitcases != null)
        _buildSpecRow("Medium Suitcases", "${service.fleetInfo!.mediumSuitcases}"),
      if (service.fleetInfo!.smallSuitcases != null)
        _buildSpecRow("Small Suitcases", "${service.fleetInfo!.smallSuitcases}"),
    ];
  }

  List<Widget> _buildChauffeurSpecifications() {
    if (service.fleetInfo == null) return [_noDataWidget()];

    return [
      _buildSpecRow("Make & Model", service.fleetInfo!.makeAndModel),
      _buildSpecRow("Seats", "${service.fleetInfo!.seats} passengers"),
      _buildSpecRow("Luggage Capacity", "${service.fleetInfo!.luggageCapacity}"),
      if (service.fleetInfo!.firstRegistered != null)
        _buildSpecRow("First Registered", "${service.fleetInfo!.firstRegistered!.year}"),
      _buildSpecRow("Wheelchair Accessible", service.fleetInfo!.wheelchairAccessible == true ? 'Yes' : 'No'),
      _buildSpecRow("Air Conditioning", service.fleetInfo!.airConditioning == true ? 'Yes' : 'No'),
      _buildSpecRow("Luggage Space", service.fleetInfo!.luggageSpace == true ? 'Yes' : 'No'),
      if (service.fleetInfo!.wheelchairAccessiblePrice != null)
        _buildSpecRow("Wheelchair Access Price", "£${service.fleetInfo!.wheelchairAccessiblePrice}"),
      if (service.fleetInfo!.largeSuitcases != null)
        _buildSpecRow("Large Suitcases", "${service.fleetInfo!.largeSuitcases}"),
      if (service.fleetInfo!.mediumSuitcases != null)
        _buildSpecRow("Medium Suitcases", "${service.fleetInfo!.mediumSuitcases}"),
      if (service.fleetInfo!.smallSuitcases != null)
        _buildSpecRow("Small Suitcases", "${service.fleetInfo!.smallSuitcases}"),
    ];
  }

  List<Widget> _buildCoachSpecifications() {
    List<Widget> specs = [];

    // Check fleetInfo first, then fleetDetails
    if (service.fleetInfo != null) {
      specs.addAll([
        _buildSpecRow("Make & Model", service.fleetInfo!.makeAndModel),
        _buildSpecRow("Seats", "${service.fleetInfo!.seats} passengers"),
        _buildSpecRow("Luggage Capacity", "${service.fleetInfo!.luggageCapacity}"),
        if (service.fleetInfo!.firstRegistered != null)
          _buildSpecRow("First Registered", "${service.fleetInfo!.firstRegistered!.year}"),
        _buildSpecRow("Wheelchair Accessible", service.fleetInfo!.wheelchairAccessible == true ? 'Yes' : 'No'),
        _buildSpecRow("Air Conditioning", service.fleetInfo!.airConditioning == true ? 'Yes' : 'No'),
        _buildSpecRow("Luggage Space", service.fleetInfo!.luggageSpace == true ? 'Yes' : 'No'),
      ]);
    } else if (service.fleetDetails != null) {
      specs.addAll([
        _buildSpecRow("Make & Model", service.fleetDetails!.makeModel),
        _buildSpecRow("Year", "${service.fleetDetails!.year.year}"),
        _buildSpecRow("Seats", "${service.fleetDetails!.seats} passengers"),
        _buildSpecRow("Luggage Capacity", "${service.fleetDetails!.luggageCapacity}"),
      ]);
    }

    return specs.isEmpty ? [_noDataWidget()] : specs;
  }

  List<Widget> _buildGeneralSpecifications() {
    List<Widget> specs = [];

    // Try different data sources
    if (service.fleetInfo != null) {
      specs.addAll(_buildFromFleetInfo());
    } else if (service.fleetDetails != null) {
      specs.addAll(_buildFromFleetDetails());
    } else if (service.carriageDetails != null) {
      specs.addAll(_buildFromCarriageDetails());
    }

    return specs.isEmpty ? [_noDataWidget()] : specs;
  }

  List<Widget> _buildFromFleetInfo() {
    return [
      _buildSpecRow("Make & Model", service.fleetInfo!.makeAndModel),
      _buildSpecRow("Seats", "${service.fleetInfo!.seats} passengers"),
      _buildSpecRow("Luggage Capacity", "${service.fleetInfo!.luggageCapacity}"),
      if (service.fleetInfo!.firstRegistered != null)
        _buildSpecRow("First Registered", "${service.fleetInfo!.firstRegistered!.year}"),
    ];
  }

  List<Widget> _buildFromFleetDetails() {
    return [
      _buildSpecRow("Make & Model", service.fleetDetails!.makeModel),
      _buildSpecRow("Year", "${service.fleetDetails!.year.year}"),
      _buildSpecRow("Seats", "${service.fleetDetails!.seats} passengers"),
      _buildSpecRow("Luggage Capacity", "${service.fleetDetails!.luggageCapacity}"),
    ];
  }

  List<Widget> _buildFromCarriageDetails() {
    return [
      _buildSpecRow("Carriage Type", service.carriageDetails!.carriageType),
      _buildSpecRow("Number of Carriages", "${service.carriageDetails!.numberOfCarriages}"),
      _buildSpecRow("Horse Count", "${service.carriageDetails!.horseCount}"),
      _buildSpecRow("Seats", "${service.carriageDetails!.seats}"),
    ];
  }

  Widget _buildSpecRow(String label, String value, {bool isExpandable = false, bool isSmall = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isSmall ? 4 : 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isSmall ? 12 : 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: isSmall ? 12 : 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
                overflow: isExpandable ? TextOverflow.visible : TextOverflow.ellipsis,
                maxLines: isExpandable ? null : 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noDataWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "No specifications available for this service type",
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
