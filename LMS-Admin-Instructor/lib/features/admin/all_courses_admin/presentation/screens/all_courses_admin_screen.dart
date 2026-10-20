import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/presentation/bloc/all_courses_admin_bloc.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/presentation/bloc/all_courses_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/presentation/screens/all_courses_admin_desktop_screen.dart';

import 'package:lms_admin_instructor/core/di/service_locator.dart';

class AllCoursesAdminScreen extends StatelessWidget {
  const AllCoursesAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AllCoursesAdminBloc>()..add(const GetAllCoursesAdminEvent(page: 1)),
      child: const Scaffold(
        body: AllCoursesAdminDesktopScreen(),
      ),
    );
  }
}
