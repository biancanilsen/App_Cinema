import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/imageModel.dart';
import '../models/movie-model.dart';
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
    ImageModel imageModel,
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

      imageModel = ImageModel.fromJson(jsonDecode(fileNameResponse));

      debugPrint('imageModel $imageModel');
      // var body = imageModel.filename;
      // var body = jsonEncode(response.body);
      // model.path = body.filename.toString();

      return imageModel.filename.toString();
    } else {
      return "";
    }
  }

  static Future<bool> saveMovies(
    MovieModel model,
    bool isEditMode,
    bool isFileSelected,
    String fileName,
    ImageModel imagemodel,
  ) async {
    var movieURL = Config.movieURL;

    if (isEditMode) {
      movieURL = movieURL + "/" + model.id.toString();
    }

    var url = Uri.http(Config.apiURL, movieURL);
    debugPrint('url: $url');

    var requestMethod = isEditMode ? "PUT" : "POST";

    Map data = {
      'name': model.name,
      'classification': model.classification,
      'type': model.type,
      'duration': model.duration,
      'room': model.room,
      // 'path': imageModel.filename.toString(),
      'path': fileName,
      // tentar json encode para retornar a ser string
    };

    var body = json.encode(data);

    if (isEditMode) {
      var response = await http.put(url,
          headers: {"Content-Type": "application/json"}, body: body);
      debugPrint('response: $response');
    }
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    // if (model.path != null && isFileSelected) {
    //   http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
    //     'path',
    //     model.path!,
    //   );

    // request.files.add(multipartFile);
    // }

    debugPrint('response $response');

    if (response.statusCode == 201) {
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

    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
