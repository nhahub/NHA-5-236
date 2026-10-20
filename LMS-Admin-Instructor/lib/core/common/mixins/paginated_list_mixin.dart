import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';

mixin PaginatedListMixin<
  E,
  S,
  T,
  M extends PaginatedUIModel<T>,
  L extends S,
  ERR extends S,
  LOAD extends S
>
    on Bloc<E, S> {
  void handlePaginatedResponse({
    required int page,
    required M newEntity,
    required S currentState,
    required void Function(S) emit,
    required L Function(M, bool) loadedStateBuilder,
    required ERR Function(String) errorStateBuilder,
    required LOAD Function() loadingStateBuilder,
  }) {
    if (page == 1 || currentState is! PaginatedState<T, M>) {
      emit(loadedStateBuilder(newEntity, false));
    } else {
      final currentModel = (currentState as PaginatedState<T, M>).uiModel;
      if (currentModel != null) {
        final accumulatedItems = [...currentModel.items, ...newEntity.items];

        final updatedModel =
            newEntity.copyWithItems(
                  accumulatedItems,
                  totalPages: newEntity.totalPages,
                  currentPage: newEntity.currentPage,
                )
                as M;

        emit(loadedStateBuilder(updatedModel, false));
      } else {
        emit(loadedStateBuilder(newEntity, false));
      }
    }
  }

  bool shouldHandlePagination(int page, S currentState) {
    if (page == 1) return true;
    if (currentState is PaginatedState<T, M>) {
      final model = currentState.uiModel;
      if (model != null) {
        return model.currentPage < model.totalPages &&
            !currentState.isPaginationLoading;
      }
    }
    return false;
  }
}
