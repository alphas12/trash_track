class RecyclingService {
  final String id;
  final String name;
  final double distance;
  final String status;
  final String imageUrl;
  final String address;
  final List<String> serviceTypes;
  final bool isFavorite;

  RecyclingService({
    required this.id,
    required this.name,
    required this.distance,
    required this.status,
    required this.imageUrl,
    required this.address,
    required this.serviceTypes,
    this.isFavorite = false,
  });

  // Helper method to get formatted distance
  String get formattedDistance => '${distance.toStringAsFixed(0)}km';
}
