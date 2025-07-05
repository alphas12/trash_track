import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/disposal_service.dart';
import '../repositories/disposal_service_repository.dart';

// Repository provider
final disposalServiceRepositoryProvider = Provider<DisposalServiceRepository>((
  ref,
) {
  return DisposalServiceRepository();
});

// All services provider
final allServicesProvider = FutureProvider<List<DisposalService>>((ref) async {
  final repository = ref.watch(disposalServiceRepositoryProvider);
  return repository.getAllServices();
});

// Recommended services provider (limited to 2 for dashboard)
final dashboardRecommendedServicesProvider =
    FutureProvider<List<DisposalService>>((ref) async {
      try {
        final repository = ref.watch(disposalServiceRepositoryProvider);
        print('Fetching recommended services from provider...');
        final services = await repository.getRecommendedServices();
        print('Got ${services.length} recommended services');
        if (services.isEmpty) {
          print('Warning: No recommended services returned from repository');
        }
        return services.take(2).toList();
      } catch (e, stack) {
        print('Error in recommended services provider: $e');
        print('Stack trace: $stack');
        rethrow;
      }
    });

// Top services provider (limited to 2 for dashboard)
final dashboardTopServicesProvider = FutureProvider<List<DisposalService>>((
  ref,
) async {
  try {
    final repository = ref.watch(disposalServiceRepositoryProvider);
    print('Fetching top services from provider...');
    final services = await repository.getTopServices();
    print('Got ${services.length} top services');
    if (services.isEmpty) {
      print('Warning: No top services returned from repository');
    }
    return services.take(2).toList();
  } catch (e, stack) {
    print('Error in top services provider: $e');
    print('Stack trace: $stack');
    rethrow;
  }
});

// Recommended services provider (no limit)
final recommendedServicesProvider = FutureProvider<List<DisposalService>>((
  ref,
) async {
  try {
    final repository = ref.watch(disposalServiceRepositoryProvider);
    return repository.getRecommendedServices();
  } catch (e, stack) {
    print('Error in all recommended services provider: $e');
    print('Stack trace: $stack');
    rethrow;
  }
});

// Top services provider (no limit)
final topServicesProvider = FutureProvider<List<DisposalService>>((ref) async {
  try {
    final repository = ref.watch(disposalServiceRepositoryProvider);
    return repository.getTopServices();
  } catch (e, stack) {
    print('Error in all top services provider: $e');
    print('Stack trace: $stack');
    rethrow;
  }
});

// Helper provider to check if a service is currently open
final isServiceOpenProvider = Provider.family<bool, DisposalService>((
  ref,
  service,
) {
  final now = DateTime.now();
  final currentDay = now.weekday;

  // Find today's operating hours
  final todayHours = service.operatingHours.firstWhere(
    (hours) => hours.operatingDays == currentDay,
    orElse: () => service.operatingHours.first, // Default to first if not found
  );

  if (!todayHours.isOpen) return false;

  // Parse opening and closing times
  final openingTime = _parseTimeString(todayHours.openTime);
  final closingTime = _parseTimeString(todayHours.closeTime);
  final currentTime = DateTime(
    now.year,
    now.month,
    now.day,
    now.hour,
    now.minute,
  );

  return currentTime.isAfter(openingTime) && currentTime.isBefore(closingTime);
});

// Helper function to parse time string (HH:mm) to DateTime
DateTime _parseTimeString(String timeStr) {
  final now = DateTime.now();
  final parts = timeStr.split(':');
  return DateTime(
    now.year,
    now.month,
    now.day,
    int.parse(parts[0]),
    int.parse(parts[1]),
  );
}

// Additional providers for full lists (used in their respective screens)
final allRecommendedServicesProvider = FutureProvider<List<DisposalService>>((
  ref,
) async {
  final repository = ref.watch(disposalServiceRepositoryProvider);
  return repository.getRecommendedServices();
});

final allTopServicesProvider = FutureProvider<List<DisposalService>>((
  ref,
) async {
  final repository = ref.watch(disposalServiceRepositoryProvider);
  return repository.getTopServices();
});
