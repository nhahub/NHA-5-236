import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/add_instructor_disktop_admin_screen.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/add_instructor_mobile_admin_screen.dart';

class AddInstructorAdminScreen extends StatefulWidget {
  const AddInstructorAdminScreen({super.key});

  @override
  State<AddInstructorAdminScreen> createState() =>
      _AddInstructorAdminScreenState();
}

class _AddInstructorAdminScreenState extends State<AddInstructorAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.isDesktop
          ? const AddInstructorDisktopAdminScreen()
          : const AddInstructorMobileAdminScreen(),
    );
  }
}
