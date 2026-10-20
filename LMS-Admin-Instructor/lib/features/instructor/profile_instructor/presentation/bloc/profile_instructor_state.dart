import '../../domain/entity/instructor_profile_ui_model.dart';

abstract class ProfileInstructorState {}

class ProfileInstructorInitial extends ProfileInstructorState {}

class ProfileInstructorLoading extends ProfileInstructorState {}

class ProfileInstructorLoaded extends ProfileInstructorState {
  final InstructorProfileUIModel profile;

  ProfileInstructorLoaded({required this.profile});
}

class ProfileInstructorError extends ProfileInstructorState {
  final String message;

  ProfileInstructorError({required this.message});
}

class ProfileInstructorUpdateSuccess extends ProfileInstructorState {
  final InstructorProfileUIModel profile;
  final String message;

  ProfileInstructorUpdateSuccess({
    required this.profile,
    required this.message,
  });
}

class GetInstructorLinksLoading extends ProfileInstructorState {}

class GetInstructorLinksSuccess extends ProfileInstructorState {
  final List<InstructorLinkUIModel> links;

  GetInstructorLinksSuccess({required this.links});
}

class GetInstructorLinksError extends ProfileInstructorState {
  final String message;

  GetInstructorLinksError({required this.message});
}

class AddInstructorLinkLoading extends ProfileInstructorState {}

class AddInstructorLinkSuccess extends ProfileInstructorState {
  final InstructorLinkUIModel link;

  AddInstructorLinkSuccess({required this.link});
}

class AddInstructorLinkError extends ProfileInstructorState {
  final String message;

  AddInstructorLinkError({required this.message});
}

class DeleteInstructorLinkLoading extends ProfileInstructorState {}

class DeleteInstructorLinkSuccess extends ProfileInstructorState {
  final String message;
  final String instructorSlug;

  DeleteInstructorLinkSuccess({
    required this.message,
    required this.instructorSlug,
  });
}

class DeleteInstructorLinkError extends ProfileInstructorState {
  final String message;

  DeleteInstructorLinkError({required this.message});
}

class UpdateInstructorLinkLoading extends ProfileInstructorState {}

class UpdateInstructorLinkSuccess extends ProfileInstructorState {
  final InstructorLinkUIModel link;

  UpdateInstructorLinkSuccess({required this.link});
}

class UpdateInstructorLinkError extends ProfileInstructorState {
  final String message;

  UpdateInstructorLinkError({required this.message});
}
