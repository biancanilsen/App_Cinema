import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';
import '../models/movie_model.dart';
import '../models/sessions_model.dart';
import '../config.dart';
import 'package:flutter/foundation.dart';

class APIService {
  late final fileName = String;
  ImageModel imageModel = ImageModel();
  static var client = http.Client();

  static Future<List<MovieModel>?> getMovies() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.movieURL);

    debugPrint('url: $url');

    var response = await client.get(url, headers: requestHeaders);
    debugPrint('response: $response');

    if (response.statusCode == 200) {
      List<MovieModel> _model = moviesFromJson(response.body);

      return _model;
    } else {
      return null;
    }
  }

  static Future<String> uploadImage(
    MovieModel model,
    bool isFileSelected,
  ) async {
    var imageURL = Config.imageURL;

    var url = Uri.http(Config.apiURL, imageURL);

    var request = http.MultipartRequest("POST", url);
    debugPrint('request $request');

    if (model.path != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'file',
        model.path!,
      );

      request.files.add(multipartFile);
    }

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    debugPrint('response $response');

    if (response.statusCode == 201) {
      String fileNameResponse = response.body;

      ImageModel imageModel = ImageModel.fromJson(jsonDecode(fileNameResponse));

      var fileName = imageModel.filename.toString();
      print(fileName);

      return fileName;
    } else {
      return "";
    }
  }

  static Future<bool> saveMovies(
    MovieModel model,
    bool isEditMode,
    bool isFileSelected,
    String fileName,
  ) async {
    var movieURL = Config.movieURL;

    if (isEditMode) {
      movieURL = movieURL + "/" + model.id.toString();
    }
    debugPrint(' $isFileSelected');
    var url = Uri.http(Config.apiURL, movieURL);
    debugPrint('url: $url');

    var requestMethod = isEditMode ? "PUT" : "POST";

    Map data;
    var body;
    var response;

    if (isFileSelected == false) {
      data = {
        'name': model.name,
        'classification': model.classification,
        'type': model.type,
        'duration': model.duration,
        'room': model.room,
        'path': model.path,
      };
      body = json.encode(data);
    } else {
      data = {
        'name': model.name,
        'classification': model.classification,
        'type': model.type,
        'duration': model.duration,
        'room': model.room,
        'path': fileName,
      };
      body = json.encode(data);
    }

    if (isEditMode == true) {
      response = await http.put(url,
          headers: {"Content-Type": "application/json"}, body: body);
    } else {
      response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
    }

    debugPrint('response $response');

    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('response $response.statusCode');
      return true;
    } else {
      debugPrint('response $response.statusCode');
      return false;
    }
  }

  static Future<bool> deleteMovies(movieId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.movieURL + "/" + movieId);
    debugPrint('url: $url');

    var response = await client.delete(url, headers: requestHeaders);
    debugPrint('response: $response');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<SessionsModel>?> getSessions(movieId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    // SessionsModel sessionsModel;

    var url = Uri.http(Config.apiURL, Config.sessionURL + "/" + movieId);

    debugPrint('url: $url');

    var response = await client.get(url, headers: requestHeaders);
    debugPrint('response: $response');

    if (response.statusCode == 200) {
      List<SessionsModel> _sessionsModel = sessionsFromJson(response.body);
      debugPrint('_sessionsModel: $_sessionsModel');

      return await _sessionsModel;
    } else {
      return null;
    }
  }
}
