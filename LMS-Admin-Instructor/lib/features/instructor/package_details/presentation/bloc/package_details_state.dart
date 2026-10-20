import '../../domain/entity/package_details_ui_model.dart';

abstract class PackageDetailsState {}

class PackageDetailsInitial extends PackageDetailsState {}

class PackageDetailsLoading extends PackageDetailsState {}

class PackageDetailsLoaded extends PackageDetailsState {
  final PackageDetailsUIModel packageDetails;

  PackageDetailsLoaded({required this.packageDetails});
}

class PackageDetailsError extends PackageDetailsState {
  final String message;

  PackageDetailsError({required this.message});
}

class UpdatePackageLoading extends PackageDetailsState {}

class UpdatePackageSuccess extends PackageDetailsState {
  final String message;

  UpdatePackageSuccess({required this.message});
}

class UpdatePackageError extends PackageDetailsState {
  final String message;

  UpdatePackageError({required this.message});
}
