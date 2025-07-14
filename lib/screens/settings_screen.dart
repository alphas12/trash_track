import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../providers/manage_profile_provider.dart';
import '../services/manage_profile_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      index = _selectedIndex;
    });
  }

  bool _showPrivacyOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mallanna',
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/images/default_profile.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sam Russel C. Mahayag',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ManageProfileScreen()),
                          );
                        },
                        child: const Text(
                          'Manage Profile',
                          style: TextStyle(
                            fontFamily: 'Mallanna',
                            fontSize: 14,
                            color: Color(0xFF4A5F44),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 32),
              _buildSettingsTile('History', () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
              }),
              const Divider(thickness: 1, height: 1),
              _buildSettingsTile('Points', () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PointsScreen()));
              }),
              const Divider(thickness: 1, height: 1),
              ListTile(
                title: const Text(
                  'Privacy and Security',
                  style: TextStyle(
                    fontFamily: 'Mallanna',
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(
                  _showPrivacyOptions ? Icons.expand_less : Icons.expand_more,
                  color: Colors.black,
                ),
                onTap: () {
                  setState(() {
                    _showPrivacyOptions = !_showPrivacyOptions;
                  });
                },
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.lock_outline),
                      title: const Text(
                        'Change Password',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
                        );
                      },
                    ),
                    const Divider(thickness: 1, height: 1),
                    ListTile(
                      leading: const Icon(Icons.delete_outline),
                      title: const Text(
                        'Delete My Account',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DeleteAccountScreen()),
                        );
                      },
                    ),
                    const Divider(thickness: 1, height: 1),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip_outlined),
                      title: const Text(
                        'Privacy Policy',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                        );
                      },
                    ),
                    const Divider(thickness: 1, height: 1),
                  ],
                ),
                crossFadeState:
                _showPrivacyOptions ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
              const Divider(thickness: 1, height: 1),
              _buildSettingsTile(
                'Log Out',
                    () async {
                  await Supabase.instance.client.auth.signOut();

                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
                  }
                },
              ),
              const Divider(thickness: 1, height: 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(String title, VoidCallback onTap, {Color? textColor}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Mallanna',
              fontSize: 16,
              color: textColor ?? Colors.black,
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        const Divider(thickness: 1, height: 1),
      ],
    );
  }
}

class ManageProfileScreen extends ConsumerStatefulWidget {
  const ManageProfileScreen({super.key});

  @override
  ConsumerState<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends ConsumerState<ManageProfileScreen> {
  bool isEditing = false;
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(profileViewModelProvider.notifier).fetchUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(profileViewModelProvider);
    final controller = ref.read(profileViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Top Bar
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, size: 24),
                      ),
                    ),
                  ),
                  const Text(
                    'Account Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mallanna',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/images/default_profile.png'),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.add, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '${controller.fnameController.text} ${controller.lnameController.text}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mallanna',
                ),
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.center,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(const Color(0xFF4A5F44)),
                    ),
                    onPressed: () async {
                      setState(() => isEditing = !isEditing);
                      if (!isEditing) {
                        await controller.updateUserInfo(context);
                      }
                    },
                    child: Text(
                      isEditing ? 'Save' : 'Edit',
                      style: const TextStyle(
                        fontFamily: 'Mallanna',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                ),
              ),

              // Editable Fields
              _buildInputField('First Name', controller.fnameController, isEditing),
              const SizedBox(height: 16),
              _buildInputField('Last Name', controller.lnameController, isEditing),
              const SizedBox(height: 16),
              _buildInputField('Contact Number', controller.contactController, isEditing),
              const SizedBox(height: 16),
              _buildInputField('Location', controller.locationController, isEditing),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, bool enabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Mallanna',
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(fontFamily: 'Mallanna'),
        ),
      ],
    );
  }
}



