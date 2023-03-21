import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/movie_model.dart';
import 'package:flutter_application/models/sessions_model.dart';
import 'package:flutter_application/pages/session_item.dart';
import 'package:flutter_application/services/api_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/foundation.dart';

class MovieSessions extends StatefulWidget {
  // const MovieSessions({super.key});
  const MovieSessions({Key? key}) : super(key: key);

  @override
  _MovieSessionsState createState() => _MovieSessionsState();
}

class _MovieSessionsState extends State<MovieSessions> {
  bool isApiCallProcess = false;
  MovieModel? movieModel;
  SessionsModel? sessionsModel;

  @override
  void initState() {
    super.initState();
    movieModel = MovieModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        movieModel = arguments["movieModel"];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sessões"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        child: loadSessions(),
        inAsyncCall: isApiCallProcess,
        opacity: .3,
        key: UniqueKey(),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, "/");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.red[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget loadSessions() {
    return FutureBuilder(
      future: APIService.getSessions(movieModel?.id),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<SessionsModel>?> sessionsModel,
      ) {
        debugPrint('sessionsModel?.movieId: $sessionsModel');
        // setState(() {});
        if (sessionsModel.hasData) {
          debugPrint('sessionsList: $sessionsList');
          return sessionsList(sessionsModel.data);
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }

  Widget sessionsList(sessions) {
    // return Card(
    //   child: ListTile(
    //     title: Text('One-line with trailing widget'),
    //     trailing: Icon(Icons.more_vert),
    //   ),
    // );
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                return SessionItem(
                  model: sessions[index],
                );
              },
            ),
          ])
        ]));
  }
}
