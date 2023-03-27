import 'dart:convert';

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
    id = json["id"];
    name = json["name"];
    classification = json["classification"];
    type = json["type"];
    duration = json["duration"];
    room = json["room"];
    path = json["path"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["classification"] = classification;
    data["type"] = type;
    data["duration"] = duration;
    data["room"] = room;
    data["path"] = path;

    return data;
  }
}
