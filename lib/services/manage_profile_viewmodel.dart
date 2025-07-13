import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ManageProfileViewModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final Ref ref;
  ManageProfileViewModel(this.ref);
  
  bool _isChanged = false;
  bool get isChanged => _isChanged;

  void setChanged(bool value) {
      _isChanged = value;
      notifyListeners();
  }


  Future<void> fetchUserInfo() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    final response = await _client
        .from('user_credentials')
        .select('user_info_id')
        .eq('user_cred_id', userId)
        .maybeSingle();

    final userInfoId = response!['user_info_id'];

    final info = await _client
        .from('user_info')
        .select()
        .eq('user_info_id', userInfoId)
        .maybeSingle();

    fnameController.text = info!['user_fname'] ?? '';
    lnameController.text = info!['user_lname'] ?? '';
    contactController.text = info!['user_phone_num'] ?? '';
    locationController.text = info!['user_location'] ?? '';
    notifyListeners();
  }

  Future<void> updateUserInfo(BuildContext context) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    final response = await _client
        .from('user_credentials')
        .select('user_info_id')
        .eq('user_cred_id', userId)
        .maybeSingle();

    final userInfoId = response!['user_info_id'];

    await _client.from('user_info').update({
      'user_fname': fnameController.text,
      'user_lname': lnameController.text,
      'user_phone_num': contactController.text,
      'user_location': locationController.text,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('user_info_id', userInfoId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }
}
