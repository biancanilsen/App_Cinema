import 'package:flutter/material.dart';
import 'package:webapp/controllers/app_controller.dart';
import 'package:webapp/pages/home-page.dart';

// ignore: use_key_in_widget_constructors
class AppWidget extends StatelessWidget {
  get builder => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
              brightness: AppController.instance.isDartTheme
                  ? Brightness.dark
                  : Brightness.light,
            ),
            routes: {
              '/': (context) => const HomePage(),
            });
      },
    );
  }
}
