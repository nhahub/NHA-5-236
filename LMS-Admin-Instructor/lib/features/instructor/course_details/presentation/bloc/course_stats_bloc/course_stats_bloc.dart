import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/repositories/course_details_repository.dart';

import 'course_stats_event.dart';
import 'course_stats_state.dart';

class CourseStatsBloc extends Bloc<CourseStatsEvent, CourseStatsState> {
  final CourseDetailsRepository repository;

  CourseStatsBloc({required this.repository}) : super(CourseStatsInitial()) {
    on<GetCourseStatsEvent>(_onGetCourseStatsEvent);
  }

  Future<void> _onGetCourseStatsEvent(
    GetCourseStatsEvent event,
    Emitter<CourseStatsState> emit,
  ) async {
    emit(CourseStatsLoading());

    final failureOrCourseStats = await repository.getCourseStats(event.slug);

    failureOrCourseStats.fold(
      (failure) => emit(CourseStatsError(message: failure)),
      (success) {
        if (success.data != null) {
          emit(CourseStatsLoaded(courseStats: success.data!.toEntity()));
        } else {
          emit(CourseStatsError(message: success.message ?? 'Unknown error occurred'));
        }
      },
    );
  }
}
