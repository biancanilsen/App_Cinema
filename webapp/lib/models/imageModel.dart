import 'dart:convert';

class ImageModel {
  final String? originalname;
  final String? filename;

  const ImageModel({
    this.originalname,
    this.filename,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      originalname: json['originalname'],
      filename: json['filename'],
    );
  }
}
