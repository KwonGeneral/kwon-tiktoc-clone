import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const _tabs = [
    _TabItem(icon: Icons.grid_view_outlined, activeIcon: Icons.grid_view),
    _TabItem(icon: Icons.lock_outline, activeIcon: Icons.lock),
    _TabItem(icon: Icons.bookmark_border, activeIcon: Icons.bookmark),
    _TabItem(icon: Icons.favorite_border, activeIcon: Icons.favorite),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.divider, width: 0.5),
        ),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = index == selectedIndex;
          final tab = _tabs[index];
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:
                          isSelected ? AppColors.white : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                ),
                child: Icon(
                  isSelected ? tab.activeIcon : tab.icon,
                  color: isSelected
                      ? AppColors.white
                      : AppColors.whiteSecondary,
                  size: 22,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TabItem {
  const _TabItem({required this.icon, required this.activeIcon});

  final IconData icon;
  final IconData activeIcon;
}
