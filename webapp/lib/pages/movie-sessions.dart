import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/movie-model.dart';
import 'package:flutter_application/models/sessions_model.dart';
import 'package:flutter_application/services/api-service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/foundation.dart';

class MovieSessions extends StatefulWidget {
  // const MovieSessions({super.key});
  const MovieSessions({Key? key}) : super(key: key);

  @override
  State<MovieSessions> createState() => _MovieSessionsState();
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
      future: APIService.getSessions(sessionsModel?.movieId),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<SessionsModel>?> sessionsModel,
      ) {
        debugPrint('sessionsModel?.movieId: $sessionsModel?.movieId');
        if (sessionsModel.hasData) {
          debugPrint('sessionsList: $sessionsList');
          return sessionsList(sessionsModel.data);
        }
        // return movieList(model.data);
        return const Center(
            // child: CircularProgressIndicator(),
            child: Text('Não deu certo :('));
      },
    );
  }

  Widget sessionsList(sessions) {
    return Card(
      child: ListTile(
        title: Text('One-line with trailing widget'),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
