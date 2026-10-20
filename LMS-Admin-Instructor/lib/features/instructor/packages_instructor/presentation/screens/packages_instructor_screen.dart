import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/bloc/packages_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/screens/packages_instructor_desktop_screen.dart';

class PackagesInstructorScreen extends StatefulWidget {
  const PackagesInstructorScreen({super.key});

  @override
  State<PackagesInstructorScreen> createState() => _PackagesInstructorScreenState();
}

class _PackagesInstructorScreenState extends State<PackagesInstructorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<PackagesInstructorBloc>(),
        child: const PackagesInstructorDesktopScreen(),
      ),
    );
  }
}
