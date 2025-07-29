import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<String?> convertImageToBase64WithSizeLimit(
  XFile image, {
  required int maxSizeKB, // Maksimal ukuran file dalam KB
}) async {
  try {
    File imageFile = File(image.path);
    int fileSizeInKB = imageFile.lengthSync() ~/ 1024; // Cek ukuran awal

    if (fileSizeInKB <= maxSizeKB) {
      // Jika sudah sesuai, langsung encode ke Base64
      List<int> imageBytes = await imageFile.readAsBytes();
      return base64Encode(imageBytes);
    }

    int quality = 90; // Mulai dengan kualitas 90%
    File? compressedFile = imageFile;

    // Loop untuk kompres bertahap 10% hingga sesuai
    while (fileSizeInKB > maxSizeKB && quality > 10) {
      XFile? tempCompressed = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        "${imageFile.path}_compressed.jpg",
        quality: quality,
      );

      if (tempCompressed == null) break; // Jika gagal kompres, keluar dari loop

      compressedFile = File(tempCompressed.path);
      fileSizeInKB = compressedFile.lengthSync() ~/ 1024; // Cek ulang ukuran
      quality -= 10; // Kurangi kualitas 10% tiap iterasi
    }

    // Jika setelah kompres masih lebih besar dari batas, kembalikan null
    if (fileSizeInKB > maxSizeKB) return null;

    // Konversi ke Base64 setelah berhasil dikompres
    List<int> imageBytes = await compressedFile!.readAsBytes();
    return base64Encode(imageBytes);
  } catch (e) {
    return null; // Kembalikan null jika terjadi error
  }
}

// Fungsi untuk mengonversi base64 kembali ke file
Future<File> convertBase64ToFile(String base64String, String path) async {
  final bytes = base64Decode(base64String);
  final file = File(path);
  await file.writeAsBytes(bytes);
  return file;
}
