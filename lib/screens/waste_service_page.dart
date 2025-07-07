// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/appointment_model.dart';
// import '../models/disposal_service.dart';
// import '../providers/appointment_provider.dart';

// class WasteServicePage extends ConsumerStatefulWidget {
//   final DisposalService service;

//   const WasteServicePage({super.key, required this.service});

//   @override
//   ConsumerState<WasteServicePage> createState() => _WasteServicePageState();
// }

// class _WasteServicePageState extends ConsumerState<WasteServicePage> {
//   AppointmentType? selectedType;
//   DateTime selectedDate = DateTime.now();
//   String? selectedMaterialType;
//   int wasteQuantity = 1;
//   String? userLocation;
//   final TextEditingController _notesController = TextEditingController();
//   bool isLoading = false;
//   String? error;

//   void _incrementQuantity() => setState(() => wasteQuantity++);

//   void _decrementQuantity() {
//     if (wasteQuantity > 0) setState(() => wasteQuantity--);
//   }

//   void _selectType(AppointmentType type) {
//     setState(() {
//       selectedType = type;
//       // Reset location for drop-off
//       if (type == AppointmentType.dropOff) {
//         userLocation = widget.service.serviceLocation;
//       }
//     });
//   }

//   Future<void> _scheduleAppointment() async {
//     if (selectedType == null) {
//       setState(() => error = 'Please select a service type');
//       return;
//     }
//     if (selectedMaterialType == null) {
//       setState(() => error = 'Please select a waste category');
//       return;
//     }
//     if (selectedType == AppointmentType.pickUp &&
//         (userLocation == null || userLocation!.isEmpty)) {
//       setState(() => error = 'Please provide a pickup address');
//       return;
//     }

//     setState(() {
//       isLoading = true;
//       error = null;
//     });

//     try {
//       // Find the service material for the selected type
//       final material = widget.service.serviceMaterials.firstWhere(
//         (m) => m.materialPoints.materialType == selectedMaterialType,
//       );

//       final appointmentData = {
//         'serviceId': widget.service.serviceId,
//         'appointmentDateTime': selectedDate,
//         'type': selectedType!,
//         'address': selectedType == AppointmentType.pickUp
//             ? userLocation
//             : widget.service.serviceLocation,
//         'notes': _notesController.text.trim(),
//         'wasteMaterials': [
//           {
//             'material_type': selectedMaterialType,
//             'quantity': wasteQuantity,
//             'points': (material.materialPoints.pointsPerKg * wasteQuantity)
//                 .toInt(),
//           },
//         ],
//       };

//       final appointment = await ref.read(
//         createAppointmentProvider(appointmentData).future,
//       );

//       if (mounted) {
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Appointment scheduled successfully!')),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         error = 'Failed to schedule appointment: $e';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               const SizedBox(height: 10),
//               _buildServiceSelector(),
//               const Divider(height: 30),
//               _buildWasteDetails(),
//               const Divider(height: 30),
//               selectedType == AppointmentType.pickUp
//                   ? _buildPickupDetails()
//                   : _buildDropoffDetails(),
//               const Divider(height: 30),
//               _buildAdditionalNotes(),
//               const Divider(height: 30),
//               _buildWasteSummary(),
//               if (error != null)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Text(
//                     error!,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ),
//               const SizedBox(height: 20),
//               _buildBottomSummary(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _clearForm() {
//     setState(() {
//       selectedType = null;
//       selectedDate = DateTime.now();
//       selectedMaterialType = null;
//       wasteQuantity = 1;
//       userLocation = null;
//       _notesController.clear();
//       error = null;
//     });
//   }

//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         TextButton(onPressed: _clearForm, child: const Text("Clear data")),
//       ],
//     );
//   }

//   Widget _buildServiceSelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Service",
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         const Text("Please select a type of service"),
//         const SizedBox(height: 10),
//         Row(
//           children:
//               widget.service.serviceAvailability.contains('pickup') &&
//                   widget.service.serviceAvailability.contains('dropoff')
//               ? [
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: selectedType == AppointmentType.pickUp
//                             ? const Color(0xFF4B5320)
//                             : Colors.grey[300],
//                         foregroundColor: selectedType == AppointmentType.pickUp
//                             ? Colors.white
//                             : Colors.black,
//                       ),
//                       onPressed: () => _selectType(AppointmentType.pickUp),
//                       child: const Text("Pick up"),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: selectedType == AppointmentType.dropOff
//                             ? const Color(0xFF4B5320)
//                             : Colors.grey[300],
//                         foregroundColor: selectedType == AppointmentType.dropOff
//                             ? Colors.white
//                             : Colors.black,
//                       ),
//                       onPressed: () => _selectType(AppointmentType.dropOff),
//                       child: const Text("Drop off"),
//                     ),
//                   ),
//                 ]
//               : widget.service.serviceAvailability.contains('pickup')
//               ? [
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: selectedType == AppointmentType.pickUp
//                             ? const Color(0xFF4B5320)
//                             : Colors.grey[300],
//                         foregroundColor: selectedType == AppointmentType.pickUp
//                             ? Colors.white
//                             : Colors.black,
//                       ),
//                       onPressed: () => _selectType(AppointmentType.pickUp),
//                       child: const Text("Pick up"),
//                     ),
//                   ),
//                 ]
//               : [
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: selectedType == AppointmentType.dropOff
//                             ? const Color(0xFF4B5320)
//                             : Colors.grey[300],
//                         foregroundColor: selectedType == AppointmentType.dropOff
//                             ? Colors.white
//                             : Colors.black,
//                       ),
//                       onPressed: () => _selectType(AppointmentType.dropOff),
//                       child: const Text("Drop off"),
//                     ),
//                   ),
//                 ],
//         ),
//       ],
//     );
//   }

