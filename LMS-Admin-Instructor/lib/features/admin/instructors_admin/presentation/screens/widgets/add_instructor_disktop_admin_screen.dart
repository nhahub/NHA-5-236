import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class AddInstructorDisktopAdminScreen extends StatefulWidget {
  const AddInstructorDisktopAdminScreen({super.key});

  @override
  State<AddInstructorDisktopAdminScreen> createState() =>
      _AddInstructorDisktopAdminScreenState();
}

class _AddInstructorDisktopAdminScreenState
    extends State<AddInstructorDisktopAdminScreen> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InstructorAdminBloc, InstructorAdminState>(
      listener: (context, state) {
        if (state is AddInstructorSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr('instructor_added_successfully')),
              backgroundColor: context.colorScheme.secondary,
            ),
          );
          context.pop();
          context.read<InstructorAdminBloc>().add(GetInstructorAdminEvent());
        } else if (state is AddInstructorError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
        child: SingleChildScrollView(
          child: Container(
            width: 900.w,
            padding: EdgeInsets.all(32.r),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //**************************************??TEXT HEADER??********************************************??
                Text(
                  context.tr('add_new_instructor_title'),
                  style: context.textTheme.displayLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  context.tr('add_instructor_screen_desc'),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 32.h),
                //**************************************??CUSTOM TEXT FORM FILD??********************************************??
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(32.r),
                      width: 770.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        border: Border.all(
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.1,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomTextFormField(
                                h: 50.h,
                                w: 340.w,
                                txt: context.tr('first_name_label'),
                                hint: context.tr('first_name_hint'),
                                controller: firstNameController,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(width: 24.w),
                              CustomTextFormField(
                                h: 50.h,
                                w: 340.w,
                                txt: context.tr('last_name_label'),
                                hint: context.tr('last_name_hint'),
                                controller: lastNameController,
                                textInputAction: TextInputAction.next,
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          BlocBuilder<
                            InstructorAdminBloc,
                            InstructorAdminState
                          >(
                            builder: (context, state) {
                              final isLoading = state is AddInstructorLoading;
                              return CustomTextFormField(
                                h: 60.h,
                                w: 700.w,
                                txt: context.tr('email_address'),
                                hint: context.tr('email_hint'),
                                controller: emailController,
                                prefixIcon: Icons.email_outlined,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (value) {
                                  if (!isLoading &&
                                      firstNameController.text.isNotEmpty &&
                                      lastNameController.text.isNotEmpty &&
                                      emailController.text.isNotEmpty) {
                                    context.read<InstructorAdminBloc>().add(
                                      AddInstructorEvent(
                                        first_name: firstNameController.text,
                                        last_name: lastNameController.text,
                                        email: emailController.text,
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 24.h),
                          Container(
                            padding: EdgeInsets.all(18.r),
                            width: 700.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary.withValues(
                                alpha: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: context.colorScheme.primary,
                                ),
                                SizedBox(width: 18.w),
                                Expanded(
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    context.tr('instructor_invitation_info'),
                                    style: context.textTheme.labelMedium
                                        ?.copyWith(
                                          color: context.colorScheme.onSurface
                                              .withValues(alpha: 0.8),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    //**************************************??BUTTONS??********************************************??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            context.tr('cancel_button'),
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        BlocBuilder<InstructorAdminBloc, InstructorAdminState>(
                          builder: (context, state) {
                            if (state is AddInstructorLoading) {
                              return const SizedBox(
                                width: 171,
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return CustomPrimaryButton(
                              suffixIcon: Icon(
                                size: 15.sp,
                                Icons.person_add_alt_1_outlined,
                                color: context.colorScheme.surface,
                              ),
                              textStyle: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.surface,
                              ),
                              text: context.tr('add_instructor'),
                              onTap: () {
                                if (firstNameController.text.isNotEmpty &&
                                    lastNameController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty) {
                                  context.read<InstructorAdminBloc>().add(
                                    AddInstructorEvent(
                                      first_name: firstNameController.text,
                                      last_name: lastNameController.text,
                                      email: emailController.text,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        context.tr('please_fill_all_fields'),
                                      ),
                                      backgroundColor:
                                          context.colorScheme.error,
                                    ),
                                  );
                                }
                              },
                              width: 120.w,
                              height: 50.h,
                            );
                          },
                        ),
                      ],
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
}
