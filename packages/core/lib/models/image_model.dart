class ImageModel {
  final String file, extensionImage;

  ImageModel({
    required this.file,
    required this.extensionImage,
  });

  Map<String, dynamic> toJson() {
    return {
      "file": file,
      "extension": extensionImage,
    };
  }
}
