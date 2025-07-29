import 'package:core/utils/read_file_bytes/read_file_bytes.dart';
import 'package:flutter/services.dart';

Future<Uint8List> getImageFromAsset(String iconPath) async {
  return await readFileBytes(iconPath);
}
