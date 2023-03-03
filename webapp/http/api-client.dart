// import 'package:http/http.dart' as http;

// void apiClient() {}

// Future fetch() async {
//   var url = 'https://jsonplaceholder.typicode.com/todos/1';
//   // var response = await http.get(url);
// }
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(),
    );
  }
}
