import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/presentation/bloc/package_details_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/presentation/bloc/package_details_event.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/presentation/screens/package_details_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/common/user_role_enum.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_bloc.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_bloc.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/auth_layout.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/login_screen/login_screen.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/reset_password_screen/reset_password_screen.dart';
import 'package:lms_admin_instructor/features/instructor/add_new_video/presentation/bloc/add_new_video_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/bloc/course_students_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/bloc/course_students_event.dart';
import 'package:lms_admin_instructor/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:lms_admin_instructor/features/splash/presentation/screens/splash_screen.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/add_instructor_admin_screen.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/instructor_details_admin_screen.dart';
import 'package:lms_admin_instructor/features/students/screens/student_details/bloc/student_details_bloc.dart';
import 'package:lms_admin_instructor/features/students/screens/student_details/screens/student_details_screen.dart';

import 'package:lms_admin_instructor/features/students/screens/add_student_screen/add_student_admin_screen.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/course_details_screen.dart';
import 'package:lms_admin_instructor/features/instructor/manage_quiz_instructor/presentation/bloc/manage_quiz_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/manage_quiz_instructor/presentation/screens/manage_quiz_instructor_screen.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_event.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/screens/course_materials_screen.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/pdf_viewer_screen.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/manage_materials_instructor/presentation/bloc/course_material_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/screens/course_students_instructor_screen.dart';
import 'package:lms_admin_instructor/features/students/screens/students_list/bloc/student_bloc.dart';
import 'package:lms_admin_instructor/root/bloc/root_bloc.dart';
import 'package:lms_admin_instructor/root/custom_view_nav_bar.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/screens/instructor_profile_screen.dart';
import 'package:lms_admin_instructor/features/change_password/presentation/screens/change_password_screen.dart';
import 'package:lms_admin_instructor/features/change_password/presentation/bloc/change_password_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/bloc/profile_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/bloc/profile_instructor_event.dart';
import 'package:lms_admin_instructor/features/admin/admin_profile/presentation/screens/admin_profile_screen.dart';
import 'package:lms_admin_instructor/features/admin/admin_profile/presentation/bloc/admin_profile_bloc.dart';
import 'package:lms_admin_instructor/features/admin/admin_profile/presentation/bloc/admin_profile_event.dart';

