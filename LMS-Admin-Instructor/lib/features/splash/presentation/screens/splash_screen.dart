import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/theme/app_assets.dart';
import 'package:lms_admin_instructor/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:lms_admin_instructor/features/splash/presentation/bloc/splash_event.dart';
import 'package:lms_admin_instructor/features/splash/presentation/bloc/splash_state.dart';
import 'package:lms_admin_instructor/features/splash/presentation/screens/widgets/custom_error_popup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SplashBloc>().add(SplashStarted());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded || state is SplashError) {
          final timeSinceStart = DateTime.now()
              .difference(_startTime)
              .inMilliseconds;
          final remainingDelay = (4000 - timeSinceStart).clamp(0, 4000);

          Future.delayed(Duration(milliseconds: remainingDelay), () {
            if (mounted) _handleNavigation(context, state);
          });
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: Stack(
          children: [
            Positioned(
              top: -150,
              right: -100,
              child: Container(
                width: 450,
                height: 450,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      theme.colorScheme.primary.withValues(alpha: 0.18),
                      theme.colorScheme.primary.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: -200,
              left: -150,
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      theme.colorScheme.secondary.withValues(alpha: 0.15),
                      theme.colorScheme.secondary.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface.withValues(
                            alpha: 0.7,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.colorScheme.surface,
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.primary.withValues(
                                alpha: 0.1,
                              ),
                              blurRadius: 40,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 12,
                                  sigmaY: 12,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        context.colorScheme.surface.withValues(
                                          alpha: 0.7,
                                        ),
                                        context.colorScheme.surface.withValues(
                                          alpha: 0.3,
                                        ),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: context.colorScheme.surface,
                                      width: 1.5.r,
                                    ),
                                  ),
                                ),
                              ),
                              // Logo
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(35.r),
                                  child: Image.asset(
                                    AppAssets.appLogo,
                                    width: 100.r,
                                    height: 100.r,
                                    cacheHeight: 300,
                                    cacheWidth: 300,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        context.tr('commit_ma3ana'),
                        style: theme.textTheme.displaySmall!.copyWith(
                          color: context.colorScheme.onSurface,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        context.tr('build_your_future'),
                        style: theme.textTheme.labelMedium!.copyWith(
                          color: context.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.6),
                          letterSpacing: 6.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, SplashState state) {
    if (state is SplashLoaded) {
      context.go(AppRoutes.navBar, extra: {"role": state.role});
    } else if (state is SplashError) {
      if (state.message != null &&
          state.message != "No token found" &&
          state.message != "Session expired" &&
          state.message!.isNotEmpty) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => CustomErrorPopup(
            title: context.tr('error'),
            message: state.message!,
            onRetry: () {
              context.pop();
              context.read<SplashBloc>().add(SplashStarted());
            },
          ),
        );
      } else {
        // String msg = context.tr('authentication_failed');
        // if (state.message == "No token found") {
        //   msg = context.tr('no_token_found');
        // } else if (state.message == "Session expired") {
        //   msg = context.tr('session_expired');
        // } else if (state.isActive == false) {
        //   msg = context.tr('account_inactive');
        // } else if (state.isVerified == false) {
        //   msg = context.tr('account_unverified');
        // }

        // if (msg != context.tr('authentication_failed')) {
        //   ScaffoldMessenger.of(
        //     context,
        //   ).showSnackBar(SnackBar(content: Text(msg)));
        // }
        context.go(AppRoutes.loginScreen);
      }
    }
  }
}
