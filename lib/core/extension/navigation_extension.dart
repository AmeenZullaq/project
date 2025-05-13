import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void toView(Widget view) => Navigator.of(this).push(
        MaterialPageRoute(
          builder: (context) => view,
        ),
      );
}

/*
example: 

context.toView(const HomeView());
 */
