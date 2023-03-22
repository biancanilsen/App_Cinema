import 'dart:convert';
import 'package:flutter/foundation.dart';

List<SessionsModel> sessionsFromJson(String str) => List<SessionsModel>.from(
    json.decode(str).map((x) => SessionsModel.fromJson(x)));

String sessionsToJson(List<SessionsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SessionsModel {
  late String? id;
  late String? date;
  late String? timeDay;
  late String? movieId;

  SessionsModel({
    this.id,
    this.date,
    this.timeDay,
    this.movieId,
  });

  SessionsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    date = json["date"];
    timeDay = json["timeDay"];
    movieId = json["movieId"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["date"] = date;
    data["timeDay"] = timeDay;
    data["movieId"] = movieId;

    debugPrint('_data: $data');
    return data;
  }
}
