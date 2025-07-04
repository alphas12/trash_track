import 'package:flutter/material.dart';
import '../models/recycling_service.dart';
import '../services/recycling_service_repository.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/service_card.dart';
import '../screens/search_screen.dart';
import '../screens/recommended_screen.dart';
import '../screens/top_services_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final RecyclingServiceRepository _repository = RecyclingServiceRepository();
  List<RecyclingService> _recommendedServices = [];
  List<RecyclingService> _topServices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final recommended = await _repository.getRecommendedServices();
      final topServices = await _repository.getTopServices();

      if (!mounted) return;

      setState(() {
        _recommendedServices = recommended;
        _topServices = topServices;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error loading services: ${e.toString()}',
            style: const TextStyle(fontFamily: 'Mallanna'),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Navigation is now handled in the CustomBottomNavBar

  void _toggleFavorite(RecyclingService service) {
    setState(() {
      final index = _recommendedServices.indexWhere((s) => s.id == service.id);
      if (index != -1) {
        _recommendedServices[index] = RecyclingService(
          id: service.id,
          name: service.name,
          distance: service.distance,
          status: service.status,
          imageUrl: service.imageUrl,
          address: service.address,
          serviceTypes: service.serviceTypes,
          rating: service.rating,
          isFavorite: !service.isFavorite,
        );
      }

      final topIndex = _topServices.indexWhere((s) => s.id == service.id);
      if (topIndex != -1) {
        _topServices[topIndex] = RecyclingService(
          id: service.id,
          name: service.name,
          distance: service.distance,
          status: service.status,
          imageUrl: service.imageUrl,
          address: service.address,
          serviceTypes: service.serviceTypes,
          rating: service.rating,
          isFavorite: !service.isFavorite,
        );
      }
    });
  }

  void _onServiceTap(RecyclingService service) {
    // For now, just print to console. Later we can navigate to a details screen
    print('Service tapped: ${service.name}');
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
                                  opacity: 1,
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
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const SearchScreen(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 52,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFD9D9D9),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.search,
                                                  color: Color(0xFF4A5F44),
                                                ),
                                                const SizedBox(width: 8),
                                                const Expanded(
                                                  child: Text(
                                                    'Search',
                                                    style: TextStyle(
                                                      fontFamily: 'Mallanna',
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RecommendedScreen(),
                                        ),
                                      );
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
                                    children: _recommendedServices.take(2).map((
                                      service,
                                    ) {
                                      return ServiceCard(
                                        title: service.name,
                                        distance: service.formattedDistance,
                                        status: service.status,
                                        serviceTypes: service.serviceTypes,
                                        imageUrl: service.imageUrl,
                                        isFavorite: service.isFavorite,
                                        rating: service.rating,
                                        onTap: () => _onServiceTap(service),
                                        onFavorite: () =>
                                            _toggleFavorite(service),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              const SizedBox(height: 32),
                              // Top Services Section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Top Services',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Mallanna',
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TopServicesScreen(),
                                        ),
                                      );
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
                              else if (_topServices.isEmpty)
                                const Center(
                                  child: Text(
                                    'No top services available',
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
                                    children: _topServices.take(2).map((
                                      service,
                                    ) {
                                      return ServiceCard(
                                        title: service.name,
                                        distance: service.formattedDistance,
                                        status: service.status,
                                        serviceTypes: service.serviceTypes,
                                        imageUrl: service.imageUrl,
                                        isFavorite: service.isFavorite,
                                        rating: service.rating,
                                        onTap: () => _onServiceTap(service),
                                        onFavorite: () =>
                                            _toggleFavorite(service),
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
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
