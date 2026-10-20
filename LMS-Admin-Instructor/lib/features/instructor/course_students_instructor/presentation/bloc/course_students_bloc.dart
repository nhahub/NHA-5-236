import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_list_mixin.dart';
import '../../domain/entity/course_student_ui_model.dart';
import '../../domain/repositories/course_students_repository.dart';
import 'course_students_event.dart';
import 'course_students_state.dart';

class CourseStudentsBloc extends Bloc<CourseStudentsEvent, CourseStudentsState>
    with
        PaginatedListMixin<
          CourseStudentsEvent,
          CourseStudentsState,
          CourseStudentItemUIModel,
          CourseStudentsListUIModel,
          CourseStudentsLoaded,
          CourseStudentsError,
          CourseStudentsLoading
        > {
  final CourseStudentsRepository _repository;

  CourseStudentsBloc(this._repository) : super(CourseStudentsInitial()) {
    on<GetCourseStudentsEvent>(_onGetCourseStudents);
  }

  Future<void> _onGetCourseStudents(
    GetCourseStudentsEvent event,
    Emitter<CourseStudentsState> emit,
  ) async {
    final int pageToFetch = event.page ?? 1;

    if (!shouldHandlePagination(pageToFetch, state)) return;

    if (pageToFetch == 1) {
      emit(CourseStudentsLoading());
    } else {
      emit((state as CourseStudentsLoaded).copyWith(isPaginationLoading: true));
    }

    final result = await _repository.getCourseStudents(
      slug: event.slug,
      page: pageToFetch,
      pageSize: event.pageSize,
      search: event.search,
    );

    result.fold((failure) => emit(CourseStudentsError(failure)), (
      responseModel,
    ) {
      var entity = responseModel.toEntity(
        currentPage: pageToFetch,
        pageSize: event.pageSize ?? 10,
      );

      if (event.search != null && event.search!.isNotEmpty) {
        final query = event.search!.toLowerCase();
        final filteredStudents = entity.students.where((student) {
          return student.name.toLowerCase().contains(query);
        }).toList();
        entity = entity.copyWith(students: filteredStudents);
      }

      handlePaginatedResponse(
        page: pageToFetch,
        newEntity: entity,
        currentState: state,
        emit: emit.call,
        loadedStateBuilder: (model, isPaging) => CourseStudentsLoaded(
          studentsListUIModel: model,
          isPaginationLoading: isPaging,
        ),
        errorStateBuilder: (msg) => CourseStudentsError(msg),
        loadingStateBuilder: () => CourseStudentsLoading(),
      );
    });
  }
}
