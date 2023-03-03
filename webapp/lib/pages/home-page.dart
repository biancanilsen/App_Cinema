import 'dart:ffi';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String _title = 'Cinema Flutter Aplication';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: CustomScrollingWidget(),
    );
  }
}

class CustomScrollingWidget extends StatefulWidget {
  const CustomScrollingWidget({Key? key}) : super(key: key);

  @override
  State createState() => _CustomScrollingWidgetState();
}

class _CustomScrollingWidgetState extends State {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormat = GlobalKey<FormState>();
  String? name;
  String? classification;
  Enum? type;
  DateTime? duration;
  Int? room;

  Widget _buildFixedList(Color color, String _text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          _text,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            backgroundColor: Colors.redAccent[700],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Cinema'),
              centerTitle: true,
              background: Image.network(
                "https://img.freepik.com/vetores-gratis/modelo-de-exibicao-com-claquete-e-oculos_79603-1244.jpg",
                fit: BoxFit.fitHeight,
                height: 150,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                const Expanded(
                    child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome do filme',
                  ),
                )),
                Container(
                  padding: const EdgeInsets.all(3),
                  alignment: Alignment.center,
                  height: 75,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shadowColor: Colors.greenAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      // minimumSize: const Size(30, 58),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    label: const Text(""),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  alignment: Alignment.center,
                  height: 75,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shadowColor: Colors.blueAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      // minimumSize: const Size(20, 58),
                    ),
                    onPressed: () {
                      openDialogCreateMovie();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(""),
                  ),
                )
              ],
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 300.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  child: Row(
                    children: [
                      Column(children: <Widget>[
                        InkWell(
                          child: Container(
                            margin: const EdgeInsets.all(1),
                            child: const Image(
                              height: 290,
                              image: NetworkImage(
                                  'https://www.sonypictures.com.br/sites/brazil/files/2022-03/key%20art_homem%20aranha%202.JPG'),
                            ),
                          ),
                          onTap: () {
                            openDialogDetails();
                          },
                        ),
                      ]),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: const [
                                Text(
                                  'Filme:',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  'Homem Aranha 2',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.5),
                            child: Row(
                              children: const [
                                Text(
                                  "Classificação: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "10+",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.5),
                            child: Row(
                              children: const [
                                Text(
                                  "Tipo: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Dublado",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.5),
                            child: Row(
                              children: const [
                                Text(
                                  "Duração: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "153min",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.5),
                            child: Row(
                              children: const [
                                Text(
                                  "Sala: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "4",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openDialogDetails() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sessões'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Sessão 1.'),
                Text('Sessão 2'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void closeDialogDetails() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future openDialogCreateMovie() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text("Cadastrar filme"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: const [
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome do filme',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Classificação',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tipo',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Duração',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Sala',
                          ),
                        ),
                      )
                    ],
                  ),
                  // ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Salvar'),
                  onPressed: closeDialogCreateMovie,
                )
              ]));

  void closeDialogCreateMovie() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