//   Widget _buildWasteDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Waste Details",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         const Text(
//           "Input details of your waste—select a category and indicate the quantity or the amount of bags.",
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             Expanded(
//               child: DropdownButtonFormField<String>(
//                 value: selectedMaterialType,
//                 items: widget.service.serviceMaterials
//                     .map(
//                       (material) => DropdownMenuItem(
//                         value: material.materialPoints.materialType,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(material.materialPoints.materialType),
//                             Text(
//                               '${material.materialPoints.pointsPerKg} pts/kg',
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                     .toList(),
//                 onChanged: (val) => setState(() => selectedMaterialType = val),
//                 decoration: const InputDecoration(
//                   filled: true,
//                   fillColor: Color(0xFFF0F0F0),
//                   border: OutlineInputBorder(borderSide: BorderSide.none),
//                   hintText: 'Select waste type',
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             SizedBox(
//               width: 60,
//               child: TextFormField(
//                 initialValue: wasteQuantity.toString(),
//                 readOnly: true,
//                 textAlign: TextAlign.center,
//                 decoration: const InputDecoration(
//                   filled: true,
//                   fillColor: Color(0xFFF0F0F0),
//                   border: OutlineInputBorder(borderSide: BorderSide.none),
//                 ),
//               ),
//             ),
//             IconButton(
//               onPressed: _decrementQuantity,
//               icon: const Icon(Icons.remove),
//             ),
//             IconButton(
//               onPressed: _incrementQuantity,
//               icon: const Icon(Icons.add),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildPickupDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Pick up Details",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         _buildCalendarSection(),
//         const SizedBox(height: 15),
//         const Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 5),
//         Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFFF0F0F0),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: [
//               TextField(
//                 onChanged: (value) => setState(() => userLocation = value),
//                 decoration: const InputDecoration(
//                   icon: Icon(Icons.location_on),
//                   hintText: 'Enter pickup address',
//                   border: InputBorder.none,
//                 ),
//                 maxLines: null,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Pick up Fee", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Cost"),
//           ],
//         ),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Php 50.00 / service"),
//             Text("${(50.00).toStringAsFixed(2)}"),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildDropoffDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Drop Off Details",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         _buildCalendarSection(),
//       ],
//     );
//   }

//   Widget _buildCalendarSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Date & Time",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: const Color(0xFFF0F0F0),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             children: [
//               TextButton(
//                 onPressed: () async {
//                   final date = await showDatePicker(
//                     context: context,
//                     initialDate: selectedDate,
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime.now().add(const Duration(days: 30)),
//                   );
//                   if (date != null) {
//                     final time = await showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay.fromDateTime(selectedDate),
//                     );
//                     if (time != null) {
//                       setState(() {
//                         selectedDate = DateTime(
//                           date.year,
//                           date.month,
//                           date.day,
//                           time.hour,
//                           time.minute,
//                         );
//                       });
//                     }
//                   }
//                 },
//                 child: Text(
//                   '${selectedDate.toString().split('.')[0]}',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAdditionalNotes() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Additional Notes",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         const Text("Leave any additional instructions or preferences."),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: _notesController,
//           maxLines: 2,
//           decoration: const InputDecoration(
//             hintText: "ex. Bags are found at the front of the yard.",
//             filled: true,
//             fillColor: Color(0xFFF0F0F0),
//             border: OutlineInputBorder(borderSide: BorderSide.none),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildWasteSummary() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Waste Summary",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         const Text(
//           "Below is a summary of your entered waste information. You can update or edit it above.",
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: const [
//             Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(selectedMaterialType ?? 'Not selected'),
//             Text(wasteQuantity.toString()),
//           ],
//         ),
//         const SizedBox(height: 10),
//         if (selectedType == AppointmentType.pickUp && userLocation != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Address: $userLocation"),
//                 Text("Pick Up Date: ${selectedDate.toString().split('.')[0]}"),
//               ],
//             ),
//           ),
//         if (selectedType == AppointmentType.dropOff)
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Drop-off Location: ${widget.service.serviceLocation}"),
//                 Text("Drop-off Date: ${selectedDate.toString().split('.')[0]}"),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildBottomSummary() {
//     // Calculate total points for the selected material
//     int totalPoints = 0;
//     if (selectedMaterialType != null) {
//       final material = widget.service.serviceMaterials.firstWhere(
//         (m) => m.materialPoints.materialType == selectedMaterialType,
//       );
//       totalPoints = (material.materialPoints.pointsPerKg * wasteQuantity)
//           .toInt();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               "Total Points:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text('$totalPoints points'),
//           ],
//         ),
//         const SizedBox(height: 8),
//         if (selectedType == AppointmentType.pickUp) ...[
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Service Fee:",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text('₱50.00'),
//             ],
//           ),
//           const SizedBox(height: 8),
//         ],
//         ElevatedButton(
//           onPressed: isLoading ? null : _scheduleAppointment,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF4B5320),
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child: isLoading
//               ? const SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: CircularProgressIndicator(color: Colors.white),
//                 )
//               : const Text(
//                   "Schedule",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//         ),
//         const SizedBox(height: 30),
//       ],
//     );
//   }
// }
