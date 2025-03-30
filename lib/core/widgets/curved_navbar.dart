import 'package:flutter/material.dart';

class CurvedNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CurvedNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                isSelected: selectedIndex == 1,
                onTap: () => onTap(1),
              ),
              _buildAddButton(() => onTap(0)),
              _buildNavItem(
                icon: Icons.person_rounded,
                isSelected: selectedIndex == 2,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFE4A3) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFF2D2D2D) : Colors.grey,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildAddButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE4A3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Color(0xFF2D2D2D),
          size: 28,
        ),
      ),
    );
  }
}
