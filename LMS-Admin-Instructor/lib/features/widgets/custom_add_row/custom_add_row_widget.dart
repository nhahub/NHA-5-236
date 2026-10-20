import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class CustomAddRowWidget extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final IconData icon;
  final VoidCallback onTap;
  const CustomAddRowWidget({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            Text(
              description,
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
        const Spacer(),

        CustomPrimaryButton(
          prefixIcon: const Icon(Icons.add),
          text: buttonText,
          onTap: onTap,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
      ],
    );
  }
}
