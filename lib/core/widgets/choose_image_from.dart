import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/core/widgets/primary_icon_button.dart';

class ChooseImageFrom extends StatelessWidget {
  const ChooseImageFrom({
    super.key,
    required this.onTap,
  });

  final void Function(ImageSource? imageSource) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryIconButton(
              padding: EdgeInsets.all(10.w),
              child: Icon(
                Icons.image_outlined,
                size: 35.w,
                color: const Color(0xFF2a8478),
              ),
              onTap: () => onTap(ImageSource.gallery),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Gallery',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color(0xFF2a8478),
                  ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryIconButton(
              padding: EdgeInsets.all(10.w),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 35.w,
                color: const Color(0xFF2a8478),
              ),
              onTap: () => onTap(ImageSource.camera),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Camera',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color(0xFF2a8478),
                  ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryIconButton(
              padding: EdgeInsets.all(10.w),
              onTap: () => onTap(null),
              child: Icon(
                Icons.attachment_outlined,
                size: 35.w,
                color: const Color(0xFF2a8478),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Files',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color(0xFF2a8478),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
