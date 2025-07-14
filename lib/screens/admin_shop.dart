import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/admin_disposal_provider.dart';
import '../widgets/admin_nav_bar.dart';
import '/screens/admin_qr_scan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminShopScreen extends ConsumerStatefulWidget {
  final String serviceId;

  const AdminShopScreen({super.key, required this.serviceId});

  @override
  ConsumerState<AdminShopScreen> createState() => _AdminShopScreenState();
}

class _AdminShopScreenState extends ConsumerState<AdminShopScreen> {
  bool isEditing = false;
  final TextEditingController shopNameC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController locationC = TextEditingController();
  final TextEditingController linkC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final shopAsync = ref.watch(adminServiceProvider);

    return shopAsync.when(
      data: (shop) {
        if (shop == null) {
          return const Scaffold(
            body: Center(child: Text("Shop not found")),
          );
        }

        if (!isEditing && shopNameC.text.isEmpty) {
          shopNameC.text = shop.serviceName;
          descriptionC.text = shop.serviceDescription;
          locationC.text = shop.serviceLocation;
          linkC.text = shop.serviceImgUrl;
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Shop Management',
                style: TextStyle(
                  fontFamily: 'Mallanna',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (isEditing) {
                    await _saveChanges(context, shop.serviceId);
                  }
                  setState(() => isEditing = !isEditing);
                },
                child: Text(
                  isEditing ? 'Save' : 'Edit',
                  style: const TextStyle(
                    fontFamily: 'Mallanna',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A5F44),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Edit your Shop Details here.',
                  style: TextStyle(
                    fontFamily: 'Mallanna',
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInput('Shop Name', shopNameC),
                _buildInput('Description', descriptionC, maxLines: 3),
                _buildInput('Location', locationC),
                _buildInput('Image URL', linkC),
              ],
            ),
          ),
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
          bottomNavigationBar: AdminNavBar(currentIndex: 3),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildInput(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        enabled: isEditing,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'Mallanna'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Future<void> _saveChanges(BuildContext context, String serviceId) async {
    final supabase = Supabase.instance.client;
    await supabase.from('disposal_service').update({
      'service_name': shopNameC.text,
      'service_description': descriptionC.text,
      'service_location': locationC.text,
      'service_img': linkC.text,
    }).eq('service_id', serviceId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Shop details updated'), behavior: SnackBarBehavior.floating),
    );
  }
}
