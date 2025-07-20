import 'package:cred/sections/artists_section.dart';
import 'package:cred/sections/category.dart';
import 'package:cred/sections/concert_section.dart';
import 'package:cred/sections/trend.dart';
import 'package:cred/sections/trending_section.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final homeKey = GlobalKey();
  final bookmarkKey = GlobalKey();
  final addKey = GlobalKey();
  final profileKey = GlobalKey();
  final settingsKey = GlobalKey();

  int _selectedIndex = 0;

  List<double> sectionOffsets = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateOffsets());
  }

  void _calculateOffsets() {
    sectionOffsets = [
      _getOffset(homeKey),
      _getOffset(bookmarkKey),
      _getOffset(addKey),
      _getOffset(profileKey),
      _getOffset(settingsKey),
    ];
  }

  double _getOffset(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        return renderBox.localToGlobal(Offset.zero).dy +
            _scrollController.offset;
      }
    }
    return 0;
  }

  void _onScroll() {
    final scrollPos = _scrollController.offset + 100;
    for (int i = 0; i < sectionOffsets.length; i++) {
      final start = sectionOffsets[i];
      final end =
          i < sectionOffsets.length - 1
              ? sectionOffsets[i + 1]
              : double.infinity;
      if (scrollPos >= start && scrollPos < end && _selectedIndex != i) {
        setState(() => _selectedIndex = i);
        break;
      }
    }
  }

  void scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        scrollTo(homeKey);
        break;
      case 1:
        scrollTo(bookmarkKey);
        break;
      case 2:
        scrollTo(addKey);
        break;
      case 3:
        scrollTo(profileKey);
        break;
      case 4:
        scrollTo(settingsKey);
        break;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (_) {
            _calculateOffsets();
            return true;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.near_me, color: Colors.white, size: 40),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Piyush Kadam',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Maharashtra, India',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 0.5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    style: GoogleFonts.poppins(color: Colors.white),
                    decoration: InputDecoration(
                      icon: const Icon(Icons.search, color: Colors.white),
                      hintText: 'Search...',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // 🌟 Sections
                SectionWrapper(
                  sectionKey: homeKey,
                  child: const ConcertSection(),
                ),
                const SizedBox(height: 8),
                SectionWrapper(
                  sectionKey: bookmarkKey,
                  child: CategorySection(),
                ),
                const SizedBox(height: 15),
                SectionWrapper(
                  sectionKey: addKey,
                  child: const UpcomingEventsSection(),
                ),
                const SizedBox(height: 8),
                SectionWrapper(
                  sectionKey: profileKey,
                  child: const TrendingCarouselSection(),
                ),
                const SizedBox(height: 8),
                SectionWrapper(sectionKey: settingsKey, child: ArtistSection()),
              ],
            ),
          ),
        ),
      ),

      // 🌟 Bottom Navigation
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 45),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              final icons = [
                Icons.home,
                Icons.grid_view,
                Icons.event,
                Icons.trending_up,
                Icons.people,
              ];
              return GestureDetector(
                onTap: () => onItemTapped(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 6,
                      width: _selectedIndex == index ? 30 : 0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      icons[index],
                      color:
                          _selectedIndex == index
                              ? Colors.white
                              : Colors.white54,
                      size: 26,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final GlobalKey sectionKey;

  const SectionWrapper({
    required this.sectionKey,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(key: sectionKey, child: child);
  }
}
