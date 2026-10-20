import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_stats_ui_model.dart';

abstract class CourseStatsState {}

class CourseStatsInitial extends CourseStatsState {}

class CourseStatsLoading extends CourseStatsState {}

class CourseStatsLoaded extends CourseStatsState {
  final CourseStatsUIModel courseStats;

  CourseStatsLoaded({required this.courseStats});
}

class CourseStatsError extends CourseStatsState {
  final String message;

  CourseStatsError({required this.message});
}
