import 'package:flutter/material.dart';
import '../models/recycling_service.dart';
import '../services/recycling_service_repository.dart';
import '../widgets/service_card.dart';
import '../widgets/material_filter_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final RecyclingServiceRepository _repository = RecyclingServiceRepository();
  List<RecyclingService> _services = [];
  bool _isLoading = false;
  String? _selectedMaterial;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadServices() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final services = await _repository.searchServices(_searchController.text);
      if (!mounted) return;

      setState(() {
        _services = services;
        if (_selectedMaterial != null && _selectedMaterial != 'All') {
          _services = _services
              .where(
                (service) => service.serviceTypes.contains(_selectedMaterial),
              )
              .toList();
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _services = [];
      });

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

  void _handleServiceFavorite(int index) {
    final service = _services[index];
    setState(() {
      _services[index] = RecyclingService(
        id: service.id,
        name: service.name,
        distance: service.distance,
        status: service.status,
        imageUrl: service.imageUrl,
        address: service.address,
        serviceTypes: service.serviceTypes,
        isFavorite: !service.isFavorite,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header with back button and search
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
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
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (_) => _loadServices(),
                              decoration: const InputDecoration(
                                hintText: 'Search recycling services',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Mallanna',
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF4A5F44),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Material type filters
                  MaterialFilterBar(
                    selectedMaterial: _selectedMaterial,
                    onMaterialSelected: (material) {
                      setState(() {
                        _selectedMaterial = material;
                      });
                      _loadServices();
                    },
                  ),
                ],
              ),
            ),
            // Search results
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _services.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No services found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontFamily: 'Mallanna',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your search or filters',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[400],
                              fontFamily: 'Mallanna',
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _services.length,
                      itemBuilder: (context, index) {
                        final service = _services[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ServiceCard(
                            title: service.name,
                            distance: service.formattedDistance,
                            status: service.status,
                            serviceTypes: service.serviceTypes,
                            imageUrl: service.imageUrl,
                            isFavorite: service.isFavorite,
                            onTap: () {
                              // TODO: Navigate to service details
                            },
                            onFavorite: () => _handleServiceFavorite(index),
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
