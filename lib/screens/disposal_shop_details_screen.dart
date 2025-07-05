import 'package:flutter/material.dart';

class DisposalShopDetailsScreen extends StatefulWidget {
  final Map<String, String> shop;

  const DisposalShopDetailsScreen({super.key, required this.shop});

  @override
  State<DisposalShopDetailsScreen> createState() => _DisposalShopDetailsScreenState();
}

class _DisposalShopDetailsScreenState extends State<DisposalShopDetailsScreen> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: Image.asset(
                      widget.shop['image'] ?? '',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          width: double.infinity,
                          color: const Color(0xFFD9D9D9),
                          child: const Center(
                            child: Icon(Icons.image, size: 60, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 24,
                    left: 24,
                    child: GestureDetector(
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
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Shop name and collections icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.shop['name']!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mallanna',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorited = !isFavorited;
                      });
                    },
                    child: Image.asset(
                      isFavorited
                          ? 'assets/icons/collections_active.png'
                          : 'assets/icons/collections.png',
                      width: 28,
                      height: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                widget.shop['status']!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6A8126),
                  fontFamily: 'Mallanna',
                ),
              ),

              const SizedBox(height: 4),

              // Address
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(widget.shop['address']!, style: const TextStyle(fontFamily: 'Mallanna')),
                ],
              ),

              const SizedBox(height: 4),

              // Drop-off or Pick-up info
              Row(
                children: [
                  const Icon(Icons.local_shipping, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    widget.shop['method'] ?? 'Drop-off',
                    style: const TextStyle(fontFamily: 'Mallanna'),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // Services (Waste Types)
              Row(
                children: [
                  const Icon(Icons.delete, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(widget.shop['wasteTypes']!, style: const TextStyle(fontFamily: 'Mallanna')),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                'Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Mallanna'),
              ),
              const SizedBox(height: 8),
              Text(
                widget.shop['details']!,
                style: const TextStyle(fontFamily: 'Mallanna'),
              ),

              const SizedBox(height: 24),

              // Shop Now Button (Full Width)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A5F44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Schedule',
                    style: TextStyle(
                      fontFamily: 'Mallanna',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
