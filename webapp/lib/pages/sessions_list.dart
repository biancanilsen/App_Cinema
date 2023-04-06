import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/movie_model.dart';
import 'package:flutter_application/models/sessions_model.dart';
import 'package:flutter_application/pages/session_add_edit.dart';
import 'package:flutter_application/pages/session_item.dart';
import 'package:flutter_application/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/foundation.dart';

import '../config.dart';

class SessionsList extends StatefulWidget {
  const SessionsList({Key? key}) : super(key: key);

  @override
  _SessionsListState createState() => _SessionsListState();
}

class _SessionsListState extends State<SessionsList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  MovieModel? movieModel;
  SessionsModel? sessionsModel;

  @override
  void initState() {
    super.initState();
    movieModel = MovieModel();
    sessionsModel = SessionsModel();
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
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SessionsAddEditDialog(movieId: movieModel?.id);
            },
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.red[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget loadSessions() {
    setState(() {});
    return FutureBuilder(
      future: APIService.getSessions(movieModel?.id),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<SessionsModel>?> sessionsModel,
      ) {
        if (sessionsModel.hasData) {
          return sessionsList(sessionsModel.data);
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }

  Widget sessionsList(sessions) {
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
                  sessionsModel: sessions[index],
                  movieId: movieModel?.id,
                  onDelete: (SessionsModel sessionsModel) {
                    setState(() {
                      isApiCallProcess = true;
                    });

                    APIService.deleteSessions(sessionsModel.id)
                        .then((response) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                    });
                  },
                );
              },
            ),
          ])
        ],
      ),
    );
  }

  bool vaidateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
