import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/bloc/packages_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/bloc/packages_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/bloc/packages_instructor_state.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/presentation/screens/widgets/add_package_dialog.dart';
import 'package:lms_admin_instructor/features/widgets/custom_card_status_info/custom_card_status_info_desktop.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_nav_bar.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custom_delete_dialog.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/widgets/snack_bar_widget.dart';

class PackagesInstructorDesktopScreen extends StatefulWidget {
  const PackagesInstructorDesktopScreen({super.key});

  @override
  State<PackagesInstructorDesktopScreen> createState() =>
      _PackagesInstructorDesktopScreenState();
}

class _PackagesInstructorDesktopScreenState
    extends State<PackagesInstructorDesktopScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final instructorSlug =
        sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
    context.read<PackagesInstructorBloc>().add(
      GetInstructorPackagesEvent(instructorSlug: instructorSlug, page: 1),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      final state = context.read<PackagesInstructorBloc>().state;
      if (state is PackagesListLoaded && !state.isPaginationLoading) {
        if (state.packagesListUIModel.currentPage <
            state.packagesListUIModel.totalPages) {
          final instructorSlug =
              sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
          context.read<PackagesInstructorBloc>().add(
            GetInstructorPackagesEvent(
              instructorSlug: instructorSlug,
              page: state.packagesListUIModel.currentPage + 1,
              search: _searchQuery,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final instructorSlug =
          sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
      context.read<PackagesInstructorBloc>().add(
        GetInstructorPackagesEvent(
          instructorSlug: instructorSlug,
          page: 1,
          search: query,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary.withValues(alpha: 0.005),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomNavBar(
          hint: context.tr('search_packages_hint'),
          controller: _searchController,
          onSearch: (value) {
            _onSearchChanged(value);
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        toolbarHeight: 70.h,
      ),
      body: BlocListener<PackagesInstructorBloc, PackagesInstructorState>(
        listener: (context, state) {
          if (state is CreatePackageSuccess) {
            final instructorSlug =
                sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
            context.read<PackagesInstructorBloc>().add(
              GetInstructorPackagesEvent(
                instructorSlug: instructorSlug,
                page: 1,
              ),
            );
          } else if (state is DeletePackageSuccess) {
            showCustomSnackBar(
              context,
              message: state.message,
              backgroundColor: context.colorScheme.secondary,
              icon: Icons.check_circle,
            );
          } else if (state is DeletePackageError) {
            showCustomSnackBar(
              context,
              message: state.message,
              backgroundColor: context.colorScheme.error,
              icon: Icons.error,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(40.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('all_packages'),
                          style: context.textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          context.tr("packages_screen_subtitle"),
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: context.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomPrimaryButton(
                    onTap: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (dialogContext) => BlocProvider.value(
                          value: context.read<PackagesInstructorBloc>(),
                          child: const AddPackageDialog(),
                        ),
                      );

                      if (result == true && context.mounted) {
                        final instructorSlug =
                            sl<CacheHelper>().getDataString(key: ApiKey.slug) ??
                            '';
                        context.read<PackagesInstructorBloc>().add(
                          GetInstructorPackagesEvent(
                            instructorSlug: instructorSlug,
                            page: 1,
                          ),
                        );
                      }
                    },
                    prefixIcon: const Icon(Icons.add),
                    text: context.tr('create_new_package'),
                    width: getResponsiveSize(
                      mobileSize: 100,
                      webSize: 250,
                      tabletSize: 180,
                      context: context,
                    ),
                    height: 56.h,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: context.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              BlocBuilder<PackagesInstructorBloc, PackagesInstructorState>(
                buildWhen: (previous, current) => current is PackagesListLoaded,
                builder: (context, state) {
                  return Row(
                    children: [
                      CustomCardStatusInfoDesktop(
                        title: context.tr('total_packages'),
                        value: state is PackagesListLoaded
                            ? state.packagesListUIModel.totalPackages.toString()
                            : '??',
                        icon: Icons.inventory_2_outlined,
                        color: context.colorScheme.primary,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 32.h),
              Expanded(
                child:
                    BlocBuilder<
                      PackagesInstructorBloc,
                      PackagesInstructorState
                    >(
                      buildWhen: (previous, current) =>
                          current is PackagesListLoaded ||
                          current is PackagesListLoading ||
                          current is PackagesListError,
                      builder: (context, state) {
                        if (state is PackagesListLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is PackagesListError) {
                          return Center(child: Text(state.message));
                        } else if (state is PackagesListLoaded) {
                          final filteredPackages = _searchQuery.isEmpty
                              ? state.packagesListUIModel.packages
                              : state.packagesListUIModel.packages
                                    .where(
                                      (package) => package.title
                                          .toLowerCase()
                                          .contains(_searchQuery.toLowerCase()),
                                    )
                                    .toList();

                          return CustomDataTable(
                            headers: [
                              context.tr('package_name'),
                              context.tr('price'),
                              context.tr('courses_count'),
                              context.tr('rating'),
                              context.tr('created_date'),
                            ],
                            columnFlex: const [4, 2, 2, 2, 2],
                            centeredColumns: const [1, 2, 3],
                            data: filteredPackages.map((package) {
                              return package.copyWith(
                                actionIconpressed:
                                    Icons.arrow_forward_ios_rounded,
                                onActionPressed: () {
                                  context.pushNamed(
                                    AppRoutes.packageDetails,
                                    pathParameters: {'slug': package.slug},
                                  );
                                },
                                optionsIconpressed:
                                    Icons.delete_outline_rounded,
                                onOptionsPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return CustomDeleteDialog(
                                        title: context.tr(
                                          'delete_package_title',
                                        ),
                                        warningMessage: context.tr(
                                          'delete_package_warning_message',
                                        ),
                                        consequencesMessage: context.tr(
                                          'delete_package_consequences',
                                        ),
                                        onDelete: () {
                                          final instructorSlug =
                                              sl<CacheHelper>().getDataString(
                                                key: ApiKey.slug,
                                              ) ??
                                              '';
                                          context
                                              .read<PackagesInstructorBloc>()
                                              .add(
                                                DeletePackageEvent(
                                                  slug: package.slug,
                                                  instructorSlug:
                                                      instructorSlug,
                                                ),
                                              );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            }).toList(),
                            scrollController: _scrollController,
                            isPaginationLoading: state.isPaginationLoading,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
