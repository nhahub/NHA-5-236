import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/root/models/nav_items.dart';

class AdminBottomBar extends StatelessWidget {
  final List<NavItemModel> navItems;
  final int currentIndex;
  final Function(int) onTap;

  const AdminBottomBar({
    super.key,
    required this.navItems,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          height: 85.h,
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withValues(alpha: 0.1),
            border: Border(
              top: BorderSide(
                color: context.colorScheme.onSurface.withValues(alpha: 0.1),
                width: 0.5,
              ),
            ),
          ),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: context.isTablet ? 500.w : double.infinity,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: navItems.map((item) {
                  return _BottomNavItem(
                    icon: item.icon,
                    label: item.label,
                    index: item.index,
                    isSelected: currentIndex == item.index,
                    onTap: () => onTap(item.index),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurface.withValues(alpha: 0.4),
              size: 24.sp,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isSelected ? 16.h : 0,
              child: isSelected
                  ? Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        context.tr(label),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
