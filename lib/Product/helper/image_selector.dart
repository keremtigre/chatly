import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageSelector {
  static ImageSelector? _instance;
  final ImagePicker _picker = ImagePicker();

  ImageSelector._();

  static ImageSelector getInstance() {
    _instance ??= ImageSelector._();
    return _instance!;
  }

  Future<File?> pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  Future<File?> captureImageFromCamera() async {
    final capturedImage = await _picker.pickImage(source: ImageSource.camera);
    if (capturedImage != null) {
      return File(capturedImage.path);
    }
    return null;
  }
}
