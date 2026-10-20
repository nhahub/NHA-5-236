import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';

class CourseMaterialsListUIModel extends PaginatedUIModel<CourseMaterialItemUIModel> {
  final List<CourseMaterialItemUIModel> materials;
  @override
  final int totalPages;
  @override
  final int currentPage;
  final int totalMaterials;

  CourseMaterialsListUIModel({
    required this.materials,
    required this.totalPages,
    required this.currentPage,
    required this.totalMaterials,
  }) : super(items: materials, totalPages: totalPages, currentPage: currentPage);

  @override
  CourseMaterialsListUIModel copyWithItems(
    List<CourseMaterialItemUIModel> newItems, {
    int? totalPages,
    int? currentPage,
  }) {
    return CourseMaterialsListUIModel(
      materials: newItems,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      totalMaterials: totalMaterials,
    );
  }

  CourseMaterialsListUIModel copyWith({
    List<CourseMaterialItemUIModel>? materials,
    int? totalPages,
    int? currentPage,
    int? totalMaterials,
  }) {
    return CourseMaterialsListUIModel(
      materials: materials ?? this.materials,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      totalMaterials: totalMaterials ?? this.totalMaterials,
    );
  }
}

class CourseMaterialItemUIModel {
  final String slug;
  final String course;
  final String materialName;
  final String? file;
  final String? fileSize;
  final String? createdAt;

  CourseMaterialItemUIModel({
    required this.slug,
    required this.course,
    required this.materialName,
    this.file,
    this.fileSize,
    this.createdAt,
  });

  CourseMaterialItemUIModel copyWith({
    String? slug,
    String? course,
    String? materialName,
    String? file,
    String? fileSize,
    String? createdAt,
  }) {
    return CourseMaterialItemUIModel(
      slug: slug ?? this.slug,
      course: course ?? this.course,
      materialName: materialName ?? this.materialName,
      file: file ?? this.file,
      fileSize: fileSize ?? this.fileSize,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
