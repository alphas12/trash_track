import 'package:flutter/material.dart';
import 'package:trash_track/screens/qr_confirmation_page.dart';

class AppointmentDetailsPage extends StatelessWidget {
  final Map<String, String?> appointment;

  const AppointmentDetailsPage({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final isPickup = appointment["type"] == "Pick Up";
    final id = appointment["id"] ?? "N/A";

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Text(
                isPickup
                    ? "Waste Pick Up to ReClaim"
                    : "Waste Drop-off at Junkify",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4B5320)),
              ),
              const SizedBox(height: 6),
              Text(
                isPickup
                    ? "on Wednesday at 12:00 P.M."
                    : "Today at 09:00 A.M.",
              ),
              const SizedBox(height: 10),
              _buildStatusChip(isPickup ? "N/A" : "Pending"),
              const SizedBox(height: 10),
              _buildInfoRow("Waste Details:", "12 pcs. of plastic bottles"),
              _buildInfoRow("Additional Note:",
                  isPickup ? "Placed on the front gate..." : "None"),
              if (isPickup) ...[
                _buildInfoRow("Pick Up Address:",
                    "123 Street, Barangay ABC, Cebu City"),
                _buildInfoRow("Mobile Number:", "09123456789"),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Driver Name: Trash Track"),
                      Text("Driver Number: 0987654321"),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QRConfirmationPage(appointmentId: "1"), // 1 is a placeholder
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B5320),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            // Navigate to edit form
          },
        ),
      ],
    );
  }

  Widget _buildStatusChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: label == "Pending" ? Colors.yellow[700] : Colors.black26,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }

  Widget _buildInfoRow(String label, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
                text: "$label\n",
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            TextSpan(text: content, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
