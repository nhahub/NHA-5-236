import 'dart:ui';

import 'package:flutter/src/widgets/icon_data.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';

class InstructorAdminUiModel {
  final List<InstructoritemUiModel> instructors;
  final int totalInstructors;
  final int totalPages;
  final int currentPage;

  InstructorAdminUiModel({
    required this.instructors,
    required this.totalInstructors,
    required this.totalPages,
    required this.currentPage,
  });

  InstructorAdminUiModel copyWith({
    List<InstructoritemUiModel>? instructors,
    int? totalInstructors,
    int? totalPages,
    int? currentPage,
  }) {
    return InstructorAdminUiModel(
      instructors: instructors ?? this.instructors,
      totalInstructors: totalInstructors ?? this.totalInstructors,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

// ── Link entity ──────────────────────────────────────────────────────────────
class InstructorLinkUiModel {
  final String slug;
  final String platformName;
  final String url;

  InstructorLinkUiModel({
    required this.slug,
    required this.platformName,
    required this.url,
  });
}

// ── Instructor row entity ─────────────────────────────────────────────────────
class InstructoritemUiModel extends CustomDataTableRowModel {
  final String first_name;
  final String last_name;
  final String email;
  final String slug;
  final String? bio;
  final String? description;
  final String? image;
  final String? joindata;
  final List<InstructorLinkUiModel>? links;
  final VoidCallback? onActionPressed;
  final VoidCallback? onOptionsPressed;
  final IconData? actionIconpressed;
  final IconData? optionsIconpressed;

  InstructoritemUiModel({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.slug,
    this.bio,
    this.description,
    this.image,
    this.joindata,
    this.links,
    this.onActionPressed,
    this.onOptionsPressed,
    this.actionIconpressed,
    this.optionsIconpressed,
  });

  InstructoritemUiModel copyWith({
    String? first_name,
    String? last_name,
    String? email,
    String? slug,
    String? bio,
    String? description,
    String? image,
    final String? joindata,
    List<InstructorLinkUiModel>? links,
    VoidCallback? onActionPressed,
    VoidCallback? onOptionsPressed,
    IconData? actionIconpressed,
    IconData? optionsIconpressed,
  }) {
    return InstructoritemUiModel(
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      slug: slug ?? this.slug,
      bio: bio ?? this.bio,
      description: description ?? this.description,
      image: image ?? this.image,
      links: links ?? this.links,
      joindata: joindata ?? this.joindata,
      onActionPressed: onActionPressed ?? this.onActionPressed,
      onOptionsPressed: onOptionsPressed ?? this.onOptionsPressed,
      actionIconpressed: actionIconpressed ?? this.actionIconpressed,
      optionsIconpressed: optionsIconpressed ?? this.optionsIconpressed,
    );
  }

  @override
  String? get avatarUrl => image;

  @override
  VoidCallback? get onAction => onActionPressed;

  @override
  VoidCallback? get onOptions => onOptionsPressed;

  /// Columns: instructor_name | bio | join_date (N/A from API) | email
  @override
  List<String> get rowTexts => [
    '$first_name $last_name',
    bio ?? ' ',
    joindata ?? ' ',
    email,
  ];

  @override
  VoidCallback? get onRowTap => onOptionsPressed;

  @override
  IconData? get actionIcon => actionIconpressed;

  @override
  IconData? get optionsIcon => optionsIconpressed;
}
