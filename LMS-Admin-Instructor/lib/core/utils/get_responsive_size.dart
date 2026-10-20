import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_breakpoints.dart';

double getResponsiveSize({
  required BuildContext context,
  required double mobileSize,
  double? tabletSize,
  required double webSize,
}) {
  final width = MediaQuery.of(context).size.width;

  if (width >= AppBreakpoints.tablet) {
    return webSize.sp;
  } else if (width >= AppBreakpoints.mobile) {
    return (tabletSize ?? ((mobileSize + webSize) / 2)).sp;
  } else {
    return mobileSize.sp;
  }
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isMobile => screenWidth < AppBreakpoints.mobile;
  bool get isTablet =>
      screenWidth >= AppBreakpoints.mobile && screenWidth < AppBreakpoints.tablet;
  bool get isDesktop => screenWidth >= AppBreakpoints.tablet;

  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop) return desktop;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }
}
