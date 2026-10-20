import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_list_mixin.dart';
import 'package:lms_admin_instructor/features/instructor/common/domain/repository/materials_repository.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_materials_ui_model.dart';
import 'course_material_event.dart';
import 'course_material_state.dart';

class CourseMaterialsBloc
    extends Bloc<CourseMaterialsEvent, CourseMaterialsState>
    with
        PaginatedListMixin<
          CourseMaterialsEvent,
          CourseMaterialsState,
          CourseMaterialItemUIModel,
          CourseMaterialsListUIModel,
          CourseMaterialsLoaded,
          CourseMaterialsError,
          CourseMaterialsLoading
        > {
  final MaterialsRepository repository;

  CourseMaterialsBloc({required this.repository})
    : super(CourseMaterialsInitial()) {
    on<GetCourseMaterialsEvent>(_onGetCourseMaterials);
    on<UploadMaterialEvent>(_onUploadMaterial);
    on<UpdateMaterialEvent>(_onUpdateMaterial);
    on<DeleteMaterialEvent>(_onDeleteMaterial);
  }

  Future<void> _onGetCourseMaterials(
    GetCourseMaterialsEvent event,
    Emitter<CourseMaterialsState> emit,
  ) async {
    final int pageToFetch = event.page ?? 1;

    if (!shouldHandlePagination(pageToFetch, state)) return;

    if (pageToFetch == 1) {
      if (state is! CourseMaterialsLoaded) {
        emit(CourseMaterialsLoading());
      }
    } else {
      emit(
        (state as CourseMaterialsLoaded).copyWith(isPaginationLoading: true),
      );
    }

    final response = await repository.getCourseMaterials(
      slug: event.slug,
      page: pageToFetch,
      pageSize: event.pageSize,
    );

    response.fold(
      (error) => emit(CourseMaterialsError(message: error)),
      (responseModel) {
      handlePaginatedResponse(
        page: pageToFetch,
        newEntity: responseModel.toEntity(),
        currentState: state,
        emit: emit.call,
          loadedStateBuilder: (model, isPaging) =>
              CourseMaterialsLoaded(materialsListUIModel: model, isPaginationLoading: isPaging),
        errorStateBuilder: (msg) => CourseMaterialsError(message: msg),
        loadingStateBuilder: () => CourseMaterialsLoading(),
      );
      },
    );
  }

  Future<void> _onUploadMaterial(
    UploadMaterialEvent event,
    Emitter<CourseMaterialsState> emit,
  ) async {
    final currentState = state;
    emit(UploadMaterialLoading());

    final response = await repository.uploadMaterial(
      requestModel: event.requestModel,
    );

    response.fold((error) => emit(UploadMaterialError(message: error)), (
      material,
    ) {
      emit(
        UploadMaterialSuccess(
          message: '${material.materialName} uploaded successfully',
        ),
      );
      if (currentState is CourseMaterialsLoaded) {
        emit(currentState);
      }
    });
  }

  Future<void> _onDeleteMaterial(
    DeleteMaterialEvent event,
    Emitter<CourseMaterialsState> emit,
  ) async {
    final currentState = state;
    emit(DeleteMaterialLoading());

    final response = await repository.deleteMaterial(
      courseSlug: event.courseSlug,
      materialSlug: event.materialSlug,
    );

    response.fold(
      (error) => emit(DeleteMaterialError(message: error)),
      (message) {
      emit(DeleteMaterialSuccess(message: message));
      if (currentState is CourseMaterialsLoaded) {
        emit(currentState);
      }
      },
    );
  }

  Future<void> _onUpdateMaterial(
    UpdateMaterialEvent event,
    Emitter<CourseMaterialsState> emit,
  ) async {
    final currentState = state;
    emit(UpdateMaterialLoading());

    final response = await repository.updateMaterial(
      requestModel: event.requestModel,
    );

    response.fold(
      (error) => emit(UpdateMaterialError(message: error)),
      (material) {
        emit(UpdateMaterialSuccess(
          message: '${material.materialName} updated successfully',
        ));
      if (currentState is CourseMaterialsLoaded) {
        emit(currentState);
      }
      },
    );
  }
}
