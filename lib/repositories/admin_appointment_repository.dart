import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/appointment_model.dart';

class AdminAppointmentRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Appointment>> getAppointmentsByServiceId({
    required String serviceId,
    AppointmentStatus? status,
  }) async {
    final query = _supabase
        .from('appointment_info')
        .select('*')
        .eq('service_id', serviceId);

    query.eq(
      'appointment_status',
      status.toString().split('.').last[0].toUpperCase() +
          status.toString().split('.').last.substring(1),
    );

    query.order('appointment_date', ascending: false);

    final result = await query;

    final response = await query;
    print('Raw appointment data: ${response}');

    return (result as List)
        .map((e) => Appointment.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}