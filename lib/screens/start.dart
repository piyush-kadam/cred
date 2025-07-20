import 'package:cred/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/neopop.dart';

class StartScreenPage extends StatefulWidget {
  const StartScreenPage({super.key});

  @override
  State<StartScreenPage> createState() => _StartScreenPageState();
}

class _StartScreenPageState extends State<StartScreenPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/c1.jpg',
      'title': 'Discover Amazing Concerts',
      'subtitle':
          'Find and book tickets for the hottest live music events in your city',
    },
    {
      'image': 'assets/images/s2.jpg',
      'title': 'Seamless Booking Experience',
      'subtitle': 'Quick and secure ticket booking with instant confirmation',
    },
    {
      'image': 'assets/images/s3.jpg',
      'title': 'Never Miss a Beat',
      'subtitle':
          'Get notified about upcoming concerts from your favorite artists',
    },
  ];

  void _handleButtonPress() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background images with overlay
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      pages[index]['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient overlay for better text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // App branding at the top
          Positioned(
            top: 80,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Text(
                  '7 SEERS',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your Gateway to Live Music',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w400,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content text
          Positioned(
            bottom: 200,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pages[_currentPage]['title']!,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  pages[_currentPage]['subtitle']!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Page indicators
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index
                            ? Color(0xFF00DFA2)
                            : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          // Action button
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Row(
              children: [
                // Skip button (only show on first two pages)
                if (!isLastPage)
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: Text(
                        'Skip',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                // Main action button
                Expanded(
                  flex: isLastPage ? 1 : 2,
                  child: NeoPopTiltedButton(
                    isFloating: true,

                    onTapUp: _handleButtonPress,
                    decoration: const NeoPopTiltedButtonDecoration(
                      color: Color(0xFF6A0DAD), // Royal Purple
                      plunkColor: Color(
                        0xFF4B0082,
                      ), // Pressed shade (darker indigo-purple)
                      shadowColor: Color(0xFF4B0082), // Matching shadow
                      showShimmer: true,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 11,
                      ),
                      child: Text(
                        isLastPage ? 'Get Started' : 'Next',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
