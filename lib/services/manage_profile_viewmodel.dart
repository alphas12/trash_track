import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/manage_profile_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ManageProfileViewModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  File? pickedImage;
  String? _uploadedImageUrl;
  String? get uploadedImageUrl => _uploadedImageUrl;

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

  // Future<void> updateUserInfo(BuildContext context) async {
  //   final userId = _client.auth.currentUser?.id;
  //   if (userId == null) return;

  //   final response = await _client
  //     .from('user_credentials')
  //     .select('user_info_id')
  //     .eq('user_cred_id', userId)
  //     .maybeSingle();

  //   // 1. Upload image if one is selected
  //   if (pickedImage != null) {
  //     final fileName = pickedImage!.path.split('/').last;
  //     final storagePath = 'profile-pics/$userId/$fileName';

  //     await _client.storage
  //       .from('profile-pics')
  //       .upload(
  //         storagePath,
  //         pickedImage!,
  //         fileOptions: const FileOptions(upsert: true),
  //       );

  //     _uploadedImageUrl = _client.storage
  //       .from('profile-pics')
  //       .getPublicUrl(storagePath);
  //   }

  //   final userInfoId = response!['user_info_id'];

  //   // 2. Update other profile fields (and profile image if available)
  //   await _client.from('user_info').update({
  //     'user_fname': fnameController.text,
  //     'user_lname': lnameController.text,
  //     'user_phone_num': contactController.text,
  //     'user_location': locationController.text,
  //     if (uploadedImageUrl != null) 'user_profile_img': uploadedImageUrl,
  //     'updated_at': DateTime.now().toIso8601String(),
  //   }).eq('user_info_id', userInfoId);

  //   // 3. Clear temp values and notify
  //   pickedImage = null;
  //   _isChanged = false;
  //   notifyListeners();

  //   // 4. Show success snackbar
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Profile updated successfully')),
  //   );
  // }
  
  Future<void> updateUserInfo(BuildContext context) async {
  final userId = _client.auth.currentUser?.id;
  if (userId == null) return;

  final fileName = pickedImage!.path.split('/').last;
  final storagePath = 'profile-pics/$userId/$fileName';

  _uploadedImageUrl = _client.storage
    .from('profile_pics')
    .getPublicUrl(storagePath);


  final response = await _client
      .from('user_credentials')
      .select('user_info_id')
      .eq('user_cred_id', userId)
      .maybeSingle();

  final userInfoId = response?['user_info_id'];
  if (userInfoId == null) return;

  final updatePayload = {
    'user_fname': fnameController.text,
    'user_lname': lnameController.text,
    'user_phone_num': contactController.text,
    'user_location': locationController.text,
    'updated_at': DateTime.now().toIso8601String(),
  };

  // Only add photo if it exists
  if (_uploadedImageUrl != null) {
    updatePayload['user_profile_img'] = _uploadedImageUrl!;
  }

  final updateResult = await _client
      .from('user_info')
      .update(updatePayload)
      .eq('user_info_id', userInfoId);

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  setChanged(false); // Reset change state
}


  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      notifyListeners();
    }
  }
}
