import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_state.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class AddInstructorMobileAdminScreen extends StatefulWidget {
  const AddInstructorMobileAdminScreen({super.key});

  @override
  State<AddInstructorMobileAdminScreen> createState() =>
      _AddInstructorMobileAdminScreenState();
}

class _AddInstructorMobileAdminScreenState
    extends State<AddInstructorMobileAdminScreen> {
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
              backgroundColor: Colors.green,
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
      child: Scaffold(
        //**************************************??APP BAR??********************************************??
        appBar: AppBar(
          title: Text(
            context.tr('add_instructors_title_mobile'),
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: InkWell(
                onTap: () {},
                child: CustomImage(
                  aspectRatio: 1,
                  imagePath:
                      "https://i.pinimg.com/474x/be/24/f1/be24f1ad82c82e78997c80ff0f8d6a53.jpg",
                  width: 45,
                  height: 45,
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.all(24.r),
          child: Column(
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
              SizedBox(height: 24.h),

              //**************************************??Discreption??********************************************??
              Container(
                padding: EdgeInsets.all(16.r),
                width: 335.w,
                height: 110.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.2),
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
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        context.tr('instructor_invitation_info'),
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              //**************************************??CUSTOM TEXT FORM FILD??********************************************??
              CustomTextFormField(
                h: 50.h,
                w: 340.w,
                txt: context.tr('first_name_label'),
                hint: context.tr('first_name_hint'),
                controller: firstNameController,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                h: 50.h,
                w: 340.w,
                txt: context.tr('last_name_label'),
                hint: context.tr('last_name_hint'),
                controller: lastNameController,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                h: 50.h,
                w: 340.w,
                txt: context.tr('email_address'),
                hint: context.tr('email_hint'),
                controller: emailController,
              ),
              SizedBox(height: 32.h),
              //**************************************??BUTTONS??********************************************??
              BlocBuilder<InstructorAdminBloc, InstructorAdminState>(
                builder: (context, state) {
                  if (state is AddInstructorLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomPrimaryButton(
                    prefixIcon: Icon(
                      size: 20.sp,
                      Icons.person_add_alt_1_outlined,
                      color: context.colorScheme.surface,
                    ),
                    textStyle: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.surface,
                    ),
                    text: context.tr('save_instructor'),
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
                            content: Text(context.tr('please_fill_all_fields')),
                            backgroundColor: context.colorScheme.error,
                          ),
                        );
                      }
                    },
                    width: 342.w,
                    height: 64.h,
                  );
                },
              ),
              SizedBox(height: 16.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    context.tr('cancel_and_return'),
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
