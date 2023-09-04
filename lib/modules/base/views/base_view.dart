import 'package:converter/config/theme/light_theme_colors.dart';
import 'package:converter/modules/converter/views/converter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../config/translations/strings_enum.dart';
import '../../home/views/home_view.dart';
import '../../recent/views/recent_view.dart';
import '../../scanner/views/scanner_view.dart';
import '../../settings/views/settings_view.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  int currentIndex = 2;
  changeScreen(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
  }
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: currentIndex,
          children:   [
            ConverterView(),
            ScannerView(),
            HomeView(),
            RecentView(),
            SettingsView(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Get.theme.iconTheme.color,
        selectedItemColor: LightThemeColors.selectedIconColor,
        unselectedFontSize: 12,
        selectedFontSize: 14,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        items: [
          _mBottomNavItem(
            height: 21,
            width: 25,
            label: Strings.converter.tr,
            icon: Constants.converterIcon,
          ),
          _mBottomNavItem(
            label: Strings.scanner.tr,
            icon: Constants.scannerIcon,
          ),
          _mBottomNavItem(
            label: Strings.home.tr,
            icon: Constants.homeNewIcon,
          ),
          _mBottomNavItem(
            label: Strings.recents.tr,
            icon: Constants.recentIcon,
          ),
          _mBottomNavItem(
            label: Strings.settings.tr,
            icon: Constants.settingsIcon,
          ),
        ],
        onTap: changeScreen,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 0.0,
      //   backgroundColor: Colors.transparent,
      //   onPressed:() => Get.toNamed(Routes.CART),
      //   child: GetBuilder<BaseController>(
      //     id: 'CartBadge',
      //     builder: (_) => badges.Badge(
      //       position: BadgePosition.bottomEnd(bottom: -16, end: 13),
      //       badgeContent: Text(
      //         controller.cartItemsCount.toString(),
      //         style: theme.textTheme.bodyText2?.copyWith(
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       badgeStyle: BadgeStyle(
      //         elevation: 2,
      //         badgeColor: theme.accentColor,
      //         borderSide: const BorderSide(color: Colors.white, width: 1),
      //       ),
      //       child: CircleAvatar(
      //         radius: 22.r,
      //         backgroundColor: theme.primaryColor,
      //         child: SvgPicture.asset(
      //           Constants.cartIcon, fit: BoxFit.none,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  _mBottomNavItem({required String label, required String icon,double height= 20,double width = 20}) {
    Color? textColor = currentIndex == currentIndex ? LightThemeColors.selectedIconColor : Get.theme.iconTheme.color;
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(icon, color: Get.theme.iconTheme.color,height: height,width: width,),
      activeIcon: SvgPicture.asset(icon, color: LightThemeColors.selectedIconColor,height: 25,width: 25,),
    );
  }

}

