import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desctopLayout,
  });

  final WidgetBuilder mobileLayout, tabletLayout, desctopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return mobileLayout(context);
        } else if (constraints.maxWidth < 1200) {
          return tabletLayout(context);
        } else {
          return desctopLayout(context);
        }
      },
    );
  }
}
