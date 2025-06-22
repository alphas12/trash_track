import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String distance;
  final String status;
  final List<String> serviceTypes;
  final String? imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const ServiceCard({
    super.key,
    required this.title,
    required this.distance,
    required this.status,
    required this.serviceTypes,
    this.imageUrl,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate card width to fit two cards with proper spacing
    final cardWidth = (screenWidth - 48) / 2; // 32 padding on sides + 16 between cards

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: 180, // Reduced height to match design
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          image: imageUrl != null
              ? DecorationImage(
                  image: AssetImage(imageUrl!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                )
              : null,
        ),
        child: Stack(
          children: [
            // Dark gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            // Favorite button
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onTap: onFavorite,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite? Color(0xFF4A5F44): Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            // Content
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: 'Mallanna',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: status.toLowerCase() == 'open'
                              ? const Color.fromARGB(255, 97, 170, 87)
                              : Colors.red[400],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status.toLowerCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Mallanna',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Distance and Service Types
                  Row(
                    children: [
                      Text(
                        distance,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Mallanna',
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '|',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          serviceTypes.join(', '),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Mallanna',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
