import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_list_mixin.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/entity/course_instructor_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/repository/courses_instructor_repository.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_state.dart';

class CoursesInstructorBloc extends Bloc<CoursesInstructorEvent, CoursesInstructorState>
    with
        PaginatedListMixin<
            CoursesInstructorEvent,
            CoursesInstructorState,
            CourseInstructorItemUIModel,
            CourseInstructorListUIModel,
            CoursesInstructorLoaded,
            CoursesInstructorError,
            CoursesInstructorLoading> {
  final CoursesInstructorRepository repository;

  CoursesInstructorBloc({required this.repository})
      : super(CoursesInstructorInitial()) {
    on<GetCoursesInstructorEvent>(_onGetCourses);
    on<AddCourseInstructorEvent>(_onAddCourse);
  }

  Future<void> _onGetCourses(
    GetCoursesInstructorEvent event,
    Emitter<CoursesInstructorState> emit,
  ) async {
    final int pageToFetch = event.page ?? 1;

    if (!shouldHandlePagination(pageToFetch, state)) return;

    if (pageToFetch == 1) {
      emit(CoursesInstructorLoading());
    } else {
      emit((state as CoursesInstructorLoaded).copyWith(isPaginationLoading: true));
    }

    final response = await repository.getCoursesInstructor(
      instructorSlug: event.instructorSlug,
      page: pageToFetch,
      pageSize: event.pageSize,
      search: event.search,
    );

    response.fold(
      (error) => emit(CoursesInstructorError(message: error)),
      (responseModel) {
        var entity = responseModel.toEntity();

        // Local Filtering Fallback
        if (event.search != null && event.search!.isNotEmpty) {
          final query = event.search!.toLowerCase();
          final filteredCourses = entity.courses.where((course) {
            return course.title.toLowerCase().contains(query);
          }).toList();
          entity = entity.copyWith(courses: filteredCourses);
        }

        handlePaginatedResponse(
          page: pageToFetch,
          newEntity: entity,
          currentState: state,
          emit: emit.call,
          loadedStateBuilder: (model, isPaging) =>
              CoursesInstructorLoaded(courseListUIModel: model, isPaginationLoading: isPaging),
          errorStateBuilder: (msg) => CoursesInstructorError(message: msg),
          loadingStateBuilder: () => CoursesInstructorLoading(),
        );
      },
    );
  }

  Future<void> _onAddCourse(
    AddCourseInstructorEvent event,
    Emitter<CoursesInstructorState> emit,
  ) async {
    final currentState = state;
    emit(AddCourseLoading());
    
    final response = await repository.addCourse(
      requestModel: event.requestModel,
    );

    response.fold(
      (error) => emit(AddCourseError(message: error)),
      (successMessage) {
        emit(AddCourseSuccess(message: successMessage));
        if (currentState is CoursesInstructorLoaded) {
          emit(currentState);
        }
      },
    );
  }
}
