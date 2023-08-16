import 'package:flutter/material.dart';
import 'package:scanconvertapp/screens/converter_screen/converter_screen.dart';
import 'package:scanconvertapp/screens/recents_screen/recents_screen.dart';
import 'package:scanconvertapp/screens/scanner_screen/scanner_screen.dart';
import 'package:scanconvertapp/screens/settings_screen/settings_screen.dart';

import '../../constants/colors.dart';
import '../home_screen/home_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    ConverterScreen(),
    ScannerScreen(),
    HomeScreen(),
    RecentsScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("assets/images/converter.png"),height: 25,width: 25,),
            label: 'Converter',
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("assets/images/scanner.png"),height: 25,width: 25,),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("assets/images/home.png"),height: 25,width: 25,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("assets/images/recent.png"),height: 25,width: 25,),
            label: 'Recent',
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("assets/images/settings.png"),height: 25,width: 25,),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
