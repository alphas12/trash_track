import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/disposal_service.dart';

class DisposalServiceRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Base query with all necessary fields and relationships
  String get _baseQuery => '''
    service_id,
    service_name,
    service_description,
    service_distance,
    service_location,
    service_img,
    service_rating,
    created_at,
    updated_at,
    service_avail,
    is_recommended,
    operating_hours (
      operating_id,
      service_id,
      operating_days,
      open_time,
      close_time,
      is_open
    ),
    service_materials (
      service_materials_id,
      disposal_service_id,
      material_points_id,
      material_points (
        material_points_id,
        material_type,
        points_per_kg
      )
    )
  ''';

  // Get all disposal services
  Future<List<DisposalService>> getAllServices() async {
    try {
      final response = await _supabase
          .from('disposal_service')
          .select(_baseQuery);

      return (response as List)
          .map((data) => DisposalService.fromMap(data))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch disposal services: $e');
    }
  }

  // Get recommended services
  Future<List<DisposalService>> getRecommendedServices() async {
    try {
      final response = await _supabase
          .from('disposal_service')
          .select(_baseQuery)
          .eq('is_recommended', true)
          .order('service_rating', ascending: false);

      return (response as List)
          .map((data) => DisposalService.fromMap(data))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch recommended services: $e');
    }
  }

  // Get top rated services
  Future<List<DisposalService>> getTopServices() async {
    try {
      final response = await _supabase
          .from('disposal_service')
          .select(_baseQuery)
          .gt('service_rating', 4.5)
          .order('service_rating', ascending: false);

      return (response as List)
          .map((data) => DisposalService.fromMap(data))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch top services: $e');
    }
  }

  // Get service by ID
  Future<DisposalService> getServiceById(String id) async {
    try {
      final response = await _supabase
          .from('disposal_service')
          .select(_baseQuery)
          .eq('service_id', id)
          .single();

      return DisposalService.fromMap(response);
    } catch (e) {
      throw Exception('Failed to fetch service: $e');
    }
  }

  // Search services by name or location
  Future<List<DisposalService>> searchServices(String query) async {
    try {
      final response = await _supabase
          .from('disposal_service')
          .select(_baseQuery)
          .or('service_name.ilike.%$query%,service_location.ilike.%$query%')
          .order('service_rating', ascending: false);

      return (response as List)
          .map((data) => DisposalService.fromMap(data))
          .toList();
    } catch (e) {
      throw Exception('Failed to search services: $e');
    }
  }
}
