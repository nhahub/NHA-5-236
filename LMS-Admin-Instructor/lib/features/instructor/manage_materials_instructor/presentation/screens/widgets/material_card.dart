import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_materials_ui_model.dart';

class MaterialCard extends StatelessWidget {
  final CourseMaterialItemUIModel material;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const MaterialCard({
    super.key,
    required this.material,
    required this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSurface.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            if (material.file != null) {
              context.pushNamed(
                AppRoutes.pdfViewer,
                extra: {'url': material.file, 'title': material.materialName},
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.all(18.r),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.picture_as_pdf,
                    color: context.colorScheme.primary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        material.materialName,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            material.fileSize ?? '0 KB',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (material.createdAt != null) ...[
                            Text(
                              ' • ',
                              style: TextStyle(
                                color: context.colorScheme.outline,
                              ),
                            ),
                            Text(
                              material.createdAt!.split('T')[0],
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildActionButton(
                      context: context,
                      icon: Icons.edit_note_outlined,
                      color: context.colorScheme.onSurfaceVariant,
                      onTap: onEdit ?? () {},
                    ),
                    SizedBox(width: 8.w),
                    _buildActionButton(
                      context: context,
                      icon: Icons.delete_rounded,
                      color: context.colorScheme.error,
                      onTap: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(8.r),
        child: Icon(icon, size: 20.sp, color: color),
      ),
    );
  }
}
