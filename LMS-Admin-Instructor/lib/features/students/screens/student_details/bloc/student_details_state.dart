part of 'student_details_bloc.dart';

abstract class StudentDetailsState {}

class StudentDetailsInitial extends StudentDetailsState {}

class StudentDetailsStateLoading extends StudentDetailsState {}

class StudentDetailsStateSuccess extends StudentDetailsState {
  final StudentDetailsModel studentDetails;
  StudentDetailsStateSuccess({required this.studentDetails});
}

class StudentDetailsStateError extends StudentDetailsState {
  final String message;
  StudentDetailsStateError({required this.message});
}