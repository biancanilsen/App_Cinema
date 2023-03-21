import 'package:flutter/material.dart';
import 'package:flutter_application/pages/movie-add-edit.dart';
import 'package:flutter_application/pages/movie-list.dart';
import 'package:flutter_application/pages/movie-sessions.dart';

import 'pages/session-add-edit.dart';

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
          '/sessions-movie': (context) => const MovieSessions(),
          '/add-session': (context) => const SessionAddEdit(),
          '/edit-session': (context) => const SessionAddEdit(),
        });
  }
}
