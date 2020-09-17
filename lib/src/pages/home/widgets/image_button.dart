import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageButton extends StatefulWidget {
  final Function(File imageFile) callBack;

  ImageButton(this.callBack);

  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  File _imageFile;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlineButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => _buildCustomDialog(),
            );
          },
          child: Text("image"),
        ),
        _buildImagePreview(),
      ],
    );
  }

  _buildImagePreview() {
    if (_imageFile != null) {
      return Image.file(_imageFile);
    }
    return SizedBox();
  }

  _buildCustomDialog() {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              child: Text("CAMERA"),
              onPressed: () {
                getImage();
              },
            ),
            SizedBox(height: 6),
            FlatButton(
              child: Text("GALLERY"),
              onPressed: () {
                getImage(imageSource: ImageSource.gallery);
              },
            ),
            SizedBox(height: 18),
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future getImage({ImageSource imageSource = ImageSource.camera}) async {
    final pickedFile = await picker.getImage(source: imageSource);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      _cropImage();
      Navigator.pop(context);
    }
  }

  void _cropImage() {
    ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        statusBarColor: Colors.black,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
      maxWidth: 5500,
      maxHeight: 5500,
      cropStyle: CropStyle.circle,
    ).then((file) {
      if (file != null) {
        setState(() {
          _imageFile = file;
          widget.callBack(_imageFile);
        });
      }
    });
  }
}
