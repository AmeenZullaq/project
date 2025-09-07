import 'package:flutter/material.dart';

class CustomAnimatedBuilder extends StatefulWidget {
  const CustomAnimatedBuilder({super.key});

  @override
  State<CustomAnimatedBuilder> createState() => _CustomAnimatedBuilderState();
}

class _CustomAnimatedBuilderState extends State<CustomAnimatedBuilder>
    with TickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animation,
              child: const Column(
                children: [
                  Text(
                    'Animated',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Builder',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Widget',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              builder: (context, child) {
                return Container(
                  height: 250,
                  width: 250,
                  color: animation.value,
                  child: child,
                );
              },
            ),
            const SizedBox(
              height: 100,
            ),
            Wrap(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    controller.forward();
                  },
                  child: const Text('forward'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    controller.reverse();
                  },
                  child: const Text('reverse'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    controller.stop();
                  },
                  child: const Text('stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
