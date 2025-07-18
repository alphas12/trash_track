import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/admin_nav_bar.dart';
import '/screens/admin_qr_scan.dart';
import '../providers/admin_appointment_provider.dart';
import 'package:intl/intl.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAppointments = ref.watch(adminPendingAppointmentsProvider);

    return Scaffold(
      floatingActionButton: Container(
        height: 70,
        width: 70,
        margin: const EdgeInsets.only(top: 20),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminQRScanScreen()),
            );
          },
          backgroundColor: const Color(0xFF4A5F44),
          shape: const CircleBorder(),
          elevation: 4,
          child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const AdminNavBar(currentIndex: 0),
      body: SafeArea(
        child: Column(
          children: [
            // Sticky Header
            Container(
              height: 240,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF4A5F44),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Opacity(
                      opacity: 1,
                      child: Image.asset(
                        'assets/images/admin_banner.png',
                        height: 280,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 24.0,
                    top: 32.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, admin!',
                          style: TextStyle(
                            fontFamily: 'Mallanna',
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFEFAE0),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Remember, every scan helps\nbuild a cleaner, greener future.',
                          style: TextStyle(
                            fontFamily: 'Mallanna',
                            fontSize: 16,
                            color: Color(0xFFFEFAE0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable appointments below
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mallanna',
                      ),
                    ),
                    const SizedBox(height: 8),
                    asyncAppointments.when(
                      data: (appointments) {
                        if (appointments.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 24.0),
                            child: Center(
                              child: Text(
                                'No pending appointments today.',
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: appointments.length,
                          itemBuilder: (context, index) {
                            final appointment = appointments[index];
                            final formattedDate = DateFormat('MMMM d, h:mm a').format(
                              appointment.appointmentDate,
                            );
                            return TaskCard(
                              id: appointment.appointmentInfoId ?? '-',
                              user: appointment.userInfoId,
                              datetime: formattedDate,
                              status: appointment.appointmentStatus.name,
                            );
                          },
                        );
                      },
                      loading: () => const Padding(
                        padding: EdgeInsets.only(top: 32.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (err, stack) => Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Center(
                          child: Text(
                            'Error loading appointments: $err',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String id;
  final String user;
  final String datetime;
  final String status;

  const TaskCard({
    super.key,
    required this.id,
    required this.user,
    required this.datetime,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
    status.toLowerCase() == 'completed' ? Colors.green[100]! : Colors.orange[100]!;
    final Color textColor =
    status.toLowerCase() == 'completed' ? Colors.green[800]! : Colors.orange[800]!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: $id', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Name: $user', style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                Text('Time: $datetime', style: const TextStyle(fontSize: 14)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
