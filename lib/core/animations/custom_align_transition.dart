import 'package:flutter/material.dart';

class CustomAlignTransition extends StatefulWidget {
  const CustomAlignTransition({super.key});

  @override
  State<CustomAlignTransition> createState() => _CustomAlignTransitionState();
}

class _CustomAlignTransitionState extends State<CustomAlignTransition>
    with TickerProviderStateMixin {
  late Animation<AlignmentGeometry> greenAnimation;
  late Animation<AlignmentGeometry> yellowAnimation;
  late AnimationController greenController;
  late AnimationController yellowController;

  @override
  void initState() {
    super.initState();
    greenController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 3),
    );
    yellowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 3),
    );
    greenAnimation = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(greenController);
    yellowAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: yellowController,
        curve: Curves.easeIn,
        reverseCurve: Curves.bounceIn,
      ),
    );
    // greenAnimation.addStatusListener(
    //   (status) {
    //     if (greenAnimation.status == AnimationStatus.completed) {
    //       yellowController.forward();
    //     }
    //     if (greenAnimation.status == AnimationStatus.dismissed) {
    //       yellowController.reverse();
    //     }
    //   },
    // );
    greenController.addListener(
      () {
        if (greenController.value >= 0.5 && yellowController.value == 0) {
          yellowController.forward();
        }
        if (greenController.value <= 0.5 && yellowController.value == 1) {
          yellowController.reverse();
        }
      },
    );
  }

  @override
  void dispose() {
    greenController.dispose();
    yellowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AlignTransition(
                  alignment: greenAnimation,
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
                AlignTransition(
                  alignment: yellowAnimation,
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  greenController.forward();
                },
                child: const Text('forward'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  greenController.reverse();
                },
                child: const Text('reverse'),
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue,
              //   ),
              //   onPressed: () {
              //     controller.stop();
              //   },
              //   child: const Text('stop'),
              // ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue,
              //   ),
              //   onPressed: () {
              //     controller.reset();
              //   },
              //   child: const Text('reset'),
              // ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue,
              //   ),
              //   onPressed: () {
              //     controller.repeat(reverse: false);
              //   },
              //   child: const Text('repeat(revers=false)'),
              // ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue,
              //   ),
              //   onPressed: () {
              //     controller.repeat(reverse: true);
              //   },
              //   child: const Text('repeat(revers=true)'),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
