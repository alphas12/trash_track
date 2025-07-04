import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '/screens/dashboard_screen.dart';

class EcoShopScreen extends StatefulWidget {
  const EcoShopScreen({super.key});

  @override
  State<EcoShopScreen> createState() => _EcoShopScreenState();
}

class _EcoShopScreenState extends State<EcoShopScreen> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Lifestyle', 'icon': 'assets/icons/lifestyle.png', 'activeIcon': 'assets/icons/lifestyle_active.png'},
    {'label': 'Food', 'icon': 'assets/icons/food.png', 'activeIcon': 'assets/icons/food_active.png'},
    {'label': 'Fashion', 'icon': 'assets/icons/fashion.png', 'activeIcon': 'assets/icons/fashion_active.png'},
    {'label': 'Beauty', 'icon': 'assets/icons/beauty.png', 'activeIcon': 'assets/icons/beauty_active.png'},
    {'label': 'Health', 'icon': 'assets/icons/health.png', 'activeIcon': 'assets/icons/health_active.png'},
    {'label': 'Tech', 'icon': 'assets/icons/tech.png', 'activeIcon': 'assets/icons/tech_active.png'},
    {'label': 'Services', 'icon': 'assets/icons/services.png', 'activeIcon': 'assets/icons/services_active.png'},
  ];

  final List<Map<String, String>> _shops = List.generate(6, (index) => {
    'name': "Eco Shop ${index + 1}",
    'status': '10AM - 5PM | OPEN',
    'address': 'Sample Address, Cebu',
    'services': 'Lifestyle, Beauty, Health',
    'details': "Welcome to Eco Shop ${index + 1}, a locally grown space that makes sustainable and zero waste products accessible."
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 220,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF4A5F44),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 260,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            children: [
                              Positioned(
                                right: 20,
                                top: 0,
                                child: Opacity(
                                  opacity: 1,
                                  child: Image.asset(
                                    'assets/images/eco_shop.png',
                                    height: 320,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Shop For Change',
                                              style: TextStyle(
                                                fontFamily: 'Mallanna',
                                                fontSize: 33,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFFEFAE0),
                                              ),
                                            ),
                                            Text(
                                              'Look for Eco-friendly shops\nand reduce your waste',
                                              style: TextStyle(
                                                fontFamily: 'Mallanna',
                                                fontSize: 16,
                                                color: Color(0xFFFEFAE0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => const DashboardScreen()),
                                            );
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(
                                                Icons.shopping_cart,
                                                color: Color(0xFFFEFAE0),
                                                size: 28,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Shop',
                                                style: TextStyle(
                                                  fontFamily: 'Mallanna',
                                                  color: Color(0xFFFEFAE0),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    height: 52,
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.search, color: Color(0xFF4A5F44)),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Search',
                                              border: InputBorder.none,
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Mallanna',
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Shop by Category',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mallanna',
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: _categories.asMap().entries.map((entry) {
                              int index = entry.key;
                              var category = entry.value;
                              bool isSelected = index == _selectedCategoryIndex;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCategoryIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: isSelected ? const Color(0xFF4A5F44) : const Color(0xFFF1F1E6),
                                        child: Image.asset(
                                          isSelected ? category['activeIcon'] : category['icon'],
                                          height: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        category['label'],
                                        style: const TextStyle(fontFamily: 'Mallanna'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Recommended',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mallanna',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 80),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _shops.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, index) {
                              final shop = _shops[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShopDetailsScreen(shop: shop),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD9D9D9),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Center(
                                          child: Icon(Icons.image, size: 50, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      shop['name']!,
                                      style: const TextStyle(
                                        fontFamily: 'Mallanna',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ShopDetailsScreen extends StatelessWidget {
  final Map<String, String> shop;

  const ShopDetailsScreen({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 200,
                  color: const Color(0xFFD9D9D9),
                  child: const Center(
                    child: Icon(Icons.image, size: 60, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                shop['name']!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mallanna',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                shop['status']!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6A8126),
                  fontFamily: 'Mallanna',
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(shop['address']!, style: const TextStyle(fontFamily: 'Mallanna')),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.delivery_dining, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  const Text('Online Delivery', style: TextStyle(fontFamily: 'Mallanna')),
                ],
              ),
              const SizedBox(height: 4),
              Row (
                children: [
                  const Icon(Icons.category, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(shop['services']!, style: TextStyle(fontFamily: 'Mallanna')),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Mallanna'),
              ),
              const SizedBox(height: 8),
              Text(
                shop['details']!,
                style: const TextStyle(fontFamily: 'Mallanna'),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A5F44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    'Shop Now!',
                    style: TextStyle(
                      fontFamily: 'Mallanna',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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