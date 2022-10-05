import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';

String getBase64Image(File img) {
  String imageExtension = img.path.split('.').last;
  print(imageExtension);
  Uint8List bytes = io.File(img.path).readAsBytesSync();
  String img64 = base64Encode(bytes);
  img64 = "data:image/$imageExtension;base64,$img64";
  return img64;
}
