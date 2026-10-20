import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/profile_instructor_disctop_admin_screen.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/profile_instructor_moblie_admin_screen.dart';

class InstructorDetailsAdminScreen extends StatefulWidget {
  final String slug;
  const InstructorDetailsAdminScreen({super.key, required this.slug});

  @override
  State<InstructorDetailsAdminScreen> createState() =>
      _InstructorDetailsAdminScreenState();
}

class _InstructorDetailsAdminScreenState
    extends State<InstructorDetailsAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.isDesktop
          ? InstructorDetailsDisktopAdminScreen(slug: widget.slug)
          : InstructorDetailsMobileAdminScreen(slug: widget.slug),
    );
  }
}
