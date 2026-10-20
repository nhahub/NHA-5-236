import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';

class InstructorPackageListUIModel extends PaginatedUIModel<InstructorPackageItemUIModel> {
  final List<InstructorPackageItemUIModel> packages;
  final int totalPackages;
  @override
  final int totalPages;
  @override
  final int currentPage;

  InstructorPackageListUIModel({
    required this.packages,
    required this.totalPackages,
    required this.totalPages,
    required this.currentPage,
  }) : super(items: packages, totalPages: totalPages, currentPage: currentPage);

  @override
  InstructorPackageListUIModel copyWithItems(
    List<InstructorPackageItemUIModel> newItems, {
    int? totalPages,
    int? currentPage,
  }) {
    return InstructorPackageListUIModel(
      packages: newItems,
      totalPackages: totalPackages,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  InstructorPackageListUIModel copyWith({
    List<InstructorPackageItemUIModel>? packages,
    int? totalPackages,
    int? totalPages,
    int? currentPage,
  }) {
    return InstructorPackageListUIModel(
      packages: packages ?? this.packages,
      totalPackages: totalPackages ?? this.totalPackages,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class InstructorPackageItemUIModel extends CustomDataTableRowModel {
  final String slug;
  final String title;
  final String description;
  final String price;
  final String? createdAt;
  final int coursesCount;
  final double avgRating;
  final List<String> categories;
  final List<String> courseSlugs;
  final String instructorName;

  final VoidCallback? onActionPressed;
  final VoidCallback? onOptionsPressed;
  final IconData? actionIconpressed;
  final IconData? optionsIconpressed;

  InstructorPackageItemUIModel({
    required this.slug,
    required this.title,
    required this.description,
    required this.price,
    required this.coursesCount,
    required this.avgRating,
    required this.categories,
    required this.courseSlugs,
    required this.instructorName,
    this.createdAt,
    this.onActionPressed,
    this.onOptionsPressed,
    this.actionIconpressed,
    this.optionsIconpressed,
  });

  InstructorPackageItemUIModel copyWith({
    String? slug,
    String? title,
    String? description,
    String? price,
    String? createdAt,
    int? coursesCount,
    double? avgRating,
    List<String>? categories,
    List<String>? courseSlugs,
    String? instructorName,
    VoidCallback? onActionPressed,
    VoidCallback? onOptionsPressed,
    IconData? actionIconpressed,
    IconData? optionsIconpressed,
  }) {
    return InstructorPackageItemUIModel(
      slug: slug ?? this.slug,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      coursesCount: coursesCount ?? this.coursesCount,
      avgRating: avgRating ?? this.avgRating,
      categories: categories ?? this.categories,
      courseSlugs: courseSlugs ?? this.courseSlugs,
      instructorName: instructorName ?? this.instructorName,
      onActionPressed: onActionPressed ?? this.onActionPressed,
      onOptionsPressed: onOptionsPressed ?? this.onOptionsPressed,
      actionIconpressed: actionIconpressed ?? this.actionIconpressed,
      optionsIconpressed: optionsIconpressed ?? this.optionsIconpressed,
    );
  }

  @override
  List<String> get rowTexts => [
    title,
    '\$$price',
    coursesCount.toString(),
    avgRating.toStringAsFixed(1),
    createdAt?.split('T').first ?? 'N/A',
  ];

  @override
  String? get avatarUrl => null;

  @override
  VoidCallback? get onAction => onActionPressed;

  @override
  IconData? get actionIcon => actionIconpressed ?? Icons.arrow_forward_ios_rounded;

  @override
  VoidCallback? get onRowTap => onActionPressed;

  @override
  VoidCallback? get onOptions => onOptionsPressed;

  @override
  IconData? get optionsIcon => optionsIconpressed;
}
