import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/login_screen/widgets/login_left_side.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Row(
        children: [
          if (context.isDesktop)
            const Expanded(flex: 1, child: LoginLeftSide()),

          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Positioned(
                  top: -100,
                  right: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.primary.withValues(
                        alpha: 0.12,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.12,
                          ),
                          blurRadius: 100,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -150,
                  left: -150,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.primary.withValues(
                        alpha: 0.08,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.08,
                          ),
                          blurRadius: 120,
                          spreadRadius: 60,
                        ),
                      ],
                    ),
                  ),
                ),

                Center(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
