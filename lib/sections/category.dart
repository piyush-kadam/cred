import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';

class CategorySection extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Music',
      'icon': Icons.music_note,
      'color': Colors.purple,
      'shape': StadiumBorder(),
    },
    {
      'name': 'Comedy',
      'icon': Icons.emoji_emotions,
      'color': Colors.orange,
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    },
    {
      'name': 'Concert',
      'icon': Icons.mic,
      'color': Colors.blue,
      'shape': RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    },
    {
      'name': 'Rap',
      'icon': Icons.graphic_eq,
      'color': Colors.red,
      'shape': BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
    },
    {
      'name': 'Motivational',
      'icon': Icons.lightbulb,
      'color': Colors.green,
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
    },
    {
      'name': 'Poetry',
      'icon': Icons.menu_book,
      'color': Colors.teal,
      'shape': CircleBorder(),
    },
    {
      'name': 'Dance',
      'icon': Icons.directions_run,
      'color': Colors.pink,
      'shape': ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
    },
    {
      'name': 'Drama',
      'icon': Icons.theater_comedy,
      'color': Colors.indigo,
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(5),
        ),
      ),
    },
  ];

  CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          'Browse by Category',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              return NeoPopTiltedButton(
                isFloating: true,
                onTapUp: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: ${category['name']}'),
                      backgroundColor: category['color'],
                    ),
                  );
                },
                decoration: NeoPopTiltedButtonDecoration(
                  color: category['color'].withOpacity(0.3),
                  plunkColor: category['color'].withOpacity(0.5),
                  shadowColor: category['color'].withOpacity(0.8),
                  showShimmer: false,
                  border: Border.all(color: category['color'], width: 1),
                ),
                child: ClipPath(
                  clipper: ShapeBorderClipper(shape: category['shape']),
                  child: Container(
                    width: 90,
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 4,
                    ),
                    color: Colors.black.withOpacity(0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category['icon'],
                          size: 24,
                          color: category['color'],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category['name'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
