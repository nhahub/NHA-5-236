abstract class PaginatedUIModel<T> {
  final List<T> items;
  final int totalPages;
  final int currentPage;

  PaginatedUIModel({
    required this.items,
    required this.totalPages,
    required this.currentPage,
  });

  PaginatedUIModel<T> copyWithItems(List<T> newItems, {int? totalPages, int? currentPage});
}

abstract class PaginatedState<T, M extends PaginatedUIModel<T>> {
  final M? uiModel;
  final bool isPaginationLoading;

  PaginatedState({
    this.uiModel,
    this.isPaginationLoading = false,
  });
}
