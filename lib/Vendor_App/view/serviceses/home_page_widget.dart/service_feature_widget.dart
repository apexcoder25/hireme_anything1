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
    switch (service.serviceType.toLowerCase()) {
      case 'boat':
        return service.features != null || service.areasCovered?.isNotEmpty == true || service.boatType != null;
      case 'horse':
        return service.carriageDetails != null;
      case 'funeral':
        return service.fleetDetails != null || service.serviceDetail != null;
      case 'minibus':
        return service.fleetInfo != null;
      case 'limousine':
      case 'chauffeur':
        return service.fleetInfo != null || service.features != null;
      case 'coach':
        return service.fleetInfo != null || service.fleetDetails != null;
      default:
        return service.fleetInfo != null || 
               service.fleetDetails != null || 
               service.carriageDetails != null ||
               service.features != null;
    }
  }

  List<Widget> _buildServiceFeatures() {
    switch (service.serviceType.toLowerCase()) {
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
      case 'chauffeur':
        return _buildChauffeurFeatures();
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

    if (service.boatType != null) {
      features.add(_buildFeatureRow(Icons.sailing, "Boat Type: ${service.boatType}"));
    }

    if (service.hireType != null) {
      features.add(_buildFeatureRow(Icons.badge, "Hire Type: ${service.hireType!.replaceAll('-', ' ').toUpperCase()}"));
    }

    if (service.seats != null && service.seats! > 0) {
      features.add(_buildFeatureRow(Icons.event_seat, "Seats: ${service.seats} passengers"));
    }

    // Features from service.features
    if (service.features != null) {
      if (service.features!.airConditioning == true) {
        features.add(_buildFeatureRow(Icons.ac_unit, "Air Conditioning"));
      }
      if (service.features!.wifi == true) {
        features.add(_buildFeatureRow(Icons.wifi, "WiFi Available"));
      }
      if (service.features!.tv == true) {
        features.add(_buildFeatureRow(Icons.tv, "Television"));
      }
      if (service.features!.toilet == true) {
        features.add(_buildFeatureRow(Icons.wc, "Toilet Facilities"));
      }
      if (service.features!.musicSystem == true) {
        features.add(_buildFeatureRow(Icons.music_note, "Music System"));
      }
      if (service.features!.cateringFacilities == true) {
        features.add(_buildFeatureRow(Icons.restaurant, "Catering Facilities"));
      }
      if (service.features!.sunDeck == true) {
        features.add(_buildFeatureRow(Icons.wb_sunny, "Sun Deck"));
      }
      if (service.features!.overnightStayCabins == true) {
        features.add(_buildFeatureRow(Icons.hotel, "Overnight Stay Cabins"));
      }
    }

    if (service.luggageCapacity != null) {
      int totalLuggage = service.luggageCapacity!.largeSuitcases + 
                        service.luggageCapacity!.mediumSuitcases + 
                        service.luggageCapacity!.smallSuitcases;
      if (totalLuggage > 0) {
        features.add(_buildFeatureRow(Icons.luggage, "Luggage Capacity: $totalLuggage suitcases"));
      }
    }

    if (service.serviceCoverage?.isNotEmpty == true) {
      features.add(_buildFeatureRow(
        Icons.location_on,
        "Service Coverage: ${service.serviceCoverage!.length} areas",
      ));
    }

    return features;
  }

  List<Widget> _buildHorseFeatures() {
    List<Widget> features = [];

    if (service.carriageDetails != null) {
      features.add(_buildFeatureRow(
        Icons.directions_car,
        "Carriage Type: ${service.carriageDetails!.carriageType}",
      ));

      features.add(_buildFeatureRow(
        Icons.pets,
        "Horse Breeds: ${service.carriageDetails!.horseBreeds.join(", ")}",
        isExpandable: true,
      ));

      features.add(_buildFeatureRow(
        Icons.palette,
        "Horse Colors: ${service.carriageDetails!.horseColors.join(", ")}",
        isExpandable: true,
      ));

      features.add(_buildFeatureRow(
        Icons.event_seat,
        "Seats Available: ${service.carriageDetails!.seats}",
      ));

      if (service.carriageDetails!.decorationOptions.isNotEmpty) {
        features.add(_buildFeatureRow(
          Icons.celebration,
          "Decoration Options: ${service.carriageDetails!.decorationOptions.join(", ")}",
          isExpandable: true,
        ));
      }

      features.add(_buildFeatureRow(
        Icons.numbers,
        "Number of Carriages: ${service.carriageDetails!.numberOfCarriages}",
      ));

      features.add(_buildFeatureRow(
        Icons.pets,
        "Horse Count: ${service.carriageDetails!.horseCount}",
      ));
    }

    return features;
  }

  List<Widget> _buildFuneralFeatures() {
    List<Widget> features = [];

    if (service.serviceDetail != null) {
      if (service.serviceDetail!.worksWithFuneralDirectors) {
        features.add(_buildFeatureRow(Icons.business, "Works with Funeral Directors"));
      }

      if (service.serviceDetail!.supportsAllFuneralTypes) {
        features.add(_buildFeatureRow(Icons.support, "Supports All Funeral Types"));
      }

      features.add(_buildFeatureRow(
        Icons.category,
        "Service Type: ${service.serviceDetail!.funeralServiceType}",
      ));
    }

    if (service.fleetDetails != null) {
      features.add(_buildFeatureRow(
        Icons.directions_car,
        "Vehicle: ${service.fleetDetails!.makeModel} (${service.fleetDetails!.year.year})",
      ));

      features.add(_buildFeatureRow(
        Icons.event_seat,
        "Capacity: ${service.fleetDetails!.seats} passengers",
      ));
    }

    return features;
  }

  List<Widget> _buildMinibusFeatures() {
    List<Widget> features = [];

    if (service.fleetInfo != null) {
      features.add(_buildFeatureRow(
        Icons.directions_bus,
        "Vehicle: ${service.fleetInfo!.makeAndModel}",
      ));

      features.add(_buildFeatureRow(
        Icons.event_seat,
        "Seats: ${service.fleetInfo!.seats} passengers",
      ));

      if (service.fleetInfo!.airConditioning == true) {
        features.add(_buildFeatureRow(Icons.ac_unit, "Air Conditioning"));
      }

      if (service.fleetInfo!.wheelchairAccessible == true) {
        features.add(_buildFeatureRow(Icons.accessible, "Wheelchair Accessible"));
      }

      if (service.fleetInfo!.luggageSpace == true) {
        features.add(_buildFeatureRow(Icons.luggage, "Luggage Space"));
      }

      features.add(_buildFeatureRow(
        Icons.luggage,
        "Luggage Capacity: ${service.fleetInfo!.luggageCapacity}",
      ));
    }

    return features;
  }

  List<Widget> _buildLimousineFeatures() {
    List<Widget> features = [];

    if (service.fleetInfo != null) {
      features.add(_buildFeatureRow(
        Icons.directions_car,
        "Luxury Vehicle: ${service.fleetInfo!.makeAndModel}",
      ));

      features.add(_buildFeatureRow(
        Icons.event_seat,
        "Seats: ${service.fleetInfo!.seats} passengers",
      ));

      if (service.fleetInfo!.airConditioning == true) {
        features.add(_buildFeatureRow(Icons.ac_unit, "Climate Control"));
      }

      if (service.fleetInfo!.wheelchairAccessible == true) {
        features.add(_buildFeatureRow(Icons.accessible, "Wheelchair Accessible"));
      }

      features.add(_buildFeatureRow(
        Icons.luggage,
        "Luggage Capacity: ${service.fleetInfo!.luggageCapacity}",
      ));

      if (service.fleetInfo!.largeSuitcases != null && service.fleetInfo!.largeSuitcases! > 0) {
        features.add(_buildFeatureRow(
          Icons.luggage,
          "Large Suitcases: ${service.fleetInfo!.largeSuitcases}",
        ));
      }
    }

    return features;
  }

  List<Widget> _buildChauffeurFeatures() {
    List<Widget> features = [];

    features.add(_buildFeatureRow(
      Icons.person,
      "Professional Chauffeur Service",
    ));

    if (service.fleetInfo != null) {
      features.add(_buildFeatureRow(
        Icons.directions_car,
        "Vehicle: ${service.fleetInfo!.makeAndModel}",
      ));

      features.add(_buildFeatureRow(
        Icons.event_seat,
        "Seats: ${service.fleetInfo!.seats} passengers",
      ));

      if (service.fleetInfo!.airConditioning == true) {
        features.add(_buildFeatureRow(Icons.ac_unit, "Climate Control"));
      }

      if (service.fleetInfo!.wheelchairAccessible == true) {
        features.add(_buildFeatureRow(Icons.accessible, "Wheelchair Accessible"));
      }
    }

    return features;
  }

  List<Widget> _buildCoachFeatures() {
    List<Widget> features = [];

    if (service.fleetInfo != null) {
      features.add(_buildFeatureRow(
        Icons.directions_bus,
        "Coach: ${service.fleetInfo!.makeAndModel}",
      ));

      features.add(_buildFeatureRow(
        Icons.event_seat,
        "Seats: ${service.fleetInfo!.seats} passengers",
      ));

      if (service.fleetInfo!.airConditioning == true) {
        features.add(_buildFeatureRow(Icons.ac_unit, "Air Conditioning"));
      }

      if (service.fleetInfo!.wheelchairAccessible == true) {
        features.add(_buildFeatureRow(Icons.accessible, "Wheelchair Accessible"));
      }

      features.add(_buildFeatureRow(
        Icons.luggage,
        "Luggage Capacity: ${service.fleetInfo!.luggageCapacity}",
      ));
    } else if (service.fleetDetails != null) {
      features.add(_buildFeatureRow(
        Icons.directions_bus,
        "Coach: ${service.fleetDetails!.makeModel} (${service.fleetDetails!.year.year})",
      ));

      features.add(_buildFeatureRow(
        Icons.event_seat,
        "Seats: ${service.fleetDetails!.seats} passengers",
      ));
    }

    return features;
  }

  List<Widget> _buildGeneralFeatures() {
    List<Widget> features = [];

    if (service.fleetInfo != null) {
      features.add(_buildFeatureRow(
        Icons.directions_car,
        "Vehicle: ${service.fleetInfo!.makeAndModel}",
      ));

      features.add(_buildFeatureRow(
        Icons.event_seat,
        "Capacity: ${service.fleetInfo!.seats} passengers",
      ));

      if (service.fleetInfo!.airConditioning == true) {
        features.add(_buildFeatureRow(Icons.ac_unit, "Air Conditioning"));
      }

      if (service.fleetInfo!.wheelchairAccessible == true) {
        features.add(_buildFeatureRow(Icons.accessible, "Wheelchair Accessible"));
      }
    } else if (service.fleetDetails != null) {
      features.add(_buildFeatureRow(
        Icons.directions_car,
        "Vehicle: ${service.fleetDetails!.makeModel}",
      ));

      features.add(_buildFeatureRow(
        Icons.event_seat,
        "Capacity: ${service.fleetDetails!.seats} passengers",
      ));
    } else if (service.carriageDetails != null) {
      features.add(_buildFeatureRow(
        Icons.directions_car,
        "Carriage: ${service.carriageDetails!.carriageType}",
      ));

      features.add(_buildFeatureRow(
        Icons.event_seat,
        "Seats: ${service.carriageDetails!.seats}",
      ));
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
            decoration: BoxDecoration(
              color: Colors.yellow.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              size: 16,
              color: Colors.yellow.shade700,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
              maxLines: isExpandable ? null : 2,
              overflow: isExpandable ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}