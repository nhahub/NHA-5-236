import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:lms_admin_instructor/core/common/user_role_enum.dart';
import 'package:lms_admin_instructor/root/models/nav_items.dart';
import 'package:lms_admin_instructor/root/screens/root_screen.dart';

class CustomViewNavBar extends StatefulWidget {
  final UserRole role;
  const CustomViewNavBar({super.key, required this.role});

  @override
  State<CustomViewNavBar> createState() => _CustomViewNavBarState();
}

class _CustomViewNavBarState extends State<CustomViewNavBar> {
  @override
  Widget build(BuildContext context) {
    log("Role is: ${widget.role}");
    return RootScreen(
      navItems: widget.role == UserRole.admin ? adminNavItems : instructorNavItems,
      isAdmin: widget.role == UserRole.admin,
    );
  }
}
