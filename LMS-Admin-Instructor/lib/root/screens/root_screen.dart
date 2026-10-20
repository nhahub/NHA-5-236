import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/root/bloc/root_bloc.dart';
import 'package:lms_admin_instructor/root/models/nav_items.dart';
import 'package:lms_admin_instructor/root/screens/widgets/admin_bottom_bar.dart';
import 'package:lms_admin_instructor/root/screens/widgets/admin_sidebar.dart';

class RootScreen extends StatefulWidget {
  final List<NavItemModel> navItems;
  final bool isAdmin;
  const RootScreen({super.key, required this.navItems, required this.isAdmin});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final currentState = context.read<RootBloc>().state;
    int initialPage = 0;
    if (currentState is ChangeIndexRootState) {
      initialPage = currentState.index;
    }
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavigationChanged(int index) {
    context.read<RootBloc>().add(ChangeIndexRootEvent(index: index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RootBloc, RootState>(
      listener: (context, state) {
        if (state is ChangeIndexRootState) {
          if (_pageController.hasClients &&
              _pageController.page?.round() != state.index) {
            _pageController.animateToPage(
              state.index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
            );
          }
        }
      },
      child: BlocBuilder<RootBloc, RootState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is ChangeIndexRootState) {
            currentIndex = state.index;
          }

          final bool isDesktop = context.isDesktop;

          return Scaffold(
            body: Row(
              children: [
                if (isDesktop)
                  AdminSidebar(
                    navItems: widget.navItems,
                    selectedIndex: currentIndex,
                    isAdmin: widget.isAdmin,
                    onItemTap: _onNavigationChanged,
                  ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: widget.navItems
                        .map((item) => item.screen)
                        .toList(),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: isDesktop
                ? null
                : AdminBottomBar(
                    navItems: widget.navItems,
                    currentIndex: currentIndex,
                    onTap: _onNavigationChanged,
                  ),
          );
        },
      ),
    );
  }
}
