import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/admin_profile_repository.dart';
import 'admin_profile_event.dart';
import 'admin_profile_state.dart';

class AdminProfileBloc extends Bloc<AdminProfileEvent, AdminProfileState> {
  final AdminProfileRepository repository;

  AdminProfileBloc({required this.repository}) : super(AdminProfileInitial()) {
    on<GetAdminProfileEvent>(_onGetAdminProfile);
  }

  Future<void> _onGetAdminProfile(
    GetAdminProfileEvent event,
    Emitter<AdminProfileState> emit,
  ) async {
    emit(AdminProfileLoading());

    final result = await repository.getAdminProfile(event.slug);

    result.fold((error) => emit(AdminProfileError(message: error)), (response) {
      if (response.data != null) {
        emit(AdminProfileLoaded(profile: response.data!.toEntity()));
      } else {
        emit(AdminProfileError(message: "Failed to load profile"));
      }
    });
  }
}
