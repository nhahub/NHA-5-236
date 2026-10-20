part of 'student_details_bloc.dart';

abstract class StudentDetailsEvent {}

class GetStudentDetailsData extends StudentDetailsEvent {
  final String slug;
  GetStudentDetailsData(this.slug);
}