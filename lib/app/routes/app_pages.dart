import 'package:converter/modules/recent/views/recent_view.dart';
import 'package:converter/modules/scanner/views/scanner_view.dart';
import 'package:flutter/material.dart';
import '../../modules/base/views/base_view.dart';
import '../../modules/converter/views/converter_view.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/settings/views/settings_view.dart';
import '../../modules/splash/views/splash_screen.dart';

part 'app_routes.dart';
class AppPages {
  AppPages._();
  static const String INITIAL = Routes.SPLASH;
  static const String base = _Paths.BASE;
  static const String home = _Paths.HOME;
  static const String converter = _Paths.C0NVERTER;
  static const String scanner = _Paths.SCANNER;
  static const String recent = _Paths.RECENT;
  static const String setting = _Paths.SETTINGS;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case INITIAL:
        return MaterialPageRoute(builder: (_) => SplashView());
        case base:
        return MaterialPageRoute(builder: (_) => BaseView());
      case home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case converter:
        return MaterialPageRoute(builder: (_) => ConverterView());
      case scanner:
        return MaterialPageRoute(builder: (_) => ScannerView());
      case recent:
        return MaterialPageRoute(builder: (_) => RecentView());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingsView());
      default:
        return MaterialPageRoute(builder: (_) => BaseView());
    }
  }
}
// class AppPages {
//   AppPages._();
//
//   static const INITIAL = Routes.SPLASH;
//
//   static final routes = [
//     GetPage(
//       name: _Paths.SPLASH,
//       page: () => const SplashView(),
//     ),
//     GetPage(
//       name: _Paths.BASE,
//       page: () => const BaseView(),
//     ),
//     GetPage(
//       name: _Paths.C0NVERTER,
//       page: () => ConverterView(),
//     ),
//     GetPage(
//       name: _Paths.SCANNER,
//       page: () => ScannerView(),
//     ),
//     GetPage(
//       name: _Paths.HOME,
//       page: () => HomeView(),
//     ),
//     GetPage(
//       name: _Paths.RECENT,
//       page: () => RecentView(),
//     ),
//     GetPage(
//       name: _Paths.SETTINGS,
//       page: () => SettingsView(),
//     ),
//   ];
// }
