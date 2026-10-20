import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/students/data/model/student_details_model.dart';
import 'package:lms_admin_instructor/features/students/domain/repository/students_repository.dart';

part 'student_details_event.dart';
part 'student_details_state.dart';

class StudentDetailsBloc extends Bloc<StudentDetailsEvent, StudentDetailsState> {
  final StudentsRepository studentsRepository;
  StudentDetailsBloc({required this.studentsRepository})
    : super(StudentDetailsInitial()) {
    on<GetStudentDetailsData>(_onGetStudentDetailsData);
  }

  Future<void> _onGetStudentDetailsData(
    GetStudentDetailsData event,
    Emitter<StudentDetailsState> emit,
  ) async {
    emit(StudentDetailsStateLoading());
    final result = await studentsRepository.getStudentDetails(event.slug);
    result.fold(
      (failure) => emit(StudentDetailsStateError(message: failure)),
      (studentDetails) =>
          emit(StudentDetailsStateSuccess(studentDetails: studentDetails)),
    );
  }
}
