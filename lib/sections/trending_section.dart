import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class UpcomingEventsSection extends StatefulWidget {
  const UpcomingEventsSection({super.key});

  @override
  State<UpcomingEventsSection> createState() => _UpcomingEventsSectionState();
}

class _UpcomingEventsSectionState extends State<UpcomingEventsSection> {
  late PageController _pageController;
  int _currentPage = 1000; // Start at a high number for infinite scroll

  final List<EventCard> events = const [
    EventCard(
      title: 'Kevin Hart: Acting My Age | India',
      venue: 'Indira Gandhi Arena, Delhi',
      date: '30 April 2025',
      day: 'Wed',
      price: '₹699',
      image: 'assets/images/e1.jpg',
    ),
    EventCard(
      title: 'Imagine Dragons Live',
      venue: 'JLN Stadium, Mumbai',
      date: '5 May 2025',
      day: 'Sun',
      price: '₹999',
      image: 'assets/images/e2.jpg',
    ),
    EventCard(
      title: 'Arijit Singh Concert',
      venue: 'Bangalore Palace Grounds',
      date: '10 May 2025',
      day: 'Fri',
      price: '₹850',
      image: 'assets/images/e3.jpg',
    ),
    EventCard(
      title: 'Sunburn Goa Festival',
      venue: 'Vagator Beach, Goa',
      date: '25 Dec 2025',
      day: 'Thu',
      price: '₹1500',
      image: 'assets/images/e4.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.85,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Events',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 360,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              // Use modulo to cycle through events infinitely
              final eventIndex = index % events.length;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: events[eventIndex],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Optional: Add page indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            events.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    (_currentPage % events.length) == index
                        ? const Color(0xFFB7FF1C)
                        : Colors.white24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatefulWidget {
  final String title;
  final String venue;
  final String date;
  final String day;
  final String price;
  final String image;

  const EventCard({
    super.key,
    required this.title,
    required this.venue,
    required this.date,
    required this.day,
    required this.price,
    required this.image,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 440,
      margin: const EdgeInsets.only(right: 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E2E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with date and heart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      widget.day,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.date,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => isLiked = !isLiked),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(isLiked),
                    color: isLiked ? Colors.redAccent : const Color(0xFFB7FF1C),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 50,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.venue,
            style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11),
          ),
          const Divider(color: Colors.white24, height: 20),

          // Bottom row with price and button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Starts from\n${widget.price}',
                style: GoogleFonts.poppins(fontSize: 11, color: Colors.white60),
              ),
              NeoPopButton(
                color: const Color(0xFFB7FF1C),
                animationDuration: const Duration(milliseconds: 500),
                onTapUp: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Booking ${widget.title}...'),
                      backgroundColor: const Color(0xFFB7FF1C),
                    ),
                  );
                },
                onTapDown: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Text(
                    'Book Now',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
