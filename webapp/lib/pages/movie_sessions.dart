import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/movie_model.dart';
import 'package:flutter_application/models/sessions_model.dart';
import 'package:flutter_application/pages/session_item.dart';
import 'package:flutter_application/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/foundation.dart';

import '../config.dart';

class MovieSessions extends StatefulWidget {
  // const MovieSessions({super.key});
  // pesquisar
  const MovieSessions({Key? key}) : super(key: key);

  @override
  _MovieSessionsState createState() => _MovieSessionsState();
}

class _MovieSessionsState extends State<MovieSessions> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final TextEditingController _dateEditingController = TextEditingController();
  // final TextEditingController _hourlyEditingController =
  //     TextEditingController();
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
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Sessões'),
            content: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1, top: 3),
                    child: FormHelper.inputFieldWidget(
                      context,
                      initialValue: "",
                      "date",
                      "Data",
                      (onValidateVal) {
                        if (onValidateVal.isEmpty) {
                          return 'Data can´t be empty';
                        }
                        return null;
                      },
                      (onSavedVal) => {
                        sessionsModel?.date = onSavedVal,
                      },
                      borderColor: Colors.black,
                      borderFocusColor: Colors.black,
                      textColor: Colors.black,
                      hintColor: Colors.black.withOpacity(.7),
                      borderRadius: 10,
                      showPrefixIcon: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: FormHelper.inputFieldWidget(
                      context,
                      "timeDay",
                      "Hora",
                      (onValidateVal) {
                        if (onValidateVal.isEmpty) {
                          return 'Hora can´t be empty';
                        }
                        return null;
                      },
                      (onSavedVal) => {
                        sessionsModel?.timeDay = onSavedVal,
                      },
                      initialValue: "",
                      borderColor: Colors.black,
                      borderFocusColor: Colors.black,
                      textColor: Colors.black,
                      hintColor: Colors.black.withOpacity(.7),
                      borderRadius: 10,
                      showPrefixIcon: false,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                onPressed: () {
                  onPressed:
                  () => Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  if (vaidateAndSave()) {
                    //API Service
                    setState(() {
                      isApiCallProcess = true;
                    });

                    APIService.saveSessions(sessionsModel!).then(
                      (response) {
                        setState(() {
                          isApiCallProcess = false;
                        });

                        if (response) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                        } else {
                          FormHelper.showSimpleAlertDialog(
                            context,
                            Config.appName,
                            "Error Occure",
                            "OK",
                            () {
                              Navigator.of(context).pop();
                            },
                          );
                        }
                      },
                    );
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
        // onPressed: () async {
        //   await showInformationDialog(context);
        // },
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
        if (sessionsModel.hasData) {
          debugPrint('sessionsList: $sessionsList');
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
                  model: sessions[index],
                );
              },
            ),
          ])
        ]));
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
