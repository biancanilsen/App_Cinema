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
  Widget _buildFixedList(Color color, String _text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          _text,
          style: TextStyle(color: Colors.white, fontSize: 25),
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
              title: Text('Cinema'),
              centerTitle: true,
              background: Image.network(
                  "https://img.freepik.com/vetores-gratis/modelo-de-exibicao-com-claquete-e-oculos_79603-1244.jpg",
                  fit: BoxFit.fitHeight,
                  height: 150),
            ),
          ),
          // SizedBox(height: 20),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome do filme',
                  ),
                )),
                Container(
                  padding: EdgeInsets.all(3),
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
                      minimumSize: Size(30, 58),
                    ),
                    onPressed: () {
                      print("You pressed Icon Elevated Button");
                    },
                    icon: Icon(Icons.search),
                    label: Text(""),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3),
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
                      minimumSize: Size(20, 58),
                    ),
                    onPressed: () {
                      print("You pressed Icon Elevated Button");
                    },
                    icon: Icon(Icons.add), //icon data for elevated button
                    label: Text(""), //label text
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
                        Container(
                          margin: const EdgeInsets.all(1),
                          child: const Image(
                            height: 290,
                            image: NetworkImage(
                                'https://www.sonypictures.com.br/sites/brazil/files/2022-03/key%20art_homem%20aranha%202.JPG'),
                          ),
                        )
                      ]),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Text(
                                  'Filme:',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  'Homem Aranha 2',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Text(
                                  'Classificação:',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Expanded(
                                  child: Text(
                                    '10+',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.5),
                            child: Row(
                              children: [
                                Text(
                                  "Tipo: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                // Spacer(
                                //   flex: 1,
                                // ),
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
                              children: [
                                Text(
                                  "Duração: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                // Spacer(
                                //   flex: 1,
                                // ),
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
                              children: [
                                Text(
                                  "Sala: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                // Spacer(
                                //   flex: 1,
                                // ),
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
}
