import 'dart:convert';
import 'package:flutter_application/models/movie-model.dart';

List<SessionsModel> sessionsFromJson(String str) => List<SessionsModel>.from(
    json.decode(str).map((x) => SessionsModel.fromJson(x)));

String sessionsToJson(List<SessionsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SessionsModel {
  // late String? id;
  late String? timeDay;
  late DateTime? date;
  late String? movieId;

  SessionsModel({
    // this.id,
    this.timeDay,
    this.date,
    this.movieId,
  });

  SessionsModel.fromJson(Map<String, dynamic> json) {
    // id = json["id"];
    timeDay = json["timeDay"];
    date = json["date"];
    movieId = json["MovieModel"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data["id"] = id;
    _data["timeDay"] = timeDay;
    _data["date"] = date;
    _data["MovieModel"] = movieId;
    ;

    return _data;
  }
}
