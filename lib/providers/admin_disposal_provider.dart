import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/disposal_service.dart';
import '../repositories/admin_disposal_repository.dart';

final adminServiceProvider = FutureProvider<DisposalService>((ref) async {
  final repo = ref.read(adminDisposalRepositoryProvider);
  return await repo.getServiceById('e9164d9f-b902-4e80-92f2-2972e6cb883a');
});

final adminUpdateServiceProvider = Provider<Future<void> Function(Map<String, dynamic>)>((ref) {
  final repo = ref.read(adminDisposalRepositoryProvider);
  return (patch) => repo.updateService('e9164d9f-b902-4e80-92f2-2972e6cb883a', patch);
});

final adminDisposalRepositoryProvider = Provider<AdminDisposalRepository>((ref) {
  return AdminDisposalRepository();
});