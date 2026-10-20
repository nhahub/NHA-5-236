import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/search_bar.dart';

class CustomNavBar extends StatefulWidget {
  final String? hint;
  final bool showSearch;
  final TextEditingController? controller;
  final void Function(String)? onSearch;

  const CustomNavBar({
    super.key,
    this.hint,
    this.showSearch = true,
    this.controller,
    this.onSearch,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.w : 24.w,
          vertical: 13.h,
        ),
        child: Row(
          children: [
            if (widget.showSearch)
              CustomSearchBarr(
                h: 40,
                w: 400,
                hint: widget.hint ?? context.tr('search_instructors_hint'),
                controller: _controller,
                prefixIcon: Icons.search,
                r: 30,
                onChanged: widget.onSearch,
                onFieldSubmitted: widget.onSearch,
              )
            else
              const Spacer(),
          ],
        ),
      ),
    );
  }
}
