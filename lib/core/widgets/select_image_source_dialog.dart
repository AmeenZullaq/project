import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/core/helpers/pickers.dart';
import 'package:project/core/widgets/choose_image_from.dart';

class SelectImageSourceDialog extends StatefulWidget {
  const SelectImageSourceDialog({
    super.key,
    required this.onImagePicked,
  });

  final void Function(File? file)? onImagePicked;

  @override
  State<SelectImageSourceDialog> createState() =>
      _SelectImageSourceDialogState();
}

class _SelectImageSourceDialogState extends State<SelectImageSourceDialog> {
  File? fileImage;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chose image from',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 30.h,
            ),
            ChooseImageFrom(
              onTap: (imageSource) async {
                if (imageSource == ImageSource.gallery) {
                  fileImage = await Pickers.pickImage(
                    ImageSource.gallery,
                  );
                  widget.onImagePicked?.call(fileImage);
                } else if (imageSource == ImageSource.camera) {
                  fileImage = await Pickers.pickImage(
                    ImageSource.camera,
                  );
                  widget.onImagePicked?.call(fileImage);
                } else {
                  fileImage = await Pickers.pickFile();
                }
              },
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
