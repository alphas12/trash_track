import 'appointment_waste.dart';

enum AppointmentStatus { pending, confirmed, completed, cancelled }

enum AppointmentType { pickUp, dropOff }

class DriverInfo {
  final String name;
  final String phone;
  final String vehicleInfo;

  const DriverInfo({
    required this.name,
    required this.phone,
    required this.vehicleInfo,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'vehicle_info': vehicleInfo,
  };

  factory DriverInfo.fromMap(Map<String, dynamic> map) => DriverInfo(
    name: map['name'] ?? 'John Doe', // Mock data
    phone: map['phone'] ?? '+1 234-567-8900', // Mock data
    vehicleInfo: map['vehicle_info'] ?? 'Truck #123', // Mock data
  );
}

class Appointment {
  final String? appointmentInfoId;
  final String userInfoId;
  final String serviceId;
  final AppointmentType appointmentType;
  final String? availSchedId;
  final DateTime appointmentDate;
  final DateTime? appointmentCreateDate;
  final DateTime? appointmentConfirmDate;
  final DateTime? appointmentCancelDate;
  final String appointmentLocation;
  final AppointmentStatus appointmentStatus;
  final String? appointmentNotes;
  final double? appointmentPriceFee;
  final List<AppointmentWaste> wasteMaterials;
  final String? qrCodeData; // New field for QR code data
  final DriverInfo? driverInfo; // New field for driver info

  const Appointment({
    this.appointmentInfoId,
    required this.userInfoId,
    required this.serviceId,
    required this.appointmentType,
    this.availSchedId,
    required this.appointmentDate,
    this.appointmentCreateDate,
    this.appointmentConfirmDate,
    this.appointmentCancelDate,
    required this.appointmentLocation,
    required this.appointmentStatus,
    this.appointmentNotes,
    this.appointmentPriceFee,
    this.wasteMaterials = const [],
    this.qrCodeData,
    this.driverInfo,
  });

  Map<String, dynamic> toMap() => {
    'appointment_info_id': appointmentInfoId,
    'user_info_id': userInfoId,
    'service_id': serviceId,
    'appointment_type': appointmentType == AppointmentType.pickUp
        ? 'Pick-Up'
        : 'Drop-Off',
    'avail_sched_id': availSchedId,
    'appointment_date': appointmentDate.toIso8601String(),
    'appointment_create_date': appointmentCreateDate?.toIso8601String(),
    'appointment_confirm_date': appointmentConfirmDate?.toIso8601String(),
    'appointment_cancel_date': appointmentCancelDate?.toIso8601String(),
    'appointment_location': appointmentLocation,
    'appointment_status': appointmentStatus.toString().split('.').last,
    'appointment_notes': appointmentNotes,
    'appointment_price_fee': appointmentPriceFee,
    'appoinrment_qr_code': qrCodeData,
  };

  factory Appointment.fromMap(Map<String, dynamic> map) => Appointment(
    appointmentInfoId: map['appointment_info_id'],
    userInfoId: map['user_info_id'],
    serviceId: map['service_id'], // service_id is a String
    appointmentType: map['appointment_type'] == 'Pick-Up'
        ? AppointmentType.pickUp
        : AppointmentType.dropOff,
    availSchedId: map['avail_sched_id'],
    appointmentDate: DateTime.parse(map['appointment_date']),
    appointmentCreateDate: map['appointment_create_date'] != null
        ? DateTime.parse(map['appointment_create_date'])
        : null,
    appointmentConfirmDate: map['appointment_confirm_date'] != null
        ? DateTime.parse(map['appointment_confirm_date'])
        : null,
    appointmentCancelDate: map['appointment_cancel_date'] != null
        ? DateTime.parse(map['appointment_cancel_date'])
        : null,
    appointmentLocation: map['appointment_location'],
    appointmentStatus: AppointmentStatus.values.firstWhere(
      (e) => e.toString().split('.').last == map['appointment_status'],
      orElse: () => AppointmentStatus.pending,
    ),
    appointmentNotes: map['appointment_notes'],
    appointmentPriceFee: map['appointment_price_fee'] != null
        ? (map['appointment_price_fee'] as num).toDouble()
        : null,
    wasteMaterials: map['appointment_trash'] != null
        ? (map['appointment_trash'] as List)
              .map((w) => AppointmentWaste.fromMap(w as Map<String, dynamic>))
              .toList()
        : [],
    qrCodeData: map['qr_code_data'],
    driverInfo: map['driver_info'] != null
        ? DriverInfo.fromMap(map['driver_info'])
        : null,
  );
}
