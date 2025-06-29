class Appointment {
  final String id;
  final String datetime;
  final String location;
  final String type;
  final String status;
  final String wasteDetails;
  final String notes;
  final String? address;
  final String? phone;
  final String? driverName;
  final String? driverNumber;

  Appointment({
    required this.id,
    required this.datetime,
    required this.location,
    required this.type,
    required this.status,
    required this.wasteDetails,
    required this.notes,
    this.address,
    this.phone,
    this.driverName,
    this.driverNumber,
  });
}
