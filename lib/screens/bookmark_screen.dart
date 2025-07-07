// import 'package:flutter/material.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
// import '../widgets/service_card.dart';
// import '../models/recycling_service.dart';
// import '../services/recycling_service_repository.dart';

// class CollectionsPage extends StatefulWidget {
//   const CollectionsPage({super.key});

//   @override
//   State<CollectionsPage> createState() => _CollectionsPageState();
// }

// class _CollectionsPageState extends State<CollectionsPage> {
//   final RecyclingServiceRepository _repository = RecyclingServiceRepository();
//   List<RecyclingService> _services = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadServices();
//   }

//   Future<void> _loadServices() async {
//     try {
//       final services = await _repository.getRecommendedServices();
//       if (mounted) {
//         setState(() {
//           _services = services;
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Error loading services: ${e.toString()}',
//               style: const TextStyle(fontFamily: 'Mallanna'),
//             ),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   void _handleServiceFavorite(RecyclingService service) {
//     setState(() {
//       final index = _services.indexWhere((s) => s.id == service.id);
//       if (index != -1) {
//         _services[index] = RecyclingService(
//           id: service.id,
//           name: service.name,
//           distance: service.distance,
//           status: service.status,
//           imageUrl: service.imageUrl,
//           address: service.address,
//           serviceTypes: service.serviceTypes,
//           rating: service.rating,
//           isFavorite: !service.isFavorite,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: 1,
//         onTap: (index) {},
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Collections',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.w900,
//                   fontFamily: 'Mallanna',
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               const Text(
//                 'Your personal collection of favorite shops!',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black54,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Mallanna',
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     shape: StadiumBorder(),
//                     backgroundColor: Colors.grey.shade200,
//                     elevation: 0,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 8,
//                     ),
//                   ),
//                   child: const Text(
//                     'Filter',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: 'Mallanna',
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: _isLoading
//                     ? const Center(
//                         child: CircularProgressIndicator(
//                           color: Color(0xFF4A5F44),
//                         ),
//                       )
//                     : _services.isEmpty
//                     ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFF4A5F44).withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: Image.asset(
//                                 'assets/icons/collections.png',
//                                 width: 48,
//                                 height: 48,
//                                 color: const Color(0xFF4A5F44),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             const Text(
//                               'No collections yet',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                                 fontFamily: 'Mallanna',
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Start adding your favorite services',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey[600],
//                                 fontFamily: 'Mallanna',
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : GridView.count(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 12,
//                         mainAxisSpacing: 24,
//                         children: _services.map((service) {
//                           return ServiceCard(
//                             title: service.name,
//                             distance: '${service.distance}km',
//                             status: service.status,
//                             serviceTypes: service.serviceTypes,
//                             imageUrl: service.imageUrl,
//                             isFavorite: true,
//                             rating: service.rating,
//                             onTap: () {
//                               // TODO: Navigate to service details
//                             },
//                             onFavorite: () => _handleServiceFavorite(service),
//                           );
//                         }).toList(),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
