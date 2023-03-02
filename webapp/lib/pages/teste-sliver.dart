import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          // title: Text(
          //   "Sliver App Bar",
          //   style: TextStyle(color: Colors.white),
          // ),
          centerTitle: true,
          backgroundColor: Colors.red,
          expandedHeight: 50,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "AB Cinemas",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            background: Image.network(
                "https://img.republicworld.com/republic-prod/stories/promolarge/xhdpi/3tijnb9mwaqp4y81_1600686404.jpeg",
                fit: BoxFit.fitHeight),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(ListeElemanlari()),
        ),
        SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          delegate: SliverChildListDelegate(ListeElemanlari()),
        ),
        SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          delegate: SliverChildListDelegate(ListeElemanlari()),
        ),
        SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          delegate: SliverChildListDelegate(ListeElemanlari()),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  List<Widget> ListeElemanlari() {
    return [
      Container(
        height: 150,
        child: Row(
          children: [
            Column(children: <Widget>[
              Container(
                // margin: const EdgeInsets.all(20),
                child: const Image(
                  width: 150,
                  image:
                      NetworkImage('https://www.tutorialkart.com/img/lion.jpg'),
                ),
              )
            ]),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: Row(
                    children: [
                      Text(
                        'Nome do filme:',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Homem Aranha 2',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: Row(
                    children: [
                      Text(
                        "Classificação: ",
                        style: TextStyle(fontSize: 12),
                      ),
                      // Spacer(
                      //   flex: 1,
                      // ),
                      Text(
                        "10+",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: Row(
                    children: [
                      Text(
                        "Tipo: ",
                        style: TextStyle(fontSize: 12),
                      ),
                      // Spacer(
                      //   flex: 1,
                      // ),
                      Text(
                        "Dublado",
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 12),
                      ),
                      // Spacer(
                      //   flex: 1,
                      // ),
                      Text(
                        "153min",
                        style: TextStyle(fontSize: 12),
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
                        style: TextStyle(fontSize: 12),
                      ),
                      // Spacer(
                      //   flex: 1,
                      // ),
                      Text(
                        "4",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Container(
      //   margin: EdgeInsets.only(bottom: 5),
      //   height: 150,
      //   color: Colors.white,
      //   alignment: Alignment.center,
      //   child: Text(
      //     "Filme 1",
      //     style: TextStyle(fontSize: 16),
      //     textAlign: TextAlign.center,
      //   ),
      // ),
      Container(
        margin: EdgeInsets.only(bottom: 5),
        height: 150,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "Filme 2",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 5),
        height: 150,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "Filme 3",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 5),
        height: 150,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "Filme 4",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 5),
        height: 150,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "Filme 5",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 5),
        height: 150,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "Filme 6",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 5),
        height: 150,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "Filme 7",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 5),
        height: 150,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "Filme 8",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 5),
        height: 150,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "Filme 9",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      )
    ];
  }
}
