import 'package:flutter/material.dart';

/// inherited widget is a way to efficiently pass data down the widget tree.
class ContaienrTheme extends InheritedWidget {
  const ContaienrTheme({super.key, required super.child});

  final Color color = Colors.red;
  final double size = 100;

  static ContaienrTheme of(BuildContext context) {
    /// This line searches up the widget tree from the current BuildContext to find the nearest ancestor widget of type ContaienrTheme 
    /// and registers the context as a dependency of that InheritedWidget.
    return context.dependOnInheritedWidgetOfExactType<ContaienrTheme>()!;
  }

  @override
  bool updateShouldNotify(covariant ContaienrTheme oldWidget) {
    /// it will notify only when the color changes
    /// oldWidget means the widget before the update and newWidget means the widget after the update
    /// when return true it will notify and rebuild the widget and when return false it will not notify and not rebuild
    return oldWidget.color != color || oldWidget.size != size;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ContaienrTheme(
          child: Center(
            child: Builder(builder: (context) {
              return Container(
                height: ContaienrTheme.of(context).size,
                width: ContaienrTheme.of(context).size,
                color: ContaienrTheme.of(context).color,
              );
            }),
          ),
        ),
      ),
    );
  }
}
