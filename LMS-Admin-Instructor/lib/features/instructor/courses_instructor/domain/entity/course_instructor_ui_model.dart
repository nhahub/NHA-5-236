import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/utils/number_formatter.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';

import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';

class CourseInstructorListUIModel
    extends PaginatedUIModel<CourseInstructorItemUIModel> {
  final List<CourseInstructorItemUIModel> courses;
  final int totalCourses;
  @override
  final int totalPages;
  @override
  final int currentPage;

  CourseInstructorListUIModel({
    required this.courses,
    required this.totalCourses,
    required this.totalPages,
    required this.currentPage,
  }) : super(items: courses, totalPages: totalPages, currentPage: currentPage);

  @override
  CourseInstructorListUIModel copyWithItems(
    List<CourseInstructorItemUIModel> newItems, {
    int? totalPages,
    int? currentPage,
  }) {
    return CourseInstructorListUIModel(
      courses: newItems,
      totalCourses: totalCourses,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  CourseInstructorListUIModel copyWith({
    List<CourseInstructorItemUIModel>? courses,
    int? totalCourses,
    int? totalPages,
    int? currentPage,
  }) {
    return CourseInstructorListUIModel(
      courses: courses ?? this.courses,
      totalCourses: totalCourses ?? this.totalCourses,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class CourseInstructorItemUIModel extends CustomDataTableRowModel {
  final String slug;
  final String title;
  final String? createdAt;
  final int studentsCount;
  final int ratingsCount;
  final String? image;
  final VoidCallback? onActionPressed;
  final VoidCallback? onOptionsPressed;

  final IconData? actionIconpressed;
  final IconData? optionsIconpressed;

  CourseInstructorItemUIModel({
    required this.slug,
    required this.title,
    required this.studentsCount,
    required this.ratingsCount,
    this.createdAt,
    this.image,
    this.onActionPressed,
    this.onOptionsPressed,
    this.actionIconpressed,
    this.optionsIconpressed,
  });

  CourseInstructorItemUIModel copyWith({
    String? slug,
    String? title,
    String? createdAt,
    int? studentsCount,
    int? ratingsCount,
    String? image,
    VoidCallback? onActionPressed,
    VoidCallback? onOptionsPressed,
    IconData? actionIconpressed,
    IconData? optionsIconpressed,
  }) {
    return CourseInstructorItemUIModel(
      slug: slug ?? this.slug,
      title: title ?? this.title,
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
    createdAt ?? 'N/A',
  ];

  @override
  String? get avatarUrl => image;

  @override
  VoidCallback? get onAction => onActionPressed;

  @override
  IconData? get actionIcon => actionIconpressed ?? Icons.arrow_forward_ios_rounded;

  @override
  VoidCallback? get onRowTap => onOptionsPressed;

  @override
  VoidCallback? get onOptions => onOptionsPressed;

  @override
  IconData? get optionsIcon => optionsIconpressed;
}
