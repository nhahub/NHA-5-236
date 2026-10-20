import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/package_details_repository.dart';
import 'package_details_event.dart';
import 'package_details_state.dart';

class PackageDetailsBloc extends Bloc<PackageDetailsEvent, PackageDetailsState> {
  final PackageDetailsRepository packageDetailsRepository;

  PackageDetailsBloc({required this.packageDetailsRepository})
      : super(PackageDetailsInitial()) {
    on<GetPackageDetailsEvent>(_onGetPackageDetails);
    on<UpdatePackageDetailsEvent>(_onUpdatePackageDetails);
  }

  Future<void> _onGetPackageDetails(
    GetPackageDetailsEvent event,
    Emitter<PackageDetailsState> emit,
  ) async {
    emit(PackageDetailsLoading());

    final result = await packageDetailsRepository.getPackageDetails(
      slug: event.slug,
    );

    result.fold(
      (failureMessage) => emit(PackageDetailsError(message: failureMessage)),
      (packageDetails) => emit(PackageDetailsLoaded(packageDetails: packageDetails)),
    );
  }

  Future<void> _onUpdatePackageDetails(
    UpdatePackageDetailsEvent event,
    Emitter<PackageDetailsState> emit,
  ) async {
    emit(UpdatePackageLoading());

    final result = await packageDetailsRepository.updatePackage(
      slug: event.slug,
      requestModel: event.requestModel,
    );

    result.fold(
      (failureMessage) => emit(UpdatePackageError(message: failureMessage)),
      (successMessage) => emit(UpdatePackageSuccess(message: successMessage)),
    );
  }
}
