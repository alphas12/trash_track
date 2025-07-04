import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'appointment_details_page.dart'; // Make sure this exists and accepts a Map<String, String?>

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appointments = [
      {
        "id": "A123",
        "datetime": "Today at 09:00 A.M.",
        "location": "Junkify",
        "type": "Drop-Off",
        "status": "Pending",
        "waste": "12 pcs. of plastic bottles",
        "notes": "None",
      },
      {
        "id": "B456",
        "datetime": "Wednesday at 12:00 P.M.",
        "location": "ReClaim",
        "type": "Pick Up",
        "status": "N/A",
        "waste": "12 pcs. of plastic bottles",
        "notes": "Placed on the front gate.",
        "address": "123 Street, Barangay ABC, Cebu City",
        "phone": "09123456789",
        "driverName": "Trash Track",
        "driverNumber": "0987654321",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {
              // Future: Go to history
            },
            child: const Text("History"),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appt = appointments[index];
          final isPickup = appt["type"] == "Pick Up";

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AppointmentDetailsPage(appointment: appt),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: isPickup ? Colors.grey[200] : const Color(0xFFCDD6AA),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appt["datetime"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("at ${appt["location"]}"),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        label: Text(appt["status"]!),
                        backgroundColor: appt["status"] == "Pending"
                            ? Colors.yellow[600]
                            : Colors.grey,
                        labelStyle: const TextStyle(fontSize: 12),
                      ),
                      Chip(
                        label: Text(appt["type"]!),
                        backgroundColor: isPickup ? Colors.black45 : Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: isPickup ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text("Waste Details: ${appt["waste"]}"),
                  if (isPickup)
                    const Text("To be picked up by Trash Track."),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1, // or whatever index you assign to WasteService
        onTap: (int newIndex) {
          // Already handled by the onTap inside the CustomBottomNavBar
        },
      ),
    );
  }
}
