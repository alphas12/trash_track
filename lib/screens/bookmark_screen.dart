import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          // Example navigation stub
          print('Tapped index: $index');
          // You can use Navigator.push or setState if this is a StatefulWidget
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Collections',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Your personal collection of favorite shops!',
                style: TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.grey.shade200,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  child: const Text('Filter', style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 24,
                  children: [
                    ShopCard(name: 'Junkify', distance: '10km', tags: 'Pick up', isOpen: true),
                    ShopCard(name: 'ReClaim', distance: '7km', tags: 'Pick up, Drop off', isOpen: true),
                    ShopCard(name: 'Earthy', distance: '5km', tags: 'Drop off', isOpen: true),
                    ShopCard(name: 'EcoHub', distance: '7km', tags: 'Pick up, Drop off', isOpen: false),
                    ShopCard(name: 'ReBorn', distance: '10km', tags: 'Drop off', isOpen: false),
                    ShopCard(name: 'CycleX', distance: '10km', tags: 'Pick up, Drop off', isOpen: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  final String name;
  final String distance;
  final String tags;
  final bool isOpen;

  const ShopCard({
    super.key,
    required this.name,
    required this.distance,
    required this.tags,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/images/Junkify.png'), // TODO: Replace with real image
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Icon(Icons.favorite, color: Colors.green.shade300),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$distance | $tags',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                ),
              ),
              Text(
                isOpen ? 'open' : 'closed',
                style: TextStyle(
                  color: isOpen ? Colors.greenAccent : Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
