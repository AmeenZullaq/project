import 'package:flutter/material.dart';

/// inherited widget is a way to efficiently pass data down the widget tree.
class MyInherited extends InheritedWidget {
  const MyInherited({super.key, required super.child});

  final Color color = Colors.red;

  static MyInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInherited>()!;
  }

  @override
  bool updateShouldNotify(covariant MyInherited oldWidget) {
    /// it will notify only when the color changes
    /// oldWidget means the widget before the update and newWidget means the widget after the update
    /// when return true it will notify and rebuild the widget and when return false it will not notify and not rebuild
    return oldWidget.color != color;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyInherited(
          child: Center(
            child: ColoredBox(),
          ),
        ),
      ),
    );
  }
}

class ColoredBox extends StatelessWidget {
  const ColoredBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// that hard because each time i want to create a copy of ColoredBox i need o defin that is line, so i take it and out in the MyInherited inside of methid
    // MyInherited myInherited =
    //     context.dependOnInheritedWidgetOfExactType<MyInherited>()!;

    return Container(
      height: 200,
      width: 200,
      color: MyInherited.of(context).color,
    );
  }
}
