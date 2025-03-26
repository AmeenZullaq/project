import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController controller;

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        controller: controller,
        isVisible: true,
        screens: const [
  
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(
              Icons.home,
            ),
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(
              Icons.search,
            ),
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(
              Icons.settings,
            ),
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}

