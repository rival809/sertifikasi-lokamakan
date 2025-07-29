import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ImageUtils {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
    );
  }

  static void removeImageLocal(String filePath) async {
    try {
      File file = File(filePath);

      if (await file.exists()) {
        await file.delete();
        file.deleteSync();
      }
    } catch (e) {
      log('Error while deleting file: $e');
    }
  }

  static Future<String> convertImagePathToBase64(dynamic image) async {
    dynamic imageBytes;

    File imageFile = File(image);
    imageBytes = await imageFile.readAsBytes();

    String base64String = base64Encode(imageBytes);
    return base64String;
  }

  static Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        // print('File exists. Proceeding with deletion...');
        await file.delete();
        // print('File deleted.');
        if (!(await file.exists())) {
          // print('File successfully deleted.');
        } else {
          // print('File deletion failed.');
        }
      } else {
        // print('File does not exist.');
      }
    } catch (e) {
      showInfoDialog('Error while deleting file: $e');
    }
  }
}
