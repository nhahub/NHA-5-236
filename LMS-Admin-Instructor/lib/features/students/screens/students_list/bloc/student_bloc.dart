import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_list_mixin.dart';
import 'package:lms_admin_instructor/features/students/domain/entity/student_ui_model.dart';
import 'package:lms_admin_instructor/features/students/domain/repository/students_repository.dart';
import 'package:lms_admin_instructor/features/students/screens/students_list/bloc/student_event.dart';
import 'package:lms_admin_instructor/features/students/screens/students_list/bloc/student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState>
    with
        PaginatedListMixin<
          StudentEvent,
          StudentState,
          StudentItemUIModel,
          StudentUIModel,
          StudentLoaded,
          StudentError,
          StudentLoading
        > {
  final StudentsRepository studentsRepository;
  StudentBloc({required this.studentsRepository}) : super(StudentInitial()) {
    on<GetStudentsEvent>(_onGetStudentsEvent);
    on<DeleteStudentEvent>(_onDeleteStudentEvent);
  }

  Future<void> _onDeleteStudentEvent(
    DeleteStudentEvent event,
    Emitter<StudentState> emit,
  ) async {
    final currentState = state;
    if (currentState is StudentLoaded) {
      final result = await studentsRepository.deleteStudent(event.slug);

      result.fold(
        (failure) {
          // TODO: Unified Error/Toast handling
        },
        (unit) {
          final studentToDelete = currentState.studentUIModel.students
              .firstWhere((student) => student.slug == event.slug);
          final updatedStudents = currentState.studentUIModel.students
              .where((student) => student.slug != event.slug)
              .toList();

          emit(
            currentState.copyWith(
              studentUIModel: currentState.studentUIModel.copyWith(
                students: updatedStudents,
                totalStudents: currentState.studentUIModel.totalStudents - 1,
                totalEnrollments:
                    currentState.studentUIModel.totalEnrollments -
                    studentToDelete.enrollmentsCount,
              ),
            ),
          );

        },
      );
    }
  }

  Future<void> _onGetStudentsEvent(
    GetStudentsEvent event,
    Emitter<StudentState> emit,
  ) async {
    final int pageToFetch = event.page ?? 1;

    if (!shouldHandlePagination(pageToFetch, state)) return;

    if (pageToFetch == 1) {
      emit(StudentLoading());
    } else {
      emit((state as StudentLoaded).copyWith(isPaginationLoading: true));
    }

    final result = await studentsRepository.getStudents(
      page: pageToFetch,
      pageSize: event.pageSize,
      search: event.search,
    );

    result.fold((failure) => emit(StudentError(message: failure)), (
      responseModel,
    ) {
      var entity = responseModel.toEntity();

      if (event.search != null && event.search!.isNotEmpty) {
        final query = event.search!.toLowerCase();
        final filteredStudents = entity.students.where((student) {
          return student.studentName.toLowerCase().contains(query);
        }).toList();
        entity = entity.copyWith(students: filteredStudents);
      }

      handlePaginatedResponse(
        page: pageToFetch,
        newEntity: entity,
        currentState: state,
        emit: emit.call,
        loadedStateBuilder: (model, isPaging) => StudentLoaded(
          studentUIModel: model,
          isPaginationLoading: isPaging,
        ),
        errorStateBuilder: (msg) => StudentError(message: msg),
        loadingStateBuilder: () => StudentLoading(),
      );
    });
  }
}