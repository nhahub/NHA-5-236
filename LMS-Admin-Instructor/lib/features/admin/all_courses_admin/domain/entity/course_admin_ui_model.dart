import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/number_formatter.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';

class CourseAdminListUIModel extends PaginatedUIModel<CourseAdminItemUIModel> {
  final List<CourseAdminItemUIModel> courses;
  final int totalCourses;
  @override
  final int totalPages;
  @override
  final int currentPage;

  CourseAdminListUIModel({
    required this.courses,
    required this.totalCourses,
    required this.totalPages,
    required this.currentPage,
  }) : super(items: courses, totalPages: totalPages, currentPage: currentPage);

  @override
  CourseAdminListUIModel copyWithItems(
    List<CourseAdminItemUIModel> newItems, {
    int? totalPages,
    int? currentPage,
  }) {
    return CourseAdminListUIModel(
      courses: newItems,
      totalCourses: totalCourses,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  CourseAdminListUIModel copyWith({
    List<CourseAdminItemUIModel>? courses,
    int? totalCourses,
    int? totalPages,
    int? currentPage,
  }) {
    return CourseAdminListUIModel(
      courses: courses ?? this.courses,
      totalCourses: totalCourses ?? this.totalCourses,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class CourseAdminItemUIModel extends CustomDataTableRowModel {
  final String slug;
  final String title;
  final String instructorName;
  final String? createdAt;
  final int studentsCount;
  final int ratingsCount;
  final String? image;
  final VoidCallback? onActionPressed;
  final VoidCallback? onOptionsPressed;

  final IconData? actionIconpressed;
  final IconData? optionsIconpressed;

  CourseAdminItemUIModel({
    required this.slug,
    required this.title,
    required this.instructorName,
    required this.studentsCount,
    required this.ratingsCount,
    this.createdAt,
    this.image,
    this.onActionPressed,
    this.onOptionsPressed,
    this.actionIconpressed,
    this.optionsIconpressed,
  });

  CourseAdminItemUIModel copyWith({
    String? slug,
    String? title,
    String? instructorName,
    String? createdAt,
    int? studentsCount,
    int? ratingsCount,
    String? image,
    VoidCallback? onActionPressed,
    VoidCallback? onOptionsPressed,
    IconData? actionIconpressed,
    IconData? optionsIconpressed,
  }) {
    return CourseAdminItemUIModel(
      slug: slug ?? this.slug,
      title: title ?? this.title,
      instructorName: instructorName ?? this.instructorName,
      createdAt: createdAt ?? this.createdAt,
      studentsCount: studentsCount ?? this.studentsCount,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      image: image ?? this.image,
      onActionPressed: onActionPressed ?? this.onActionPressed,
      onOptionsPressed: onOptionsPressed ?? this.onOptionsPressed,
      actionIconpressed: actionIconpressed ?? this.actionIconpressed,
      optionsIconpressed: optionsIconpressed ?? this.optionsIconpressed,
    );
  }

  @override
  List<String> get rowTexts => [
        title,
        NumberFormatter.formatCount(studentsCount),
        NumberFormatter.formatCount(ratingsCount),
        createdAt?.split('T').first ?? 'N/A',
        instructorName,
      ];

  @override
  String? get avatarUrl => image;

  @override
  VoidCallback? get onAction => onActionPressed;

  @override
  IconData? get actionIcon =>
      actionIconpressed ?? Icons.arrow_forward_ios_rounded;

  @override
  VoidCallback? get onRowTap => onOptionsPressed;

  @override
  VoidCallback? get onOptions => onOptionsPressed;

  @override
  IconData? get optionsIcon => optionsIconpressed;
}
