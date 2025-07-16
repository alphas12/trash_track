import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/appointment_model.dart';

class AdminAppointmentRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Map enum → exact text stored in the DB
  static const _statusMap = {
    AppointmentStatus.pending   : 'Pending',
    AppointmentStatus.confirmed : 'Confirmed',
    AppointmentStatus.completed : 'Completed',
    AppointmentStatus.cancelled : 'Cancelled',
  };

  Future<List<Appointment>> getAppointmentsByServiceId({
    required String serviceId,
    AppointmentStatus? status,
  }) async {
    final query = _supabase
        .from('appointment_info')
        .select('*')
        .eq('service_id', serviceId); // ✅ this is now correct

    if (status != null) {
      final statusValue = status.toString().split('.').last;
      final capitalized = statusValue[0].toUpperCase() + statusValue.substring(1);
      query.eq('appointment_status', capitalized);
    }

    query.order('appointment_date', ascending: false);

    final response = await query;

    print('📌 Fetched ${response.length} appointments');
    for (final appt in response) {
      print('🟢 ID: ${appt['appointment_info_id']} | Status: ${appt['appointment_status']}');
    }

    return (response as List)
        .map((e) => Appointment.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}