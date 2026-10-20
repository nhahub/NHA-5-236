import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_materials_ui_model.dart';

abstract class CourseMaterialsState {}

class CourseMaterialsInitial extends CourseMaterialsState {}

class CourseMaterialsLoading extends CourseMaterialsState {}

class CourseMaterialsLoaded extends CourseMaterialsState
    implements
        PaginatedState<CourseMaterialItemUIModel, CourseMaterialsListUIModel> {
  final CourseMaterialsListUIModel materialsListUIModel;
  @override
  final bool isPaginationLoading;

  @override
  CourseMaterialsListUIModel? get uiModel => materialsListUIModel;

  CourseMaterialsLoaded({
    required this.materialsListUIModel,
    this.isPaginationLoading = false,
  });

  CourseMaterialsLoaded copyWith({
    CourseMaterialsListUIModel? materialsListUIModel,
    bool? isPaginationLoading,
  }) {
    return CourseMaterialsLoaded(
      materialsListUIModel: materialsListUIModel ?? this.materialsListUIModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class CourseMaterialsError extends CourseMaterialsState {
  final String message;
  CourseMaterialsError({required this.message});
}

class UploadMaterialLoading extends CourseMaterialsState {}

class UploadMaterialSuccess extends CourseMaterialsState {
  final String message;
  UploadMaterialSuccess({required this.message});
}

class UploadMaterialError extends CourseMaterialsState {
  final String message;
  UploadMaterialError({required this.message});
}

class DeleteMaterialLoading extends CourseMaterialsState {}

class DeleteMaterialSuccess extends CourseMaterialsState {
  final String message;
  DeleteMaterialSuccess({required this.message});
}

class DeleteMaterialError extends CourseMaterialsState {
  final String message;
  DeleteMaterialError({required this.message});
}

class UpdateMaterialLoading extends CourseMaterialsState {}

class UpdateMaterialSuccess extends CourseMaterialsState {
  final String message;
  UpdateMaterialSuccess({required this.message});
}

class UpdateMaterialError extends CourseMaterialsState {
  final String message;
  UpdateMaterialError({required this.message});
}
