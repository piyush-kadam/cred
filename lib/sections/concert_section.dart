import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ConcertSection extends StatefulWidget {
  const ConcertSection({super.key});

  @override
  State<ConcertSection> createState() => _ConcertSectionState();
}

class _ConcertSectionState extends State<ConcertSection>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _titleAnimationController;
  late AnimationController _cardAnimationController;
  late AnimationController _scrollAnimationController;
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _scrollFadeAnimation;
  late Animation<Offset> _scrollSlideAnimation;

  int _currentPage = 0;
  bool _hasAnimated = false;
  bool _hasScrollAnimated = false;

  final List<Map<String, String>> events = [
    {'image': 'assets/images/week.jpg', 'desc': 'The Weeknd – Hyderabad'},
    {'image': 'assets/images/am.jpg', 'desc': 'Arctic Monkeys – Goa'},
    {'image': 'assets/images/c1.jpg', 'desc': 'Taylor Swift – Mumbai'},
    {'image': 'assets/images/lr.jpg', 'desc': 'Lana Del Ray – Mumbai'},
    {'image': 'assets/images/play.jpg', 'desc': 'Coldplay – Mumbai, Delhi'},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.75,
      initialPage: events.length * 1000,
    );

    _titleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scrollAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _titleAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _titleAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _scrollFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scrollAnimationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _scrollSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _scrollAnimationController,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleAnimationController.dispose();
    _cardAnimationController.dispose();
    _scrollAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Title animation
          VisibilityDetector(
            key: const Key('title-section'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction > 0.3 && !_hasAnimated) {
                _hasAnimated = true;
                _titleAnimationController.forward();
                _cardAnimationController.forward();
              }
            },
            child: SlideTransition(
              position: _titleSlideAnimation,
              child: FadeTransition(
                opacity: _titleFadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.white],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: Text(
                          'Featured Events',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.transparent],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Cards with scroll animation
          VisibilityDetector(
            key: const Key('cards-section'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction > 0.2 && !_hasScrollAnimated) {
                _hasScrollAnimated = true;
                _scrollAnimationController.forward();
              }
            },
            child: SlideTransition(
              position: _scrollSlideAnimation,
              child: FadeTransition(
                opacity: _scrollFadeAnimation,
                child: SizedBox(
                  height: 400,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index % events.length;
                      });
                    },
                    itemBuilder: (context, index) {
                      final eventIndex = index % events.length;

                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double scale = 1.0;
                          double opacity = 1.0;
                          double translateY = 0.0;

                          if (_pageController.position.hasContentDimensions) {
                            final currentPage = _pageController.page ?? 0.0;
                            final distance = (index - currentPage).abs();

                            // Calculate scale: center card is largest (1.0), side cards are smaller
                            if (distance <= 1.0) {
                              scale =
                                  1.0 -
                                  (distance * 0.15); // Center: 1.0, sides: 0.85
                              opacity =
                                  1.0 -
                                  (distance * 0.3); // Center: 1.0, sides: 0.7
                              translateY =
                                  distance *
                                  30; // Center: 0, sides: +30 pixels down
                            } else {
                              scale = 0.85;
                              opacity = 0.7;
                              translateY = 30.0;
                            }
                          }

                          return Transform.translate(
                            offset: Offset(0, translateY),
                            child: Transform.scale(
                              scale: scale,
                              child: Opacity(
                                opacity: opacity.clamp(0.0, 1.0),
                                child: EnhancedEventCard(
                                  imagePath: events[eventIndex]['image']!,
                                  description: events[eventIndex]['desc']!,
                                  animationController: _cardAnimationController,
                                  scrollAnimationController:
                                      _scrollAnimationController,
                                  isCenter:
                                      eventIndex ==
                                      _currentPage, // Pass if this card is in center
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Page indicators with animation
          AnimatedBuilder(
            animation: Listenable.merge([
              _pageController,
              _scrollAnimationController,
            ]),
            builder: (context, child) {
              int currentPage = 0;
              if (_pageController.hasClients && _pageController.page != null) {
                currentPage = (_pageController.page! % events.length).round();
              }

              return FadeTransition(
                opacity: _scrollFadeAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(events.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color:
                            currentPage == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                        boxShadow:
                            currentPage == index
                                ? [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                                : null,
                      ),
                    );
                  }),
                ),
              );
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class EnhancedEventCard extends StatefulWidget {
  final String imagePath;
  final String description;
  final AnimationController animationController;
  final AnimationController scrollAnimationController;
  final bool isCenter;

  const EnhancedEventCard({
    super.key,
    required this.imagePath,
    required this.description,
    required this.animationController,
    required this.scrollAnimationController,
    this.isCenter = false,
  });

  @override
  State<EnhancedEventCard> createState() => _EnhancedEventCardState();
}

class _EnhancedEventCardState extends State<EnhancedEventCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _cardScaleAnimation;
  late Animation<double> _cardFadeAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(begin: 0.0, end: 15.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _cardScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.scrollAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _cardFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.scrollAnimationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.65;

    return GestureDetector(
      onTapDown: (_) => _hoverController.forward(),
      onTapUp: (_) => _hoverController.reverse(),
      onTapCancel: () => _hoverController.reverse(),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _scaleAnimation,
          _elevationAnimation,
          _rotationAnimation,
          _cardScaleAnimation,
          _cardFadeAnimation,
        ]),
        builder: (context, child) {
          // Ensure opacity is always within valid range
          final opacity = _cardFadeAnimation.value.clamp(0.0, 1.0);
          final scale = (_scaleAnimation.value * _cardScaleAnimation.value)
              .clamp(0.1, 2.0);

          return Opacity(
            opacity: opacity,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Transform.scale(
                scale: scale,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Container(
                        height: 340,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.2),
                              Colors.white.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            width:
                                widget.isCenter
                                    ? 3
                                    : 2, // Thicker border for center card
                            color:
                                widget.isCenter
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white.withOpacity(0.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(
                                widget.isCenter ? 0.3 : 0.2,
                              ),
                              blurRadius:
                                  (widget.isCenter ? 20 : 15) +
                                  _elevationAnimation.value,
                              offset: const Offset(-5, 5),
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(
                                widget.isCenter ? 0.2 : 0.1,
                              ),
                              blurRadius:
                                  (widget.isCenter ? 20 : 15) +
                                  _elevationAnimation.value,
                              offset: const Offset(5, -5),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                widget.isCenter ? 0.4 : 0.3,
                              ),
                              blurRadius:
                                  (widget.isCenter ? 25 : 20) +
                                  _elevationAnimation.value,
                              offset: Offset(
                                0,
                                (widget.isCenter ? 15 : 10) +
                                    _elevationAnimation.value * 0.5,
                              ),
                            ),
                            // Add glow effect for center card
                            if (widget.isCenter)
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                blurRadius: 30 + _elevationAnimation.value,
                                offset: const Offset(0, 0),
                                spreadRadius: 2,
                              ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(23),
                              child: Image.asset(
                                widget.imagePath,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            // Enhanced gradient overlay
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                  stops: const [0.5, 1.0],
                                ),
                              ),
                            ),
                            // Animated border
                            AnimatedBuilder(
                              animation: widget.animationController,
                              builder: (context, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(23),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white.withOpacity(
                                        (0.5 * widget.animationController.value)
                                            .clamp(0.0, 1.0),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Scroll animation shimmer effect
                            if (_cardFadeAnimation.value < 0.9)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(23),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(
                                          (0.3 * (1 - _cardFadeAnimation.value))
                                              .clamp(0.0, 0.3),
                                        ),
                                        Colors.transparent,
                                        Colors.white.withOpacity(
                                          (0.2 * (1 - _cardFadeAnimation.value))
                                              .clamp(0.0, 0.2),
                                        ),
                                      ],
                                      stops: const [0.0, 0.5, 1.0],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Description with animation
                      Transform.translate(
                        offset: Offset(
                          0,
                          (10 * (1 - _cardFadeAnimation.value)).clamp(
                            0.0,
                            10.0,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(
                                  (0.3 * _cardFadeAnimation.value).clamp(
                                    0.0,
                                    0.3,
                                  ),
                                ),
                                Colors.white.withOpacity(
                                  (0.1 * _cardFadeAnimation.value).clamp(
                                    0.0,
                                    0.1,
                                  ),
                                ),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(
                                (0.3 * _cardFadeAnimation.value).clamp(
                                  0.0,
                                  0.3,
                                ),
                              ),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  (0.2 * _cardFadeAnimation.value).clamp(
                                    0.0,
                                    0.2,
                                  ),
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            widget.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(
                                _cardFadeAnimation.value.clamp(0.0, 1.0),
                              ),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(
                                    (0.5 * _cardFadeAnimation.value).clamp(
                                      0.0,
                                      0.5,
                                    ),
                                  ),
                                  offset: const Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
