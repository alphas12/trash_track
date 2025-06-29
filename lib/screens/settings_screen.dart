import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                    children: const [
                      Text(
                        'Sam Russel C. Mahayag',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Manage Profile',
                        style: TextStyle(
                          fontFamily: 'Mallanna',
                          fontSize: 14,
                          color: Color(0xFF4A5F44),
                          decoration: TextDecoration.underline,
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
              _buildSettingsTile('Points', () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PointsScreen()));
              }),
              _buildSettingsTile('Privacy and Security', () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacySecurityScreen()));
              }),
              _buildSettingsTile(
                'Log Out',
                    () {
                  // Add logout logic here
                },
              ),
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('History', style: TextStyle(fontFamily: 'Mallanna')),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
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
                          fontFamily: 'Mallanna')),
                  const SizedBox(height: 4),
                  Text(item['date']!,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Mallanna')),
                  const SizedBox(height: 8),
                  Text(item['description']!, style: const TextStyle(fontFamily: 'Mallanna')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Points', style: TextStyle(fontFamily: 'Mallanna')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Points',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Mallanna')),
            const SizedBox(height: 8),
            const Text('150',
                style: TextStyle(fontSize: 32, color: Color(0xFF4A5F44), fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text('Ways to Earn Points',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Mallanna')),
            const SizedBox(height: 8),
            const Text('- Dispose recyclable items at partner sites\n- Shop eco-friendly products\n- Refer a friend to TrashTrack',
                style: TextStyle(fontSize: 16, fontFamily: 'Mallanna')),
          ],
        ),
      ),
    );
  }
}

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Privacy and Security', style: TextStyle(fontFamily: 'Mallanna')),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'TrashTrack respects your data. We do not collect, sell, or share your personal information without your consent. All interactions remain secure and private.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Mallanna',
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}