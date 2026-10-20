import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_list_mixin.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/domain/entity/course_admin_ui_model.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/domain/repository/all_courses_admin_repository.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/presentation/bloc/all_courses_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/presentation/bloc/all_courses_admin_state.dart';

class AllCoursesAdminBloc
    extends Bloc<AllCoursesAdminEvent, AllCoursesAdminState>
    with
        PaginatedListMixin<
          AllCoursesAdminEvent,
          AllCoursesAdminState,
          CourseAdminItemUIModel,
          CourseAdminListUIModel,
          AllCoursesAdminLoaded,
          AllCoursesAdminError,
          AllCoursesAdminLoading
        > {
  final AllCoursesAdminRepository repository;

  AllCoursesAdminBloc({required this.repository})
    : super(AllCoursesAdminInitial()) {
    on<GetAllCoursesAdminEvent>(_onGetAllCourses);
    on<DeleteCourseAdminEvent>(_onDeleteCourse);
  }

  Future<void> _onDeleteCourse(
    DeleteCourseAdminEvent event,
    Emitter<AllCoursesAdminState> emit,
  ) async {
    emit(DeleteCourseAdminLoading());
    final response = await repository.deleteCourse(event.slug);
    response.fold(
      (error) => emit(DeleteCourseAdminError(message: error)),
      (message) => emit(DeleteCourseAdminSuccess(message: message)),
    );
  }

  Future<void> _onGetAllCourses(
    GetAllCoursesAdminEvent event,
    Emitter<AllCoursesAdminState> emit,
  ) async {
    final int pageToFetch = event.page ?? 1;

    if (!shouldHandlePagination(pageToFetch, state)) return;

    if (pageToFetch == 1) {
      emit(AllCoursesAdminLoading());
    } else {
      emit(
        (state as AllCoursesAdminLoaded).copyWith(isPaginationLoading: true),
      );
    }

    final response = await repository.getAllCourses(
      page: pageToFetch,
      pageSize: event.pageSize,
      search: event.search,
    );

    response.fold((error) => emit(AllCoursesAdminError(message: error)), (
      responseModel,
    ) {
      var entity = responseModel.toEntity();

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
        loadedStateBuilder: (model, isPaging) => AllCoursesAdminLoaded(
          courseListUIModel: model,
          isPaginationLoading: isPaging,
        ),
        errorStateBuilder: (msg) => AllCoursesAdminError(message: msg),
        loadingStateBuilder: () => AllCoursesAdminLoading(),
      );
    });
  }
}
