import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: GNav(
        gap: 8,
        activeColor: const Color.fromRGBO(239, 104, 44, 1),
        color: Colors.grey,
        iconSize: 24,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        duration: const Duration(milliseconds: 800),
        tabBackgroundColor: const Color.fromRGBO(253, 240, 231, 1),
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            borderRadius: BorderRadius.circular(12),
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Favorite',
            borderRadius: BorderRadius.circular(12),
          ),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
            borderRadius: BorderRadius.circular(12),
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            borderRadius: BorderRadius.circular(12),
          ),
        ],
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
      ),
    );
  }
}
