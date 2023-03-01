import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'AB Cinemas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
        ),
        SizedBox(
            height: 300,
            child: CustomScrollView(
              primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[100],
                        child: const Text("He'd have you all unravel at the"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[200],
                        child: const Text('Heed not the rabble'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[300],
                        child: const Text('Sound of screams but the'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[400],
                        child: const Text('Who scream'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[500],
                        child: const Text('Revolution is coming...'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[600],
                        child: const Text('Revolution, they...'),
                      ),
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
