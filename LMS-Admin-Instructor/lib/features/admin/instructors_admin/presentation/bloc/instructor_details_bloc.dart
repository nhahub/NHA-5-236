import 'package:bloc/bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/repository/instructor_admin_repoditory.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_state.dart';

class InstructorDetailsBloc
    extends Bloc<InstructorDetailsEvent, InstructorDetailsState> {
  final InstructorAdminRepository instructorAdminRepository;

  InstructorDetailsBloc({required this.instructorAdminRepository})
    : super(InstructorDetailsInitial()) {
    on<GetInstructorCoursesEvent>(_onGetInstructorCoursesEvent);
  }

  Future<void> _onGetInstructorCoursesEvent(
    GetInstructorCoursesEvent event,
    Emitter<InstructorDetailsState> emit,
  ) async {
    final currentState = state;
    final int pageToFetch = event.page!;

    if (pageToFetch == 1) {
      emit(InstructorCoursesLoading());
    } else {
      if (currentState is InstructorCoursesLoaded) {
        if (currentState.instructorCourseAdminUiModel.data!.currentPage >=
            currentState.instructorCourseAdminUiModel.data!.totalPages) {
          return;
        }
        emit(currentState.copyWith(isPaginationLoading: true));
      } else {
        emit(InstructorCoursesLoading());
      }
    }

    final result = await instructorAdminRepository.getInstructorCoursesBySslug(
      pageToFetch,
      event.pageSize,
      event.slug,
      event.search,
    );
    result.fold(
      (failure) => emit(InstructorCoursesError(message: failure.toString())),
      (responseModel) {
        var newEntity = responseModel.toEntity();

        // Local Filtering Fallback
        if (event.search != null && event.search!.isNotEmpty) {
          final query = event.search!.toLowerCase();
          final filteredCourses = newEntity.data!.courses.where((course) {
            return course.title.toLowerCase().contains(query);
          }).toList();
          newEntity = newEntity.copyWith(
            data: newEntity.data!.copyWith(courses: filteredCourses),
          );
        }

        if (pageToFetch == 1 || currentState is! InstructorCoursesLoaded) {
          emit(
            InstructorCoursesLoaded(instructorCourseAdminUiModel: newEntity),
          );
        } else {
          final accumulatedInstructors = [
            ...currentState.instructorCourseAdminUiModel.data!.courses,
            ...newEntity.data!.courses,
          ];
          emit(
            InstructorCoursesLoaded(
              instructorCourseAdminUiModel: newEntity.copyWith(
                data: newEntity.data!.copyWith(courses: accumulatedInstructors),
              ),
            ),
          );
        }
      },
    );
  }
}
