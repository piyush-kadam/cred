import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingCarouselSection extends StatefulWidget {
  const TrendingCarouselSection({super.key});

  @override
  State<TrendingCarouselSection> createState() =>
      _TrendingCarouselSectionState();
}

class _TrendingCarouselSectionState extends State<TrendingCarouselSection> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> carouselItems = [
    {
      'image': 'assets/images/t1.jpg',
      'title': 'The Soundwave Festival',
      'subtitle': 'Get ready to vibe with music’s biggest names!',
    },
    {
      'image': 'assets/images/t4.jpg',
      'title': 'PunkRock Festival',
      'subtitle': 'Get inspired by India\'s best speakers!',
    },
    {
      'image': 'assets/images/t2.jpg',
      'title': 'Dance Night',
      'subtitle': 'A night full of laughter and punchlines!',
    },
    {
      'image': 'assets/images/t3.jpg',
      'title': 'Cinema Fest',
      'subtitle': 'Soul-touching verses by rising poets.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        if (_currentPage >= carouselItems.length) _currentPage = 0;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Trending',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 400, // Increased poster height
          child: PageView.builder(
            controller: _pageController,
            itemCount: carouselItems.length,
            itemBuilder: (context, index) {
              final item = carouselItems[index];
              final isCurrent = _currentPage == index;
              final scale = isCurrent ? 1.0 : 0.92;

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        children: [
                          // Image background
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(item['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // Gradient overlay
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.65),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),

                          // Title, subtitle & view details
                          Positioned(
                            bottom: 20,
                            left: 16,
                            right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item['subtitle']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 14),

                                // Transparent "View Details" button with play icon
                                OutlinedButton.icon(
                                  onPressed: () {
                                    // TODO: Handle details navigation
                                  },
                                  icon: const Icon(
                                    Icons.play_circle_fill_rounded,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'View Details',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.white),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    backgroundColor: Colors.white.withOpacity(
                                      0.05,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
