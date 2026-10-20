import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/instructor_mobile_admin_screen.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/instructor_desktop_admin_screen.dart';

class InstructorAdminScreen extends StatefulWidget {
  const InstructorAdminScreen({super.key});

  @override
  State<InstructorAdminScreen> createState() => _InstructorAdminScreenState();
}

class _InstructorAdminScreenState extends State<InstructorAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.isDesktop
          ? const InstructorDesktopAdminScreen()
          : const InstructorMobileAdminScreen(),
    );
  }
}
