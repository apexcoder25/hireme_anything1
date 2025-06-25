class PlaceSuggestion {
  final String description;
  final String placeId;

  PlaceSuggestion({required this.description, required this.placeId});

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestion(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}

class PlaceCoordinates {
  final double lat;
  final double lng;

  PlaceCoordinates({required this.lat, required this.lng});
}

class DistanceResult {
  final double? distanceMiles;

  DistanceResult({this.distanceMiles});
}