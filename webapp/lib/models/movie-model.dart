import 'dart:convert';

import 'package:flutter_application/models/imageModel.dart';

List<MovieModel> moviesFromJson(String str) =>
    List<MovieModel>.from(json.decode(str).map((x) => MovieModel.fromJson(x)));

String moviesToJson(List<MovieModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovieModel {
  late String? id;
  late String? name;
  late int? classification;
  late int? type;
  late String? duration;
  late int? room;
  late String? path;

  MovieModel({
    this.id,
    this.name,
    this.classification,
    this.type,
    this.duration,
    this.room,
    this.path,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    ImageModel? imageModel;
    id = json["id"];
    name = json["name"];
    classification = json["classification"];
    type = json["type"];
    duration = json["duration"];
    room = json["room"];
    //passar o image model aqui
    // path = json["path"];
    path = json[ImageModel];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["classification"] = classification;
    _data["type"] = type;
    _data["duration"] = duration;
    _data["room"] = room;
    _data["path"] = ImageModel;
    // /ver sobre correlação no flutter

    //aqui retornar o imagemodel from json:
    //return ImageModel(
    //   originalname: json['originalname'],
    //   filename: json['filename'],
    // );

    // _data["path"] = path;

    return _data;
  }
}
