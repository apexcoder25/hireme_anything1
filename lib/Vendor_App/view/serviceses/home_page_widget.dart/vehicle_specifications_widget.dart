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
    return service.fleetInfo != null ||
           service.fleetDetails != null ||
           service.serviceDetails != null ||
           service.serviceFleetDetails.isNotEmpty;
  }

  List<Widget> _buildSpecifications() {
    switch (service.serviceType?.toLowerCase()) {
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
      case 'coach':
        return _buildCoachSpecifications();
      default:
        return _buildGeneralSpecifications();
    }
  }

  List<Widget> _buildBoatSpecifications() {
    if (service.fleetInfo == null) return [_noDataWidget()];

    return [
      _buildSpecRow("Boat Name", service.fleetInfo!.boatName ?? 'N/A'),
      _buildSpecRow("Type", service.fleetInfo!.type ?? 'N/A'),
      _buildSpecRow("Capacity", "${service.fleetInfo!.capacity ?? 'N/A'} passengers"),
      _buildSpecRow("Year", service.fleetInfo!.year?.toString() ?? 'N/A'),
      if (service.fleetInfo!.makeAndModel != null)
        _buildSpecRow("Make & Model", service.fleetInfo!.makeAndModel!),
      if (service.fleetInfo!.onboardFeatures != null)
        _buildSpecRow("Onboard Features", service.fleetInfo!.onboardFeatures!, isExpandable: true),
      if (service.fleetInfo!.onboardFacilities != null)
        _buildSpecRow("Facilities", service.fleetInfo!.onboardFacilities!, isExpandable: true),
      _buildSpecRow("Air Conditioning", service.fleetInfo!.airConditioning == true ? 'Yes' : 'No'),
      _buildSpecRow("Wheelchair Accessible", service.fleetInfo!.wheelchairAccessible == true ? 'Yes' : 'No'),
      _buildSpecRow("Luggage Space", service.fleetInfo!.luggageSpace == true ? 'Yes' : 'No'),
      if (service.fleetInfo!.notes != null && service.fleetInfo!.notes!.isNotEmpty)
        _buildSpecRow("Notes", service.fleetInfo!.notes!, isExpandable: true),
    ];
  }

  List<Widget> _buildHorseSpecifications() {
    if (service.serviceDetails == null) return [_noDataWidget()];

    return [
      _buildSpecRow("Carriage Types", service.serviceDetails!.carriageTypes.join(", "), isExpandable: true),
      _buildSpecRow("Horse Types", service.serviceDetails!.horseTypes.join(", "), isExpandable: true),
      _buildSpecRow("Number of Carriages", "${service.serviceDetails!.numberOfCarriages ?? 'N/A'}"),
      _buildSpecRow("Fleet Size", "${service.serviceDetails!.fleetSize ?? 'N/A'}"),
      _buildSpecRow("Base Postcode", service.serviceDetails!.basePostcode ?? 'N/A'),
      if (service.serviceDetails!.mileage != null)
        _buildSpecRow("Mileage Range", "${service.serviceDetails!.mileage} miles"),
      if (service.serviceDetails!.otherCarriageType != null && service.serviceDetails!.otherCarriageType!.isNotEmpty)
        _buildSpecRow("Other Carriage Type", service.serviceDetails!.otherCarriageType!),
      if (service.serviceDetails!.otherHorseType != null && service.serviceDetails!.otherHorseType!.isNotEmpty)
        _buildSpecRow("Other Horse Type", service.serviceDetails!.otherHorseType!),
    ];
  }

  List<Widget> _buildFuneralSpecifications() {
    if (service.fleetDetails == null) return [_noDataWidget()];

    return [
      _buildSpecRow("Make & Model", service.fleetDetails!.makeModel ?? 'N/A'),
      _buildSpecRow("Vehicle Type", service.fleetDetails!.vehicleType ?? 'N/A'),
      _buildSpecRow("Capacity", "${service.fleetDetails!.capacity ?? 'N/A'} passengers"),
      _buildSpecRow("Year", "${service.fleetDetails!.year ?? 'N/A'}"),
      _buildSpecRow("Color", service.fleetDetails!.color ?? 'N/A'),
      if (service.fleetDetails!.notes != null && service.fleetDetails!.notes!.isNotEmpty)
        _buildSpecRow("Notes", service.fleetDetails!.notes!, isExpandable: true),
    ];
  }

  List<Widget> _buildMinibusSpecifications() {
    if (service.fleetInfo == null) return [_noDataWidget()];

    return [
      _buildSpecRow("Make & Model", service.fleetInfo!.makeAndModel ?? 'N/A'),
      _buildSpecRow("Type", service.fleetInfo!.type ?? 'N/A'),
      _buildSpecRow("Capacity", "${service.fleetInfo!.capacity ?? 'N/A'} passengers"),
      _buildSpecRow("Year", service.fleetInfo!.year?.toString() ?? 'N/A'),
      _buildSpecRow("Wheelchair Accessible", service.fleetInfo!.wheelchairAccessible == true ? 'Yes' : 'No'),
      _buildSpecRow("Air Conditioning", service.fleetInfo!.airConditioning == true ? 'Yes' : 'No'),
      _buildSpecRow("Luggage Space", service.fleetInfo!.luggageSpace == true ? 'Yes' : 'No'),
      if (service.seatBeltsInAllVehicles != null)
        _buildSpecRow("Seat Belts in All Vehicles", service.seatBeltsInAllVehicles! ? 'Yes' : 'No'),
      if (service.fleetInfo!.onboardFacilities != null)
        _buildSpecRow("Onboard Facilities", service.fleetInfo!.onboardFacilities!, isExpandable: true),
      if (service.fleetInfo!.notes != null && service.fleetInfo!.notes!.isNotEmpty)
        _buildSpecRow("Notes", service.fleetInfo!.notes!, isExpandable: true),
    ];
  }

  List<Widget> _buildLimousineSpecifications() {
    if (service.serviceFleetDetails.isEmpty) return [_noDataWidget()];

    final fleet = service.serviceFleetDetails.first;
    return [
      _buildSpecRow("Make & Model", fleet.makeModel ?? 'N/A'),
      _buildSpecRow("Vehicle Type", fleet.type ?? 'N/A'),
      _buildSpecRow("Capacity", "${fleet.capacity ?? 'N/A'} passengers"),
      _buildSpecRow("Year", "${fleet.year ?? 'N/A'}"),
      _buildSpecRow("Color", fleet.color ?? 'N/A'),
      if (fleet.vehicleDescription != null && fleet.vehicleDescription!.isNotEmpty)
        _buildSpecRow("Description", fleet.vehicleDescription!, isExpandable: true),
      if (fleet.bootSpace != null && fleet.bootSpace!.isNotEmpty)
        _buildSpecRow("Boot Space", fleet.bootSpace!),
      if (fleet.keyFeatures != null && fleet.keyFeatures!.isNotEmpty)
        _buildSpecRow("Key Features", fleet.keyFeatures!, isExpandable: true),
      
      // Additional fleet vehicles
      if (service.serviceFleetDetails.length > 1)
        ..._buildAdditionalFleetInfo(),
    ];
  }

  List<Widget> _buildCoachSpecifications() {
    List<Widget> specs = [];

    // Check fleetInfo first, then fleetDetails
    if (service.fleetInfo != null) {
      specs.addAll([
        _buildSpecRow("Make & Model", service.fleetInfo!.makeAndModel ?? 'N/A'),
        // _buildSpecRow("Type", service.fleetInfo!.type ?? 'N/A'),
        // _buildSpecRow("Capacity", "${service.fleetInfo!.seats ?? 'N/A'} passengers"),
        // _buildSpecRow("Year", service.fleetInfo!.year?.toString() ?? 'N/A'),
        _buildSpecRow("Wheelchair Accessible", service.fleetInfo!.wheelchairAccessible == true ? 'Yes' : 'No'),
        _buildSpecRow("Air Conditioning", service.fleetInfo!.airConditioning == true ? 'Yes' : 'No'),
        // _buildSpecRow("Luggage Capacity", service.fleetInfo!.luggageCapacity == true ? 'Yes' : 'No'),
      ]);
    } else if (service.fleetDetails != null) {
      specs.addAll([
        _buildSpecRow("Make & Model", service.fleetDetails!.makeModel ?? 'N/A'),
        _buildSpecRow("Vehicle Type", service.fleetDetails!.vehicleType ?? 'N/A'),
        _buildSpecRow("Capacity", "${service.fleetDetails!.capacity ?? 'N/A'} passengers"),
        _buildSpecRow("Year", "${service.fleetDetails!.year ?? 'N/A'}"),
        _buildSpecRow("Color", service.fleetDetails!.color ?? 'N/A'),
      ]);
    }

    // Add fleet size if available
    if (service.fleetSize != null) {
      specs.add(_buildSpecRow("Fleet Size", "${service.fleetSize} vehicles"));
    }

    // Add services provided
    if (service.servicesProvided != null) {
      specs.addAll(_buildServicesProvidedSpecs());
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
    } else if (service.serviceFleetDetails.isNotEmpty) {
      specs.addAll(_buildFromServiceFleetDetails());
    }

    // Add general fleet information
    if (service.fleetSize != null) {
      specs.add(_buildSpecRow("Fleet Size", "${service.fleetSize} vehicles"));
    }
    if (service.basePostcode != null) {
      specs.add(_buildSpecRow("Base Postcode", service.basePostcode!));
    }

    return specs.isEmpty ? [_noDataWidget()] : specs;
  }

  List<Widget> _buildFromFleetInfo() {
    return [
      if (service.fleetInfo!.makeAndModel != null)
        _buildSpecRow("Make & Model", service.fleetInfo!.makeAndModel!),
      if (service.fleetInfo!.type != null)
        _buildSpecRow("Type", service.fleetInfo!.type!),
      if (service.fleetInfo!.capacity != null)
        _buildSpecRow("Capacity", "${service.fleetInfo!.capacity} passengers"),
      if (service.fleetInfo!.year != null)
        _buildSpecRow("Year", service.fleetInfo!.year.toString()),
    ];
  }

  List<Widget> _buildFromFleetDetails() {
    return [
      if (service.fleetDetails!.makeModel != null)
        _buildSpecRow("Make & Model", service.fleetDetails!.makeModel!),
      if (service.fleetDetails!.vehicleType != null)
        _buildSpecRow("Vehicle Type", service.fleetDetails!.vehicleType!),
      if (service.fleetDetails!.capacity != null)
        _buildSpecRow("Capacity", "${service.fleetDetails!.capacity} passengers"),
      if (service.fleetDetails!.year != null)
        _buildSpecRow("Year", service.fleetDetails!.year.toString()),
      if (service.fleetDetails!.color != null)
        _buildSpecRow("Color", service.fleetDetails!.color!),
    ];
  }

  List<Widget> _buildFromServiceFleetDetails() {
    final fleet = service.serviceFleetDetails.first;
    return [
      if (fleet.makeModel != null)
        _buildSpecRow("Make & Model", fleet.makeModel!),
      if (fleet.type != null)
        _buildSpecRow("Type", fleet.type!),
      if (fleet.capacity != null)
        _buildSpecRow("Capacity", "${fleet.capacity} passengers"),
      if (fleet.year != null)
        _buildSpecRow("Year", fleet.year.toString()),
      if (fleet.color != null)
        _buildSpecRow("Color", fleet.color!),
    ];
  }

  List<Widget> _buildAdditionalFleetInfo() {
    List<Widget> additionalFleet = [];
    
    if (service.serviceFleetDetails.length > 1) {
      additionalFleet.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Text(
            "Additional Fleet Vehicles (${service.serviceFleetDetails.length - 1})",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade700,
            ),
          ),
        ),
      );

      for (int i = 1; i < service.serviceFleetDetails.length; i++) {
        final fleet = service.serviceFleetDetails[i];
        additionalFleet.add(
          Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                _buildSpecRow("Make & Model", fleet.makeModel ?? 'N/A', isSmall: true),
                _buildSpecRow("Type", fleet.type ?? 'N/A', isSmall: true),
                _buildSpecRow("Capacity", "${fleet.capacity ?? 'N/A'} passengers", isSmall: true),
              ],
            ),
          ),
        );
      }
    }
    
    return additionalFleet;
  }

  List<Widget> _buildServicesProvidedSpecs() {
    List<Widget> specs = [];
    final services = service.servicesProvided!;
    
    List<String> providedServices = [];
    if (services.schoolTrips == true) providedServices.add("School Trips");
    if (services.corporateTransport == true) providedServices.add("Corporate Transport");
    if (services.privateGroupTours == true) providedServices.add("Private Group Tours");
    if (services.airportTransfers == true) providedServices.add("Airport Transfers");
    if (services.longDistanceTravel == true) providedServices.add("Long Distance Travel");
    if (services.weddingOrEventTransport == true) providedServices.add("Wedding/Event Transport");
    if (services.shuttleServices == true) providedServices.add("Shuttle Services");
    if (services.accessibleCoachHire == true) providedServices.add("Accessible Coach Hire");
    if (services.other == true && services.otherSpecified != null) {
      providedServices.add(services.otherSpecified!);
    }

    if (providedServices.isNotEmpty) {
      specs.add(_buildSpecRow("Services Provided", providedServices.join(", "), isExpandable: true));
    }

    return specs;
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
