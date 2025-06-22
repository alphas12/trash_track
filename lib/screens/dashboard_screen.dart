import 'package:flutter/material.dart';
import '../models/recycling_service.dart';
import '../services/recycling_service_repository.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/service_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final RecyclingServiceRepository _repository = RecyclingServiceRepository();
  List<RecyclingService> _recommendedServices = [];
  List<RecyclingService> _nearestServices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    try {
      final recommended = await _repository.getRecommendedServices();
      final nearest = await _repository.getNearestServices();
      setState(() {
        _recommendedServices = recommended;
        _nearestServices = nearest;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error appropriately
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Green background container
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
            // Main content
            Column(
              children: [
                // Sticky header section
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
                              // World-cuate image in background
                              Positioned(
                                right: 20,
                                top: 0,
                                child: Opacity(
                                  opacity: 0.85,
                                  child: Image.asset(
                                    'assets/images/World-cuate 1.png',
                                    height: 280,
                                  ),
                                ),
                              ),
                              // Content on top
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title and Shop button
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Save The Planet',
                                              style: TextStyle(
                                                fontFamily: 'Mallanna',
                                                fontSize: 33,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFFEFAE0),
                                              ),
                                            ),
                                            Text(
                                              'Look for recycling sites and\nrecycle for a change',
                                              style: TextStyle(
                                                fontFamily: 'Mallanna',
                                                fontSize: 16,
                                                color: Color(0xFFFEFAE0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  // Search Bar and QR Scanner
                                  Row(
                                    children: [
                                      // Search Bar
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFD9D9D9),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.search,
                                                color: Color(0xFF4A5F44),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: TextField(
                                                  style: const TextStyle(
                                                    fontFamily: 'Mallanna',
                                                    fontSize: 16,
                                                  ),
                                                  decoration:
                                                      const InputDecoration(
                                                        hintText: 'Search',
                                                        hintStyle: TextStyle(
                                                          fontFamily:
                                                              'Mallanna',
                                                          color: Colors.grey,
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.symmetric(
                                                              vertical: 15,
                                                            ),
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // QR Code Scanner Button
                                      Container(
                                        width: 52,
                                        height: 52,
                                        padding: const EdgeInsets.all(13),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD9D9D9),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Image.asset(
                                          'assets/images/qr_code.png',
                                          color: const Color(0xFF4A5F44),
                                        ),
                                      ),
                                    ],
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
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              // Recommended Section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Recommended',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Mallanna',
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Handle see all
                                    },
                                    child: const Text(
                                      'See All',
                                      style: TextStyle(
                                        color: Color(0xFF4A5F44),
                                        fontFamily: 'Mallanna',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              if (_isLoading)
                                const Center(child: CircularProgressIndicator())
                              else if (_recommendedServices.isEmpty)
                                const Center(
                                  child: Text(
                                    'No recycling services available',
                                    style: TextStyle(
                                      fontFamily: 'Mallanna',
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              else
                                Center(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 16,
                                    runSpacing: 16,
                                    children: _recommendedServices.map((
                                      service,
                                    ) {
                                      return ServiceCard(
                                        title: service.name,
                                        distance: service.formattedDistance,
                                        status: service.status,
                                        serviceTypes: service.serviceTypes,
                                        imageUrl: service.imageUrl,
                                        isFavorite: service.isFavorite,
                                        onTap: () {
                                          // Handle service tap
                                        },
                                        onFavorite: () {
                                          // Handle favorite toggle
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              const SizedBox(height: 32),
                              // Nearest Services Section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Nearest Services',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Mallanna',
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Handle see all
                                    },
                                    child: const Text(
                                      'See All',
                                      style: TextStyle(
                                        color: Color(0xFF4A5F44),
                                        fontFamily: 'Mallanna',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              if (_isLoading)
                                const Center(child: CircularProgressIndicator())
                              else if (_nearestServices.isEmpty)
                                const Center(
                                  child: Text(
                                    'No nearby services available',
                                    style: TextStyle(
                                      fontFamily: 'Mallanna',
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              else
                                Center(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 16,
                                    runSpacing: 16,
                                    children: _nearestServices.map((service) {
                                      return ServiceCard(
                                        title: service.name,
                                        distance: service.formattedDistance,
                                        status: service.status,
                                        serviceTypes: service.serviceTypes,
                                        imageUrl: service.imageUrl,
                                        isFavorite: service.isFavorite,
                                        onTap: () {
                                          // Handle service tap
                                        },
                                        onFavorite: () {
                                          // Handle favorite toggle
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                            ],
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
