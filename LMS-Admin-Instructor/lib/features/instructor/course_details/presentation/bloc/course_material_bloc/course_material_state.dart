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



