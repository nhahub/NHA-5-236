import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/screens/courses_instructor_desktop_screen.dart';

class CoursesInstructorScreen extends StatefulWidget {
  const CoursesInstructorScreen({super.key});

  @override
  State<CoursesInstructorScreen> createState() =>
      _CoursesInstructorScreenState();
}

class _CoursesInstructorScreenState extends State<CoursesInstructorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CoursesInstructorDesktopScreen());
  }
}
