import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/custom_listview.dart';
import 'package:lms_admin_instructor/features/widgets/instructor.dart';

class CustomViewer extends StatefulWidget {
  final int num1;
  final int num2;
  final int num3;
  final List<String> instructorInfo;
  // TODO This will come from the Cubit
  final List<User> userData;
  const CustomViewer({
    super.key,
    this.num1 = 1,
    this.num2 = 5,
    this.num3 = 124,
    required this.instructorInfo,
    required this.userData,
  });

  @override
  State<CustomViewer> createState() => _CustomViewerState();
}

class _CustomViewerState extends State<CustomViewer> {
  late LinkedScrollControllerGroup _controllersGroup;
  late ScrollController _headerController;
  late ScrollController _listController;
  late ScrollController _footerController;

  @override
  void initState() {
    super.initState();
    _controllersGroup = LinkedScrollControllerGroup();
    _headerController = _controllersGroup.addAndGet();
    _listController = _controllersGroup.addAndGet();
    _footerController = _controllersGroup.addAndGet();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _listController.dispose();
    _footerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Container(
          width: getResponsiveSize(
            context: context,
            webSize: 1104,
            mobileSize: 650,
          ),
          height: getResponsiveSize(
            context: context,
            webSize: 949,
            mobileSize: 550,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(width: 1, color: const Color(0xff94A3B8)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              SingleChildScrollView(
                controller: _headerController,
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: getResponsiveSize(
                    context: context,
                    webSize: 1104,
                    mobileSize: 650,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.r,
                    horizontal: 20.r,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1DDE1).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: List.generate(
                      widget.instructorInfo.length,
                      (index) => Expanded(
                        child: Center(
                          child: Text(
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.8,
                              ),
                              fontWeight: FontWeight.w600,
                            ),
                            widget.instructorInfo[index],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CustomListView(
                  controller: _listController,
                  userData: widget.userData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
