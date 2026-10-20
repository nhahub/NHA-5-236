import 'package:bloc/bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/repository/instructor_admin_repoditory.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_state.dart';

class InstructorAdminBloc
    extends Bloc<InstructorAdminEvent, InstructorAdminState> {
  final InstructorAdminRepository instructorAdminRepository;

  InstructorAdminBloc({required this.instructorAdminRepository})
    : super(InstructorAdminInitial()) {
    on<GetInstructorAdminEvent>(_onGetInstructorAdminEvent);
    on<AddInstructorEvent>(_onAddInstructorEvent);
    on<GetInstructorBySlugEvent>(_onGetInstructorBySlugEvent);
    on<DeleteInstructorEvent>(_onDeleteInstructorEvent);
  }

  Future<void> _onDeleteInstructorEvent(
    DeleteInstructorEvent event,
    Emitter<InstructorAdminState> emit,
  ) async {
    emit(DeleteInstructorLoading());
    final result = await instructorAdminRepository.deleteInstructor(event.slug);
    result.fold(
      (failure) => emit(DeleteInstructorError(message: failure)),
      (success) => emit(DeleteInstructorSuccess()),
    );
  }

  Future<void> _onGetInstructorAdminEvent(
    GetInstructorAdminEvent event,
    Emitter<InstructorAdminState> emit,
  ) async {
    final currentState = state;
    final int pageToFetch = event.page ?? 1;

    if (pageToFetch == 1) {
      emit(InstructorAdminLoading());
    } else {
      if (currentState is InstructorAdminLoaded) {
        if (currentState.instructorAdminUiModel.currentPage >=
            currentState.instructorAdminUiModel.totalPages) {
          return;
        }
        emit(currentState.copyWith(isPaginationLoading: true));
      } else {
        emit(InstructorAdminLoading());
      }
    }

    final result = await instructorAdminRepository.getInstructorAdmin(
      pageToFetch,
      event.pageSize,
      event.search,
    );

    result.fold((failure) => emit(InstructorAdminError(message: failure)), (
      responseModel,
    ) {
      var newEntity = responseModel.toEntity();

      // Local Filtering Fallback
      if (event.search != null && event.search!.isNotEmpty) {
        final query = event.search!.toLowerCase();
        final filteredInstructors = newEntity.instructors.where((instructor) {
          return instructor.first_name.toLowerCase().contains(query) ||
              instructor.last_name.toLowerCase().contains(query) ||
              instructor.email.toLowerCase().contains(query);
        }).toList();
        newEntity = newEntity.copyWith(instructors: filteredInstructors);
      }

      if (pageToFetch == 1 || currentState is! InstructorAdminLoaded) {
        emit(InstructorAdminLoaded(instructorAdminUiModel: newEntity));
      } else {
        final accumulatedInstructors = [
          ...currentState.instructorAdminUiModel.instructors,
          ...newEntity.instructors,
        ];
        emit(
          InstructorAdminLoaded(
            instructorAdminUiModel: newEntity.copyWith(
              instructors: accumulatedInstructors,
            ),
            isPaginationLoading: false,
          ),
        );
      }
    });
  }

  Future<void> _onAddInstructorEvent(
    AddInstructorEvent event,
    Emitter<InstructorAdminState> emit,
  ) async {
    emit(AddInstructorLoading());
    final result = await instructorAdminRepository.addInstructor(
      event.first_name,
      event.last_name,
      event.email,
    );
    result.fold(
      (failure) => emit(AddInstructorError(message: failure)),
      (responseModel) =>
          emit(AddInstructorSuccess(addInstructorModel: responseModel)),
    );
  }

  Future<void> _onGetInstructorBySlugEvent(
    GetInstructorBySlugEvent event,
    Emitter<InstructorAdminState> emit,
  ) async {
    emit(InstructorDetailsLoading());
    final result = await instructorAdminRepository.getInstructorBySlug(
      event.slug,
    );
    result.fold(
      (failure) => emit(InstructorDetailsError(message: failure)),
      (responseModel) => emit(
        InstructorDetailsLoaded(
          instructorDetailsUiModel: responseModel.toEntity(),
        ),
      ),
    );
  }
}
