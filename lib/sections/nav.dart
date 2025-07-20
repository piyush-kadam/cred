import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTabSelected;

  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.home,
      Icons.bookmark,
      Icons.add_circle_outline,
      Icons.person,
      Icons.settings,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (isSelected)
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 35,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Icon(
                    icons[index],
                    color: isSelected ? Colors.white : Colors.white54,
                    size: 28,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
