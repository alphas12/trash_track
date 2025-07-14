import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment_model.dart';
import '../repositories/admin_appointment_repository.dart';

// TEMP: until login is dynamic
const hardcodedServiceId = 'e9164d9f-b902-4e80-92f2-2972e6cb883a';

final adminAppointmentRepoProvider = Provider((ref) {
  return AdminAppointmentRepository();
});

final adminAllAppointmentsProvider =
FutureProvider<List<Appointment>>((ref) async {
  final repo = ref.read(adminAppointmentRepoProvider);
  return repo.getAppointmentsByServiceId(serviceId: hardcodedServiceId);
});

final adminPendingAppointmentsProvider =
FutureProvider<List<Appointment>>((ref) async {
  final repo = ref.read(adminAppointmentRepoProvider);
  return repo.getAppointmentsByServiceId(
    serviceId: hardcodedServiceId,
    status: AppointmentStatus.pending,
  );
});

final adminCompletedAppointmentsProvider =
FutureProvider<List<Appointment>>((ref) async {
  final repo = ref.read(adminAppointmentRepoProvider);
  return repo.getAppointmentsByServiceId(
    serviceId: hardcodedServiceId,
    status: AppointmentStatus.completed,
  );
});
