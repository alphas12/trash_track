import 'package:flutter/material.dart';
import '../models/recycling_service.dart';
import '../services/recycling_service_repository.dart';
import '../widgets/filter_bar.dart';
import '../widgets/service_card.dart';

class TopServicesScreen extends StatefulWidget {
  const TopServicesScreen({super.key});

  @override
  State<TopServicesScreen> createState() => _TopServicesScreenState();
}

class _TopServicesScreenState extends State<TopServicesScreen> {
  final RecyclingServiceRepository _repository = RecyclingServiceRepository();
  List<RecyclingService> _services = [];
  bool _isLoading = true;
  String _filterStatus = 'all';

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
      final services = await _repository.getTopServices();
      if (!mounted) return;
      setState(() {
        _services = services;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading services: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<RecyclingService> get _filteredServices {
    if (_filterStatus == 'all') return _services;
    return _services
        .where((service) => service.status.toLowerCase() == _filterStatus)
        .toList();
  }

  void _handleServiceFavorite(RecyclingService service) {
    setState(() {
      final index = _services.indexWhere((s) => s.id == service.id);
      if (index != -1) {
        _services[index] = RecyclingService(
          id: service.id,
          name: service.name,
          distance: service.distance,
          status: service.status,
          imageUrl: service.imageUrl,
          address: service.address,
          serviceTypes: service.serviceTypes,
          isFavorite: !service.isFavorite,
          rating: service.rating,
        );
      }
    });
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
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
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Top Services',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
              fontFamily: 'Mallanna',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore the highest-rated recycling services worldwide.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
              fontFamily: 'Mallanna',
            ),
          ),
          const SizedBox(height: 24),
          FilterBar(
            selectedFilter: _filterStatus,
            onFilterChanged: (status) => setState(() => _filterStatus = status),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredServices.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A5F44).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.stars_rounded,
                              size: 48,
                              color: Color(0xFF4A5F44),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No top services found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Mallanna',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your filters',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontFamily: 'Mallanna',
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: _filteredServices.length,
                      itemBuilder: (context, index) {
                        final service = _filteredServices[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ServiceCard(
                            title: service.name,
                            distance: service.formattedDistance,
                            status: service.status,
                            serviceTypes: service.serviceTypes,
                            imageUrl: service.imageUrl,
                            isFavorite: service.isFavorite,
                            rating: service.rating,
                            onTap: () {
                              // TODO: Navigate to service details
                            },
                            onFavorite: () => _handleServiceFavorite(service),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
