import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCircleIndicator extends StatelessWidget {
  const CustomCircleIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitCircle(
        size: 100,
        color: Color(0xFFACE1AF),
      ),
    );
  }
}
