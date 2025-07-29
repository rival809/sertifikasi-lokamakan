import 'package:cloud_firestore/cloud_firestore.dart';

// Restaurant Picture Model untuk menyimpan informasi gambar restoran
class RestaurantPicture {
  final String id; // pictureId yang direferensikan dari RestaurantLocation
  final String restaurantId; // Reference ke restaurant yang memiliki gambar ini
  final String fileName; // Nama file asli
  final String url; // Firebase Storage download URL
  final String? thumbnailUrl; // URL thumbnail untuk performance
  final String? caption; // Caption/deskripsi gambar
  final int? width; // Lebar gambar dalam pixel
  final int? height; // Tinggi gambar dalam pixel
  final int fileSizeBytes; // Ukuran file dalam bytes
  final String mimeType; // Content type (image/jpeg, image/png, etc)
  final DateTime uploadedAt; // Timestamp upload
  final String uploadedBy; // User/admin yang upload
  final bool isActive; // Status aktif/tidak untuk moderation
  final bool isPrimary; // Apakah ini gambar utama restoran
  final List<String>? tags; // Tags untuk kategorisasi gambar

  const RestaurantPicture({
    required this.id,
    required this.restaurantId,
    required this.fileName,
    required this.url,
    this.thumbnailUrl,
    this.caption,
    this.width,
    this.height,
    required this.fileSizeBytes,
    required this.mimeType,
    required this.uploadedAt,
    required this.uploadedBy,
    this.isActive = true,
    this.isPrimary = false,
    this.tags,
  });

  factory RestaurantPicture.fromJson(Map<String, dynamic> json) {
    return RestaurantPicture(
      id: json['id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      fileName: json['fileName'] ?? '',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'],
      caption: json['caption'],
      width: json['width']?.toInt(),
      height: json['height']?.toInt(),
      fileSizeBytes: json['fileSizeBytes']?.toInt() ?? 0,
      mimeType: json['mimeType'] ?? '',
      uploadedAt:
          (json['uploadedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      uploadedBy: json['uploadedBy'] ?? '',
      isActive: json['isActive'] ?? true,
      isPrimary: json['isPrimary'] ?? false,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'fileName': fileName,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'caption': caption,
      'width': width,
      'height': height,
      'fileSizeBytes': fileSizeBytes,
      'mimeType': mimeType,
      'uploadedAt': Timestamp.fromDate(uploadedAt),
      'uploadedBy': uploadedBy,
      'isActive': isActive,
      'isPrimary': isPrimary,
      'tags': tags,
    };
  }

  RestaurantPicture copyWith({
    String? id,
    String? restaurantId,
    String? fileName,
    String? url,
    String? thumbnailUrl,
    String? caption,
    int? width,
    int? height,
    int? fileSizeBytes,
    String? mimeType,
    DateTime? uploadedAt,
    String? uploadedBy,
    bool? isActive,
    bool? isPrimary,
    List<String>? tags,
  }) {
    return RestaurantPicture(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      fileName: fileName ?? this.fileName,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      caption: caption ?? this.caption,
      width: width ?? this.width,
      height: height ?? this.height,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      mimeType: mimeType ?? this.mimeType,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      isActive: isActive ?? this.isActive,
      isPrimary: isPrimary ?? this.isPrimary,
      tags: tags ?? this.tags,
    );
  }

  // Helper untuk mendapatkan file extension
  String get fileExtension {
    return fileName.split('.').last.toLowerCase();
  }

  // Helper untuk format ukuran file yang readable
  String get formattedFileSize {
    if (fileSizeBytes < 1024) {
      return '$fileSizeBytes B';
    } else if (fileSizeBytes < 1024 * 1024) {
      return '${(fileSizeBytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(fileSizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  // Helper untuk aspect ratio
  double? get aspectRatio {
    if (width != null && height != null && height! > 0) {
      return width! / height!;
    }
    return null;
  }

  // Helper untuk check apakah landscape
  bool get isLandscape {
    final ratio = aspectRatio;
    return ratio != null && ratio > 1.0;
  }

  // Helper untuk check apakah portrait
  bool get isPortrait {
    final ratio = aspectRatio;
    return ratio != null && ratio < 1.0;
  }

  // Helper untuk check apakah square
  bool get isSquare {
    final ratio = aspectRatio;
    return ratio != null && (ratio - 1.0).abs() < 0.1;
  }
}
