import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/domain/entity/instructor_profile_ui_model.dart';
import '../../domain/repositories/profile_instructor_repository.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/bloc/profile_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/profile_instructor/presentation/bloc/profile_instructor_state.dart';

class ProfileInstructorBloc
    extends Bloc<ProfileInstructorEvent, ProfileInstructorState> {
  final ProfileInstructorRepository repository;

  ProfileInstructorBloc({required this.repository})
    : super(ProfileInstructorInitial()) {
    on<GetProfileInstructorEvent>(_onGetProfileInstructorEvent);
    on<UpdateProfileInstructorEvent>(_onUpdateProfileInstructorEvent);
    on<GetInstructorLinksEvent>(_onGetInstructorLinksEvent);
    on<AddInstructorLinkEvent>(_onAddInstructorLinkEvent);
    on<DeleteInstructorLinkEvent>(_onDeleteInstructorLinkEvent);
    on<UpdateInstructorLinkEvent>(_onUpdateInstructorLinkEvent);
  }

  Future<void> _onGetProfileInstructorEvent(
    GetProfileInstructorEvent event,
    Emitter<ProfileInstructorState> emit,
  ) async {
    emit(ProfileInstructorLoading());

    final response = await repository.getInstructorProfile(event.slug);

    response.fold((failure) => emit(ProfileInstructorError(message: failure)), (
      profileModel,
    ) {
      if (profileModel.data != null) {
        emit(ProfileInstructorLoaded(profile: profileModel.data!.toEntity()));
      } else {
        emit(
          ProfileInstructorError(
            message: profileModel.message ?? 'Unknown error occurred',
          ),
        );
      }
    });
  }

  Future<void> _onUpdateProfileInstructorEvent(
    UpdateProfileInstructorEvent event,
    Emitter<ProfileInstructorState> emit,
  ) async {
    InstructorProfileUIModel? currentProfile;
    if (state is ProfileInstructorLoaded) {
      currentProfile = (state as ProfileInstructorLoaded).profile;
    }

    emit(ProfileInstructorLoading());

    final response = await repository.updateInstructorProfile(
      slug: event.slug,
      requestModel: event.requestModel,
      imageBytes: event.imageBytes,
      imageName: event.imageName,
    );

    response.fold((failure) {
      emit(ProfileInstructorError(message: failure));
      if (currentProfile != null) {
        emit(ProfileInstructorLoaded(profile: currentProfile));
      }
    }, (profileModel) {
      if (profileModel.data != null) {
        var profile = profileModel.data!.toEntity();

        if (currentProfile != null) {
          profile = profile.copyWith(
            email: profile.email.isEmpty ? currentProfile.email : profile.email,
            createdAt: profile.createdAt.isEmpty
                ? currentProfile.createdAt
                : profile.createdAt,
            image: profile.image.isEmpty ? currentProfile.image : profile.image,
            slug: profile.slug.isEmpty ? currentProfile.slug : profile.slug,
          );
        }

        emit(
          ProfileInstructorUpdateSuccess(
            profile: profile,
            message: profileModel.message ?? 'Profile updated successfully',
          ),
        );
        emit(ProfileInstructorLoaded(profile: profile));
      } else {
        emit(
          ProfileInstructorError(
            message: profileModel.message ?? 'Unknown error occurred',
          ),
        );
        if (currentProfile != null) {
          emit(ProfileInstructorLoaded(profile: currentProfile));
        }
      }
    });
  }

  Future<void> _onGetInstructorLinksEvent(
    GetInstructorLinksEvent event,
    Emitter<ProfileInstructorState> emit,
  ) async {
    emit(GetInstructorLinksLoading());

    final response = await repository.getInstructorLinks(event.slug);

    response.fold(
      (failure) => emit(GetInstructorLinksError(message: failure)),
      (links) => emit(
        GetInstructorLinksSuccess(
          links: links.map((e) => e.toEntity()).toList(),
        ),
      ),
    );
  }

  Future<void> _onAddInstructorLinkEvent(
    AddInstructorLinkEvent event,
    Emitter<ProfileInstructorState> emit,
  ) async {
    emit(AddInstructorLinkLoading());

    final response = await repository.addInstructorLink(
      slug: event.slug,
      requestModel: event.requestModel,
    );

    response.fold(
      (failure) => emit(AddInstructorLinkError(message: failure)),
      (link) => emit(AddInstructorLinkSuccess(link: link.toEntity())),
    );
  }

  Future<void> _onDeleteInstructorLinkEvent(
    DeleteInstructorLinkEvent event,
    Emitter<ProfileInstructorState> emit,
  ) async {
    emit(DeleteInstructorLinkLoading());

    final response = await repository.deleteInstructorLink(event.linkSlug);

    response.fold(
      (failure) => emit(DeleteInstructorLinkError(message: failure)),
      (message) => emit(
        DeleteInstructorLinkSuccess(
          message: message,
          instructorSlug: event.instructorSlug,
        ),
      ),
    );
  }

  Future<void> _onUpdateInstructorLinkEvent(
    UpdateInstructorLinkEvent event,
    Emitter<ProfileInstructorState> emit,
  ) async {
    emit(UpdateInstructorLinkLoading());

    final response = await repository.updateInstructorLink(
      linkSlug: event.linkSlug,
      requestModel: event.requestModel,
    );

    response.fold(
      (failure) => emit(UpdateInstructorLinkError(message: failure)),
      (link) => emit(UpdateInstructorLinkSuccess(link: link.toEntity())),
    );
  }
}
