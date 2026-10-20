import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/features/home/presentation/screens/dashboard_screen.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/instructor_admin_screen.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/screens/courses_instructor_screen.dart';
import 'package:lms_admin_instructor/features/settings/presentation/screens/settings_screen.dart';
import 'package:lms_admin_instructor/features/students/screens/students_list/presentation/student_screen.dart';

import 'package:lms_admin_instructor/features/admin/all_courses_admin/presentation/screens/all_courses_admin_screen.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/screens/packages_instructor_screen.dart';

class NavItemModel {
  final IconData icon;
  final String label;
  final Widget screen;
  final int index;

  const NavItemModel({
    required this.icon,
    required this.label,
    required this.screen,
    required this.index,
  });
}

final List<NavItemModel> adminNavItems = [
  const NavItemModel(
    icon: Icons.dashboard_outlined,
    label: 'dashboard',
    screen: DashboardScreen(),
    index: 0,
  ),
  const NavItemModel(
    icon: Icons.groups_outlined,
    label: 'instructors',
    screen: InstructorAdminScreen(),
    index: 1,
  ),
  const NavItemModel(
    icon: Icons.school_outlined,
    label: 'students',
    screen: StudentScreen(),
    index: 2,
  ),
  const NavItemModel(
    icon: Icons.menu_book_outlined,
    label: 'courses',
    screen: AllCoursesAdminScreen(),
    index: 3,
  ),
  // const NavItemModel(
  //   icon: Icons.campaign_outlined,
  //   label: 'announcement',
  //   screen: Ttt(),
  //   index: 4,
  // ),
  const NavItemModel(
    icon: Icons.settings_outlined,
    label: 'settings',
    screen: SettingsScreen(),
    index: 4,
  ),
];

final List<NavItemModel> instructorNavItems = [
  const NavItemModel(
    icon: Icons.dashboard_outlined,
    label: 'dashboard',
    screen: DashboardScreen(),
    index: 0,
  ),
  const NavItemModel(
    icon: Icons.groups_outlined,
    label: 'students',
    screen: StudentScreen(),
    index: 1,
  ),
  const NavItemModel(
    icon: Icons.school_outlined,
    label: 'courses',
    screen: CoursesInstructorScreen(),
    index: 2,
  ),
  const NavItemModel(
    icon: Icons.menu_book_outlined,
    label: 'packages',
    screen: PackagesInstructorScreen(),
    index: 3,
  ),
  // const NavItemModel(
  //   icon: Icons.campaign_outlined,
  //   label: 'announcement',
  //   screen: Ttt(),
  //   index: 4,
  // ),
  const NavItemModel(
    icon: Icons.settings_outlined,
    label: 'settings',
    screen: SettingsScreen(),
    index: 4,
  ),
];
