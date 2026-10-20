import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';

class CustomDataTable extends StatefulWidget {
  final List<String> headers;
  final List<CustomDataTableRowModel> data;
  final bool isLoading;
  final bool isPaginationLoading;
  final ScrollController? scrollController;
  final bool showIndex;
  final List<int>? columnFlex;
  final List<int>? centeredColumns;

  const CustomDataTable({
    super.key,
    required this.headers,
    required this.data,
    this.isLoading = false,
    this.isPaginationLoading = false,
    this.scrollController,
    this.showIndex = true,
    this.columnFlex,
    this.centeredColumns,
  });

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading && widget.data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double minWidth = context.responsiveValue(
          mobile: 650.w,
          desktop: 1100.w,
        );
        final double horizontalPadding = context.responsiveValue(
          mobile: 8.w,
          desktop: 12.w,
        );
        final double tableWidth = constraints.maxWidth > minWidth
            ? constraints.maxWidth
            : minWidth;

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: Scrollbar(
            controller: _horizontalScrollController,
            thumbVisibility: true,
            trackVisibility: true,
            thickness: 8.r,
            radius: Radius.circular(8.r),
            child: SingleChildScrollView(
              controller: _horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: tableWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: horizontalPadding,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.outline.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.r),
                          topRight: Radius.circular(8.r),
                        ),
                      ),
                      child: DefaultTextStyle(
                        style: context.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                        child: Row(
                          children: [
                            if (widget.showIndex)
                              _buildHeaderCell(
                                context.tr('number'),
                                flex: 1,
                                horizontalPadding: horizontalPadding,
                              ),
                            ...List.generate(widget.headers.length, (index) {
                              final isCentered =
                                  widget.centeredColumns?.contains(index) ??
                                  false;
                              final headerText = index < widget.headers.length
                                  ? widget.headers[index]
                                  : '';
                              return _buildHeaderCell(
                                headerText,
                                flex:
                                    widget.columnFlex != null &&
                                        widget.columnFlex!.length > index
                                    ? widget.columnFlex![index]
                                    : 2,
                                horizontalPadding: horizontalPadding,
                                isCentered: isCentered,
                              );
                            }),
                            SizedBox(width: 100.w),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: widget.scrollController,
                        itemCount:
                            widget.data.length +
                            (widget.isPaginationLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == widget.data.length) {
                            return Padding(
                              padding: EdgeInsets.all(16.r),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final item = widget.data[index];
                          final isEven = index % 2 == 0;

                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: item.onRowTap ?? item.onAction,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: horizontalPadding,
                                ),
                                decoration: BoxDecoration(
                                  color: isEven
                                      ? context.colorScheme.surface
                                      : context
                                            .colorScheme
                                            .surfaceContainerHighest
                                            .withValues(alpha: 0.5),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: context.colorScheme.outline
                                          .withValues(alpha: 0.1),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    if (widget.showIndex)
                                      _buildDataCell(
                                        "${index + 1}",
                                        flex: 1,
                                        horizontalPadding: horizontalPadding,
                                      ),
                                    ...List.generate(item.rowTexts.length, (
                                      rowIndex,
                                    ) {
                                      final isCentered =
                                          widget.centeredColumns?.contains(
                                            rowIndex,
                                          ) ??
                                          false;
                                      final rowText =
                                          rowIndex < item.rowTexts.length
                                          ? item.rowTexts[rowIndex]
                                          : '';
                                      return _buildDataCell(
                                        rowText,
                                        flex:
                                            widget.columnFlex != null &&
                                                widget.columnFlex!.length >
                                                    rowIndex
                                            ? widget.columnFlex![rowIndex]
                                            : 2,
                                        horizontalPadding: horizontalPadding,
                                        isCentered: isCentered,
                                      );
                                    }),
                                    SizedBox(
                                      width: 100.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (item.onOptions != null) ...[
                                            IconButton(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              padding: EdgeInsets.zero,
                                              icon: Icon(
                                                item.optionsIcon ??
                                                    Icons.more_horiz,
                                              ),
                                              onPressed: item.onOptions,
                                              splashRadius: 20.r,
                                            ),
                                            SizedBox(width: 8.w),
                                          ],
                                          if (item.onAction != null)
                                            item.actionIcon != null
                                                ? IconButton(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    padding: EdgeInsets.zero,
                                                    icon: Icon(
                                                      item.actionIcon,
                                                      color: context
                                                          .colorScheme
                                                          .primary,
                                                      size: 24.r,
                                                    ),
                                                    onPressed: item.onAction,
                                                    splashRadius: 20.r,
                                                  )
                                                : IconButton(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    padding: EdgeInsets.zero,
                                                    icon: Icon(
                                                      Icons.delete_outline,
                                                      color: context
                                                          .colorScheme
                                                          .error,
                                                      size: 24.r,
                                                    ),
                                                    onPressed: item.onAction,
                                                    splashRadius: 20.r,
                                                  ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCell(
    String? text, {
    int flex = 2,
    double horizontalPadding = 12,
    bool isCentered = false,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        alignment: isCentered
            ? Alignment.center
            : (flex == 1 ? Alignment.center : AlignmentDirectional.centerStart),
        child: Text(
          text ?? '',
          textAlign: isCentered
              ? TextAlign.center
              : (flex == 1 ? TextAlign.center : TextAlign.start),
          style: const TextStyle(inherit: true),
        ),
      ),
    );
  }

  Widget _buildDataCell(
    String? text, {
    int flex = 2,
    double horizontalPadding = 12,
    bool isCentered = false,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        alignment: isCentered
            ? Alignment.center
            : (flex == 1 ? Alignment.center : AlignmentDirectional.centerStart),
        child: Text(
          text ?? '',
          textAlign: isCentered
              ? TextAlign.center
              : (flex == 1 ? TextAlign.center : TextAlign.start),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