class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> historyData = [
      {
        'title': 'Trash Disposal Success!',
        'date': '19 Jun 2025',
        'description': 'You have officially disposed of 2kg of recyclable trash at EcoHub Mandaue.'
      },
      {
        'title': 'Points Earned!',
        'date': '17 Jun 2025',
        'description': 'You earned 50 points from your recycling efforts.'
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mallanna',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Balance arrow icon visually
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: historyData.length,
                  itemBuilder: (context, index) {
                    final item = historyData[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['title']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Mallanna',
                                )),
                            const SizedBox(height: 4),
                            Text(item['date']!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Mallanna',
                                )),
                            const SizedBox(height: 8),
                            Text(item['description']!,
                                style: const TextStyle(fontFamily: 'Mallanna')),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rewards = [
      {
        'title': 'P10 Voucher',
        'points': 1000,
        'rewardValue': 'P10',
        'icon': Icons.local_cafe,
      },
      {
        'title': 'P30 Discount',
        'points': 3000,
        'rewardValue': 'P30',
        'icon': Icons.shopping_bag,
      },
      {
        'title': 'TrashTrack Elite',
        'points': 10000,
        'rewardValue': 'P120',
        'icon': Icons.verified,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                      ),
                    ),
                  ),
                  const Text(
                    'Points',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mallanna',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A5F44), // Eco green
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Current Balance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mallanna',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '150 EcoBits',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mallanna',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Redeem Rewards',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mallanna',
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: rewards.length,
                  itemBuilder: (context, index) {
                    final reward = rewards[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xFF4A5F44).withOpacity(0.1),
                              child: Icon(
                                reward['icon'],
                                color: const Color(0xFF4A5F44),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reward['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Mallanna',
                                  ),
                                ),
                                Text(
                                  'Redeem with ${reward['points']} Ecobits',
                                  style: const TextStyle(
                                    fontFamily: 'Mallanna',
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              reward['rewardValue'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Mallanna',
                                color: Color(0xFF4A5F44),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Uniform back button and title
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                      ),
                    ),
                  ),
                  const Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mallanna',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Scrollable policy body
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Our Commitment to Your Privacy',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'TrashTrack is committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data while using our application.',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                      SizedBox(height: 24),
                      Text(
                        '1. Information We Collect',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '- Full name and email address (for account registration)\n'
                            '- Location data (to suggest nearby disposal sites)\n'
                            '- Disposal history and earned points (to maintain account activity)',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                      SizedBox(height: 24),
                      Text(
                        '2. How We Use Your Information',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '- To personalize your experience and provide accurate disposal data\n'
                            '- To monitor and reward your sustainable actions\n'
                            '- To notify you of upcoming events, rewards, and nearby eco hubs',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                      SizedBox(height: 24),
                      Text(
                        '3. Data Sharing',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'We do not sell, trade, or rent your personal information to third parties. We may share limited data with government or partnered recycling organizations, only when necessary for environmental reporting and verification.',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                      SizedBox(height: 24),
                      Text(
                        '4. Data Security',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'We implement appropriate technical and organizational measures to protect your personal data from unauthorized access, alteration, disclosure, or destruction.',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                      SizedBox(height: 24),
                      Text(
                        '5. User Responsibilities',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '- Do not share your login credentials with others\n'
                            '- Report any suspicious or unauthorized activity on your account\n'
                            '- Use the app responsibly and truthfully when logging disposals',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                      SizedBox(height: 24),
                      Text(
                        '6. Updates to the Policy',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'This policy may be updated occasionally. Users will be notified of major changes through in-app alerts.',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'For questions regarding our Privacy Policy, please email us at support@trashtrack.eco',
                        style: TextStyle(fontFamily: 'Mallanna'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                      ),
                    ),
                  ),
                  const Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mallanna',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Are you sure you want to delete your TrashTrack account?',
                style: TextStyle(
                  fontFamily: 'Mallanna',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'This action is irreversible and will permanently remove all your data including EcoBits, history, and personal information.',
                style: TextStyle(
                  fontFamily: 'Mallanna',
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // TODO: Add delete logic
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Account Deleted'),
                      content: const Text('Your account has been deleted successfully.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Delete My Account',
                  style: TextStyle(
                    fontFamily: 'Mallanna',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      // TODO: Add password update logic
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Your password has been changed.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                      ),
                    ),
                  ),
                  const Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mallanna',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _currentPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Current Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm New Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A5F44),
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontFamily: 'Mallanna',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}