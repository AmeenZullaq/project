import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SymetricPadding extends StatelessWidget {
  const SymetricPadding({
    super.key,
    this.horizontal = 0.0,
    this.vertical = 0.0,
    this.child,
  });
  final double horizontal;
  final double vertical;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal.w,
        vertical: vertical.h,
      ),
      child: child,
    );
  }
}

class AllPadding extends StatelessWidget {
  const AllPadding({
    super.key,
    required this.value,
    this.child,
  });
  final double value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(value.w),
      child: child,
    );
  }
}

class DynamicPadding extends StatelessWidget {
  const DynamicPadding({
    super.key,
    this.top = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
    this.child,
  });
  final double top;
  final double bottom;
  final double left;
  final double right;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top.h,
        bottom: bottom.h,
        left: left.w,
        right: right.w,
      ),
      child: child,
    );
  }
}

class StartPadding extends StatelessWidget {
  const StartPadding({
    super.key,
    this.start = 0.0,
    this.child,
  });

  final Widget? child;
  final double start;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: start.w),
      child: child,
    );
  }
}

class EndPadding extends StatelessWidget {
  final Widget? child;
  final double end;
  const EndPadding({
    super.key,
    this.child,
    this.end = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: end.w),
      child: child,
    );
  }
}

class TopPadding extends StatelessWidget {
  final Widget? child;
  final double top;
  const TopPadding({
    super.key,
    this.child,
    this.top = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: top.h),
      child: child,
    );
  }
}

class BottomPadding extends StatelessWidget {
  final Widget? child;
  final double bottom;
  const BottomPadding({
    super.key,
    this.child,
    this.bottom = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: bottom.h),
      child: child,
    );
  }
}
