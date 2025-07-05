import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/disposal_service.dart';
import '../providers/disposal_service_provider.dart';
import '../widgets/disposal_service_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';
// import 'search_screen.dart';
import 'recommended_screen.dart';
import 'top_services_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final recommendedServices = ref.watch(dashboardRecommendedServicesProvider);
    final topServices = ref.watch(dashboardTopServicesProvider);

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
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => const SearchScreen(),
                                            //   ),
                                            // );
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
                                              children: const [
                                                Icon(
                                                  Icons.search,
                                                  color: Color(0xFF4A5F44),
                                                ),
                                                SizedBox(width: 8),
                                                Expanded(
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
                              recommendedServices.when(
                                data: (services) {
                                  if (services.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'No recommended services available',
                                        style: TextStyle(
                                          fontFamily: 'Mallanna',
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  }
                                  return Center(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 16,
                                      runSpacing: 16,
                                      children: services.map((service) {
                                        final isOpen = ref.watch(
                                          isServiceOpenProvider(service),
                                        );
                                        return DisposalServiceCard(
                                          service: service,
                                          onTap: () {
                                            // TODO: Navigate to service details
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (error, stack) => Center(
                                  child: Text(
                                    'Error: $error',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Mallanna',
                                    ),
                                  ),
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
                              topServices.when(
                                data: (services) {
                                  if (services.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'No top services available',
                                        style: TextStyle(
                                          fontFamily: 'Mallanna',
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  }
                                  return Center(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 16,
                                      runSpacing: 16,
                                      children: services.map((service) {
                                        return DisposalServiceCard(
                                          service: service,
                                          onTap: () {
                                            // TODO: Navigate to service details
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (error, stack) => Center(
                                  child: Text(
                                    'Error: $error',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Mallanna',
                                    ),
                                  ),
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
