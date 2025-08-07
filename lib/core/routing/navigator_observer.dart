import 'package:flutter/material.dart';


/// this is used with built in navigation.
class NavObserver extends NavigatorObserver {
  List<String> pages = [];
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      pages.add(route.settings.name!);
    }
    super.didPush(route, previousRoute);
    debugPrint(
      '🟢 didPush: ${route.settings.name}, from: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route.settings.name != null && pages.isNotEmpty) {
      pages.removeLast();
    }
    super.didPop(route, previousRoute);
    debugPrint(
      '🔙 didPop: ${route.settings.name}, back to: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (route.settings.name != null && pages.isNotEmpty) {
      pages.removeLast();
    }
    super.didRemove(route, previousRoute);
    debugPrint(
      '❌ didRemove: ${route.settings.name}, from: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (oldRoute != null && pages.isNotEmpty) {
      pages.remove(oldRoute.settings.name);
    }
    if (newRoute != null && pages.isNotEmpty) {
      pages.add(newRoute.settings.name!);
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint(
      '🔁 didReplace: ${oldRoute?.settings.name} ➡️ ${newRoute?.settings.name}',
    );
  }
}
