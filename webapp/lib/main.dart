import 'package:flutter/material.dart';
import 'package:flutter_application/pages/movie_add_edit.dart';
import 'package:flutter_application/pages/movie_list.dart';
import 'package:flutter_application/pages/movie_sessions.dart';
import 'package:flutter_application/pages/session_add_edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const MovieList(),
          '/add-movie': (context) => const MovieAddEdit(),
          '/edit-movie': (context) => const MovieAddEdit(),
          '/sessions-movie': (context) => MovieSessions(),
          // '/add-session': (context) => SessionsAddEditDialog(),
          // '/edit-session': (context) => SessionAddEdit(),
        });
  }
}
