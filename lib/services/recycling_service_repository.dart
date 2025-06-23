import '../models/recycling_service.dart';

class RecyclingServiceRepository {
  // Simulate a database or API call
  Future<List<RecyclingService>> getRecommendedServices() async {
    // In a real app, this would fetch from an API
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return [
      RecyclingService(
        id: '1',
        name: 'Junkify',
        status: 'open',
        distance: 10,
        serviceTypes: ['Pick up', 'Drop off'],
        imageUrl: 'assets/images/Junkify.png',
        address: '123 Green Street',
      ),
      RecyclingService(
        id: '2',
        name: 'ReClaim',
        status: 'open',
        distance: 7,
        serviceTypes: ['Drop off'],
        imageUrl: 'assets/images/Junkify.jpg',
        address: '456 Eco Avenue',
      ),
    ];
  }

  Future<List<RecyclingService>> getNearestServices() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      RecyclingService(
        id: '3',
        name: 'Earthy',
        status: 'open',
        distance: 3,
        serviceTypes: ['Pick up', 'Drop off'],
        imageUrl: 'assets/images/earthy.jpg',
        address: '789 Recycle Road',
      ),
      RecyclingService(
        id: '4',
        name: 'EcoHub',
        status: 'closed',
        distance: 5,
        serviceTypes: ['Drop off'],
        imageUrl: 'assets/images/ecohub.jpg',
        address: '321 Sustainable Street',
      ),
    ];
  }
}
