import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> compressImage(Uint8List imageBytes) async {
  try {
    return await FlutterImageCompress.compressWithList(
      imageBytes,
      minWidth: 1080,
      minHeight: 720,
      quality: 70,
    );
  } catch (e) {
    debugPrint('❌ Error compressing image: $e');
    return imageBytes;
  }
}
