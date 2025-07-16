import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment_model.dart';
import '../repositories/admin_appointment_repository.dart';
import 'auth_provider.dart'; // Assumes you have this
import 'admin_disposal_provider.dart'; // Where service_id is fetched
import 'package:supabase_flutter/supabase_flutter.dart';

final adminAppointmentRepoProvider = Provider((ref) {
  return AdminAppointmentRepository();
});

final adminAllAppointmentsProvider = FutureProvider<List<Appointment>>((ref) async {
  final repo = ref.read(adminAppointmentRepoProvider);

  final serviceAsync = await ref.watch(adminServiceProvider.future);
  if (serviceAsync == null || serviceAsync.serviceId.isEmpty) {
    throw Exception('No service_id found for admin');
  }

  return repo.getAppointmentsByServiceId(serviceId: serviceAsync.serviceId);
});

// final adminPendingAppointmentsProvider = FutureProvider<List<Appointment>>((ref) async {
//   final repo = ref.read(adminAppointmentRepoProvider);
//
//   final serviceAsync = await ref.watch(adminServiceProvider.future);
//   if (serviceAsync == null || serviceAsync.serviceId.isEmpty) {
//     throw Exception('No service_id found for admin');
//   }
//
//   return repo.getAppointmentsByServiceId(
//     serviceId: serviceAsync.serviceId,
//     status: AppointmentStatus.pending,
//   );
// });

final adminCompletedAppointmentsProvider = FutureProvider<List<Appointment>>((ref) async {
  final repo = ref.read(adminAppointmentRepoProvider);

  final serviceAsync = await ref.watch(adminServiceProvider.future);
  if (serviceAsync == null || serviceAsync.serviceId.isEmpty) {
    throw Exception('No service_id found for admin');
  }

  return repo.getAppointmentsByServiceId(
    serviceId: serviceAsync.serviceId,
    status: AppointmentStatus.completed,
  );
});

final adminPendingAppointmentsProvider =
FutureProvider<List<Appointment>>((ref) async {
  final service = await ref.read(adminServiceProvider.future);
  final repo = ref.read(adminAppointmentRepoProvider);

  print('📌 [AppointmentProvider] Using serviceId: ${service.serviceId}');

  final appointments = await repo.getAppointmentsByServiceId(
    serviceId: service.serviceId,
    status: AppointmentStatus.pending,
  );

  print('📌 [AppointmentProvider] Appointments fetched: ${appointments.length}');
  return appointments;
});

final testRawAppointmentProvider = FutureProvider((ref) async {
  final service = await ref.read(adminServiceProvider.future);
  final supabase = Supabase.instance.client;

  final data = await supabase
      .from('appointment_info')
      .select()
      .eq('service_id', service.serviceId)
      .eq('appointment_status', 'Pending');

  print('🧪 [Raw Test] Data fetched: ${data.length}');
  return data;
});
