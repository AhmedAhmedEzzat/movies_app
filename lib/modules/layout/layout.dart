import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/constants.dart';
import '../../core/theme/color_pallete.dart';

class Layout extends StatefulWidget {
  static const String routeName = '/layout';

  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Constants.screens[selectedIndex],

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            color: ColorPallete.navBarColor,
            borderRadius: BorderRadius.circular(22),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.homeIcon, height: 22),
                  activeIcon: Image.asset(AppAssets.homeIcon, height: 22,
                      color: ColorPallete.primaryColor),
                  label: '', // 👈 لازم حتى لو فاضي
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.searchIcon, height: 22),
                  activeIcon: Image.asset(AppAssets.searchIcon, height: 22,
                      color: ColorPallete.primaryColor),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.browseIcon, height: 22),
                  activeIcon: Image.asset(AppAssets.browseIcon, height: 22,
                      color: ColorPallete.primaryColor),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.profileIcon, height: 22),
                  activeIcon: Image.asset(AppAssets.profileIcon, height: 22,
                      color: ColorPallete.primaryColor),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
