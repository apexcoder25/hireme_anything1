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
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.yellow.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "⭐ Service Features",
            style: TextStyle(
              color: Colors.yellow.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        SizedBox(height: 10),

        // Service Features
        if (_hasServiceFeatures())
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildServiceFeatures(),
          )
        else
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "No specific service features listed",
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

  bool _hasServiceFeatures() {
    switch (service.serviceType?.toLowerCase()) {
      case 'boat':
        return true;
      case 'horse':
        return service.serviceDetails?.occasionsCatered.isNotEmpty ?? false;
      case 'funeral':
        return service.fleetDetails != null;
      case 'minibus':
        return service.fleetInfo != null;
      case 'limousine':
        return service.features != null && _hasLimousineFeatures();
      case 'coach':
        return _hasCoachFeatures();
      default:
        return _hasGeneralFeatures();
    }
  }

  bool _hasLimousineFeatures() {
    return (service.features?.comfortAndLuxury.isNotEmpty ?? false) ||
        (service.features?.eventsAndCustomization.isNotEmpty ?? false) ||
        (service.features?.accessibilityServices.isNotEmpty ?? false) ||
        (service.features?.safetyAndCompliance.isNotEmpty ?? false);
  }

  bool _hasCoachFeatures() {
    return service.servicesProvided != null ||
        service.fleetInfo != null ||
        service.features != null;
  }

  bool _hasGeneralFeatures() {
    return service.features != null ||
        service.fleetInfo != null ||
        service.serviceDetails != null ||
        service.comfort != null ||
        service.events != null ||
        service.accessibility != null ||
        service.security != null;
  }

  List<Widget> _buildServiceFeatures() {
    switch (service.serviceType?.toLowerCase()) {
      case 'boat':
        return _buildBoatFeatures();
      case 'horse':
        return _buildHorseFeatures();
      case 'funeral':
        return _buildFuneralFeatures();
      case 'minibus':
        return _buildMinibusFeatures();
      case 'limousine':
        return _buildLimousineFeatures();
      case 'coach':
        return _buildCoachFeatures();
      default:
        return _buildGeneralFeatures();
    }
  }

  List<Widget> _buildBoatFeatures() {
    List<Widget> features = [];

    features.add(_buildFeatureRow(
      Icons.directions_boat,
      "Professional Boat Service",
    ));

    if (service.fleetInfo != null) {
      if (service.fleetInfo!.airConditioning == true) {
        features.add(_buildFeatureRow(Icons.ac_unit, "Air Conditioning"));
      }
      if (service.fleetInfo!.wheelchairAccessible == true) {
        features
            .add(_buildFeatureRow(Icons.accessible, "Wheelchair Accessible"));
      }
      if (service.fleetInfo!.luggageSpace == true) {
        features
            .add(_buildFeatureRow(Icons.luggage, "Luggage Space Available"));
      }
      if (service.fleetInfo!.onboardFeatures?.isNotEmpty ?? false) {
        features.add(_buildFeatureRow(
          Icons.featured_play_list,
          "Onboard Features: ${service.fleetInfo!.onboardFeatures}",
          isExpandable: true,
        ));
      }
      if (service.fleetInfo!.onboardFacilities?.isNotEmpty ?? false) {
        features.add(_buildFeatureRow(
          Icons.room_service,
          "Onboard Facilities: ${service.fleetInfo!.onboardFacilities}",
          isExpandable: true,
        ));
      }
    }

    if (service.navigableRoutes.isNotEmpty) {
      features.add(_buildFeatureRow(
        Icons.route,
        "Navigable Routes: ${service.navigableRoutes.join(", ")}",
        isExpandable: true,
      ));
    }

    if (service.boatRates?.packageDealsDescription?.isNotEmpty ?? false) {
      features.add(_buildFeatureRow(
        Icons.local_offer,
        "Package Deals: ${service.boatRates!.packageDealsDescription}",
        isExpandable: true,
      ));
    }

    return features;
  }

  List<Widget> _buildHorseFeatures() {
    List<Widget> features = [];

    if (service.serviceDetails?.occasionsCatered.isNotEmpty ?? false) {
      features.add(_buildFeatureRow(
        Icons.celebration,
        "Occasions Catered: ${service.serviceDetails!.occasionsCatered.join(", ")}",
        isExpandable: true,
      ));
    }

    if (service.serviceDetails?.carriageTypes.isNotEmpty ?? false) {
      features.add(_buildFeatureRow(
        Icons.directions_car,
        "Carriage Types: ${service.serviceDetails!.carriageTypes.join(", ")}",
        isExpandable: true,
      ));
    }

    if (service.serviceDetails?.horseTypes.isNotEmpty ?? false) {
      features.add(_buildFeatureRow(
        Icons.pets,
        "Horse Types: ${service.serviceDetails!.horseTypes.join(", ")}",
        isExpandable: true,
      ));
    }

    if (service.serviceDetails?.fleetSize != null &&
        service.serviceDetails!.fleetSize! > 0) {
      features.add(_buildFeatureRow(
        Icons.format_list_numbered,
        "Fleet Size: ${service.serviceDetails!.fleetSize} carriages",
      ));
    }

    if (service.serviceDetails?.numberOfCarriages != null &&
        service.serviceDetails!.numberOfCarriages! > 0) {
      features.add(_buildFeatureRow(
        Icons.format_list_numbered,
        "Number of Carriages: ${service.serviceDetails!.numberOfCarriages}",
      ));
    }

    if (service.serviceDetails?.basePostcode?.isNotEmpty ?? false) {
      features.add(_buildFeatureRow(
        Icons.location_on,
        "Based in: ${service.serviceDetails!.basePostcode}",
      ));
    }

    if (service.serviceDetails?.mileage != null &&
        service.serviceDetails!.mileage! > 0) {
      features.add(_buildFeatureRow(
        Icons.route,
        "Service Range: ${service.serviceDetails!.mileage} miles",
      ));
    }

    if (service.otherOccasions?.isNotEmpty ?? false) {
      features.add(_buildFeatureRow(
        Icons.event_available,
        "Other Occasions: ${service.otherOccasions}",
        isExpandable: true,
      ));
    }

    return features;
  }

  List<Widget> _buildFuneralFeatures() {
    List<Widget> features = [];

    features.add(_buildFeatureRow(
      Icons.local_florist,
      "Professional Funeral Service",
    ));

    if (service.fleetDetails != null) {
      if (service.fleetDetails!.vehicleType?.isNotEmpty ?? false) {
        features.add(_buildFeatureRow(
          Icons.directions_car,
          "Vehicle Type: ${service.fleetDetails!.vehicleType}",
        ));
      }

      if (service.fleetDetails!.color?.isNotEmpty ?? false) {
        features.add(_buildFeatureRow(
          Icons.palette,
          "Vehicle Color: ${service.fleetDetails!.color}",
        ));
      }

      if (service.fleetDetails!.capacity != null &&
          service.fleetDetails!.capacity! > 0) {
        features.add(_buildFeatureRow(
          Icons.people,
          "Capacity: ${service.fleetDetails!.capacity} passengers",
        ));
      }
    }

    if (service.pricingDetails != null) {
      if (service.pricingDetails!.decoratingFloralServiceFee != null &&
          service.pricingDetails!.decoratingFloralServiceFee! > 0) {
        features.add(_buildFeatureRow(
          Icons.local_florist,
          "Decorating/Floral Service Available",
        ));
      }

      if (service.pricingDetails!.waitTimeFeePerHour != null &&
          service.pricingDetails!.waitTimeFeePerHour! > 0) {
        features.add(_buildFeatureRow(
          Icons.schedule,
          "Flexible Wait Time Options",
        ));
      }

      if (service.pricingDetails!.fuelChargesIncluded == true) {
        features.add(_buildFeatureRow(
          Icons.local_gas_station,
          "Fuel Charges Included",
        ));
      }
    }

    return features;
  }

  List<Widget> _buildMinibusFeatures() {
    List<Widget> features = [];

    if (service.fleetInfo != null) {
      if (service.fleetInfo!.wheelchairAccessible == true) {
        features.add(_buildFeatureRow(
          Icons.accessible,
          "Wheelchair Accessible",
        ));
      }

      if (service.fleetInfo!.airConditioning == true) {
        features.add(_buildFeatureRow(
          Icons.ac_unit,
          "Air Conditioning",
        ));
      }

      if (service.fleetInfo!.luggageSpace == true) {
        features.add(_buildFeatureRow(
          Icons.luggage,
          "Luggage Space Available",
        ));
      }

      if (service.fleetInfo!.capacity != null &&
          service.fleetInfo!.capacity! > 0) {
        features.add(_buildFeatureRow(
          Icons.people,
          "Capacity: ${service.fleetInfo!.capacity} passengers",
        ));
      }

      if (service.fleetInfo!.onboardFacilities?.isNotEmpty ?? false) {
        features.add(_buildFeatureRow(
          Icons.room_service,
          "Onboard Facilities: ${service.fleetInfo!.onboardFacilities}",
          isExpandable: true,
        ));
      }
    }

    if (service.seatBeltsInAllVehicles == true) {
      features.add(_buildFeatureRow(
        Icons.safety_check,
        "Seat Belts in All Vehicles",
      ));
    }

    if (service.miniBusRates?.mileageAllowance != null &&
        service.miniBusRates!.mileageAllowance! > 0) {
      features.add(_buildFeatureRow(
        Icons.route,
        "Mileage Allowance: ${service.miniBusRates!.mileageAllowance} miles",
      ));
    }

    if (service.occasionsCovered.isNotEmpty) {
      features.add(_buildFeatureRow(
        Icons.event,
        "Occasions Covered: ${service.occasionsCovered.join(", ")}",
        isExpandable: true,
      ));
    }

    return features;
  }

  List<Widget> _buildLimousineFeatures() {
    List<Widget> features = [];

    if (service.features != null) {
      if (service.features!.comfortAndLuxury.isNotEmpty) {
        features.add(_buildFeatureRow(
          Icons.star,
          "Comfort & Luxury: ${service.features!.comfortAndLuxury.join(", ")}",
          isExpandable: true,
        ));
      }

      if (service.features!.eventsAndCustomization.isNotEmpty) {
        features.add(_buildFeatureRow(
          Icons.event,
          "Events & Customization: ${service.features!.eventsAndCustomization.join(", ")}",
          isExpandable: true,
        ));
      }

      if (service.features!.accessibilityServices.isNotEmpty) {
        features.add(_buildFeatureRow(
          Icons.accessible,
          "Accessibility: ${service.features!.accessibilityServices.join(", ")}",
          isExpandable: true,
        ));
      }

      if (service.features!.safetyAndCompliance.isNotEmpty) {
        features.add(_buildFeatureRow(
          Icons.security,
          "Safety & Compliance: ${service.features!.safetyAndCompliance.join(", ")}",
          isExpandable: true,
        ));
      }
    }

    // Fuel and mileage information
    if (service.fuelIncluded == true) {
      features.add(_buildFeatureRow(Icons.local_gas_station, "Fuel Included"));
    }

    if (service.mileageCapLimit != null && service.mileageCapLimit! > 0) {
      features.add(_buildFeatureRow(
        Icons.route,
        "Mileage Cap: ${service.mileageCapLimit} miles",
      ));
    }

    // Service fleet details
    if (service.serviceFleetDetails.isNotEmpty) {
      final fleet = service.serviceFleetDetails.first;
      if (fleet.keyFeatures?.isNotEmpty ?? false) {
        features.add(_buildFeatureRow(
          Icons.key,
          "Key Features: ${fleet.keyFeatures}",
          isExpandable: true,
        ));
      }

      if (fleet.bootSpace?.isNotEmpty ?? false) {
        features.add(_buildFeatureRow(
          Icons.luggage,
          "Boot Space: ${fleet.bootSpace}",
        ));
      }
    }

    return features;
  }

  List<Widget> _buildCoachFeatures() {
    List<Widget> features = [];

    // Services provided
    if (service.servicesProvided != null) {
      List<String> providedServices = [];
      if (service.servicesProvided!.schoolTrips == true)
        providedServices.add("School Trips");
      if (service.servicesProvided!.corporateTransport == true)
        providedServices.add("Corporate Transport");
      if (service.servicesProvided!.privateGroupTours == true)
        providedServices.add("Private Group Tours");
      if (service.servicesProvided!.airportTransfers == true)
        providedServices.add("Airport Transfers");
      if (service.servicesProvided!.longDistanceTravel == true)
        providedServices.add("Long Distance Travel");
      if (service.servicesProvided!.weddingOrEventTransport == true)
        providedServices.add("Wedding/Event Transport");
      if (service.servicesProvided!.shuttleServices == true)
        providedServices.add("Shuttle Services");
      if (service.servicesProvided!.accessibleCoachHire == true)
        providedServices.add("Accessible Coach Hire");
      if (service.servicesProvided!.other == true &&
          service.servicesProvided!.otherSpecified?.isNotEmpty == true) {
        providedServices.add(service.servicesProvided!.otherSpecified!);
      }

      if (providedServices.isNotEmpty) {
        features.add(_buildFeatureRow(
          Icons.list_alt,
          "Services: ${providedServices.join(", ")}",
          isExpandable: true,
        ));
      }
    }

    // Fleet features
    if (service.fleetInfo != null) {
      if (service.fleetInfo!.wheelchairAccessible == true) {
        features
            .add(_buildFeatureRow(Icons.accessible, "Wheelchair Accessible"));
      }
      if (service.fleetInfo!.airConditioning == true) {
        features.add(_buildFeatureRow(Icons.ac_unit, "Air Conditioning"));
      }
      if (service.fleetInfo!.luggageSpace == true) {
        features.add(_buildFeatureRow(Icons.luggage, "Luggage Space"));
      }
    }

    // Fleet size
    if (service.fleetSize != null && service.fleetSize! > 0) {
      features.add(_buildFeatureRow(
        Icons.directions_bus,
        "Fleet Size: ${service.fleetSize} vehicles",
      ));
    }

    return features;
  }

  List<Widget> _buildGeneralFeatures() {
    List<Widget> features = [];

    if (service.features != null) {
      features.addAll(_buildLimousineFeatures());
    }

    if (service.fleetInfo != null) {
      if (service.fleetInfo!.wheelchairAccessible == true) {
        features
            .add(_buildFeatureRow(Icons.accessible, "Wheelchair Accessible"));
      }
      if (service.fleetInfo!.airConditioning == true) {
        features.add(_buildFeatureRow(Icons.ac_unit, "Air Conditioning"));
      }
      if (service.fleetInfo!.luggageSpace == true) {
        features.add(_buildFeatureRow(Icons.luggage, "Luggage Space"));
      }
    }

    if (service.serviceDetails != null) {
      if (service.serviceDetails!.occasionsCatered.isNotEmpty) {
        features.add(_buildFeatureRow(
          Icons.celebration,
          "Occasions: ${service.serviceDetails!.occasionsCatered.join(", ")}",
          isExpandable: true,
        ));
      }
    }

    return features;
  }

  Widget _buildFeatureRow(IconData icon, String text,
      {bool isExpandable = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.green),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
              overflow:
                  isExpandable ? TextOverflow.visible : TextOverflow.ellipsis,
              maxLines: isExpandable ? null : 2,
            ),
          ),
        ],
      ),
    );
  }
}