class RouterGenerator {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<SplashBloc>(),
            child: const SplashScreen(),
          );
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider.value(
            value: sl<AuthBloc>(),
            child: AuthLayout(child: child),
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.loginScreen,
            name: AppRoutes.loginScreen,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const LoginScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          ),
          GoRoute(
            path: AppRoutes.forgotPasswordScreen,
            name: AppRoutes.forgotPasswordScreen,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ForgotPasswordScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          ),
          GoRoute(
            path: AppRoutes.resetPasswordScreen,
            name: AppRoutes.resetPasswordScreen,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ResetPasswordScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => Container(),
      ),
      GoRoute(
        path: AppRoutes.navBar,
        name: AppRoutes.navBar,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final roleStr =
              extra?['role'] is UserRole
                  ? (extra?['role'] as UserRole).name
                  : extra?['role'] as String? ??
                  sl<CacheHelper>().getDataString(key: ApiKey.role) ??
                  '';
          final role = UserRole.fromString(roleStr);
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<InstructorAdminBloc>()),
              BlocProvider.value(value: sl<StudentBloc>()),
              BlocProvider.value(value: sl<RootBloc>()),
              BlocProvider.value(value: sl<CoursesInstructorBloc>()),
              BlocProvider.value(value: sl<AuthBloc>()),
            ],
            child: CustomViewNavBar(role: role),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.addInstructorAdminScreen,
        name: AppRoutes.addInstructorAdminScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<InstructorAdminBloc>(),
          child: const AddInstructorAdminScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.addStudentAdminScreen,
        name: AppRoutes.addStudentAdminScreen,
        builder: (context, state) => const AddStudentAdminScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileInstructorAdminScreen,
        name: AppRoutes.profileInstructorAdminScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<InstructorAdminBloc>()),
            BlocProvider.value(value: sl<InstructorDetailsBloc>()),
          ],
          child: InstructorDetailsAdminScreen(
            slug: state.extra as String? ?? '',
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.studentDetails,
        name: AppRoutes.studentDetails,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: sl<StudentBloc>()),
            BlocProvider(create: (context) => sl<StudentDetailsBloc>()),
          ],
          child: StudentDetailsScreen(
            slug: state.extra as String? ?? '',
          ),
        ),
      ),


      GoRoute(
        path: AppRoutes.packageDetails,
        name: AppRoutes.packageDetails,
        builder: (context, state) {
          final slug = state.pathParameters['slug'] ?? '';
          return BlocProvider(
            create: (context) => sl<PackageDetailsBloc>()
              ..add(GetPackageDetailsEvent(slug: slug)),
            child: PackageDetailsScreen(slug: slug),
          );
        },
      ),


      GoRoute(
        path: AppRoutes.courseDetails,
        name: AppRoutes.courseDetails,
        builder: (context, state) {
          final slug = state.pathParameters['slug'] ?? '';
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    sl<CourseDetailsBloc>()
                      ..add(GetCourseDetailsEvent(slug: slug)),
              ),
              BlocProvider(
                create: (context) =>
                    sl<CourseStatsBloc>()..add(GetCourseStatsEvent(slug: slug)),
              ),
              BlocProvider(
                create: (context) =>
                    sl<CourseMaterialsBloc>()
                      ..add(GetCourseMaterialsEvent(slug: slug)),
              ),
              BlocProvider.value(value: sl<AddNewVideoBloc>()),
              BlocProvider.value(value: sl<CourseQuizBloc>()),
            ],
            child: CourseDetailsScreen(slug: slug),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.courseStudents,
        name: AppRoutes.courseStudents,
        builder: (context, state) {
          final slug = state.pathParameters['slug'] ?? '';
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    sl<CourseStatsBloc>()..add(GetCourseStatsEvent(slug: slug)),
              ),
              BlocProvider(
                create: (context) =>
                    sl<CourseStudentsBloc>()
                      ..add(GetCourseStudentsEvent(slug: slug, page: 1)),
              ),
            ],
            child: CourseStudentsInstructorScreen(slug: slug),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.manageQuizScreen,
        name: AppRoutes.manageQuizScreen,
        builder: (context, state) {
          final courseSlug = state.pathParameters['slug'] ?? '';
          final quizSlug = state.uri.queryParameters['quizSlug'];
          return BlocProvider(
            create: (context) => sl<ManageQuizInstructorBloc>(),
            child: ManageQuizScreen(courseSlug: courseSlug, quizSlug: quizSlug),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.courseMaterials,
        name: AppRoutes.courseMaterials,
        builder: (context, state) {
          final slug = state.pathParameters['slug'] ?? '';
          final courseName = state.extra as String? ?? '';
          return BlocProvider(
            create: (context) =>
                sl<CourseMaterialsBloc>()
                  ..add(GetCourseMaterialsEvent(slug: slug, page: 1)),
            child: CourseMaterialsScreen(slug: slug, courseName: courseName),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.instructorProfileScreen,
        name: AppRoutes.instructorProfileScreen,
        builder: (context, state) {
          final slug = sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
          return BlocProvider(
            create: (context) => sl<ProfileInstructorBloc>()
              ..add(GetProfileInstructorEvent(slug: slug)),
            child: const InstructorProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.adminProfileScreen,
        name: AppRoutes.adminProfileScreen,
        builder: (context, state) {
          final slug = sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
          return BlocProvider(
            create: (context) => sl<AdminProfileBloc>()
              ..add(GetAdminProfileEvent(slug: slug)),
            child: const AdminProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.pdfViewer,
        name: AppRoutes.pdfViewer,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PdfViewerScreen(
            url: extra?['url'] as String? ?? '',
            title: extra?['title'] as String? ?? 'PDF Viewer',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.changePasswordScreen,
        name: AppRoutes.changePasswordScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => sl<ChangePasswordBloc>(),
            child: const ChangePasswordScreen(),
          );
        },
      ),
    ],
  );
}
