import 'package:flutter/material.dart';

class ArtistSection extends StatelessWidget {
  ArtistSection({super.key});

  final List<Map<String, String>> artists = const [
    {'image': 'assets/images/wpfp.jpg', 'name': 'Weeknd'},
    {'image': 'assets/images/krpfp.jpg', 'name': 'Krhna'},
    {'image': 'assets/images/bdpfp.jpg', 'name': 'Badshah'},
    {'image': 'assets/images/taypfp.jpg', 'name': 'Taylor'},
    {'image': 'assets/images/smpfp.jpg', 'name': 'SM'},
    {'image': 'assets/images/aspfp.jpg', 'name': 'Arijit'},
    {'image': 'assets/images/lanapfp.jpg', 'name': 'Lana'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Featured Artists',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: artists.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final artist = artists[index];
              return Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.9),
                        width: 2,
                      ), // neon green border
                    ),
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage(artist['image']!),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    artist['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ArtistAvatar extends StatelessWidget {
  final String imagePath;

  const _ArtistAvatar(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: CircleAvatar(radius: 35, backgroundImage: AssetImage(imagePath)),
    );
  }
}
