import 'package:flutter/material.dart';

class TextTweenAnimationBuilder extends StatelessWidget {
  const TextTweenAnimationBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 3),
      tween: IntTween(begin: 0, end: 100),
      builder: (context, value, child) {
        return Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
