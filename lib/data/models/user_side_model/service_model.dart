class Service {
  final String id;
  final String categoryId;
  final String subcategoryId;
  final String fromDate;
  final String toDate;
  final String capacity;
  final String serviceCities;
  final String minDistance;
  final String maxDistance;

  Service({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.fromDate,
    required this.toDate,
    required this.capacity,
    required this.serviceCities,
    required this.minDistance,
    required this.maxDistance,
  });
}