import 'package:flutter/material.dart';

abstract class CustomDataTableRowModel {
  List<String> get rowTexts;

  String? get avatarUrl;

  VoidCallback? get onAction;
  IconData? get actionIcon;

  VoidCallback? get onOptions;
  IconData? get optionsIcon;

  VoidCallback? get onRowTap => null;
}
