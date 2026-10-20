import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';
import 'package:lms_admin_instructor/features/widgets/instructor.dart';

// ignore: must_be_immutable
class CustomListView extends StatelessWidget {
  final ScrollController controller;
  final List<User> userData;
  const CustomListView({super.key, required this.controller, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: getResponsiveSize(
            context: context,
            webSize: 1104,
            mobileSize: 650,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: userData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: CustomImage(
                              imagePath:
                                  "https://i.pinimg.com/474x/be/24/f1/be24f1ad82c82e78997c80ff0f8d6a53.jpg",
                              width: 45,
                              height: 45,
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                          ),
                          SizedBox(width: 8.w),

                          Expanded(
                            child: Text(
                              (userData[index] is Instructor)
                                  ? (userData[index] as Instructor).name
                                  : (userData[index] as Student).name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          (userData[index] is Instructor)
                              ? (userData[index] as Instructor).bio
                              : (userData[index] as Student).bio,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          (userData[index] is Instructor)
                              ? (userData[index] as Instructor).date
                              : (userData[index] as Student).joinDate,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          (userData[index] is Instructor)
                              ? (userData[index] as Instructor).email
                              : (userData[index] as Student).email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (userData[index] is Instructor) {
                              (userData[index] as Instructor).action!();
                            } else {
                              (userData[index] as Student).action!();
                            }
                          },
                          child: const Icon(Icons.reply),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
