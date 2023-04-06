import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application/pages/session_add_edit.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../config.dart';
import '../models/movie_model.dart';
import '../models/sessions_model.dart';
import 'package:intl/intl.dart';

import '../services/api_service.dart';

class SessionItem extends StatefulWidget {
  late SessionsModel? sessionsModel;
  final String? movieId;
  final Function? onDelete;
  final MovieModel? model;

  SessionItem(
      {Key? key, this.sessionsModel, this.movieId, this.onDelete, this.model})
      : super(key: key);

  @override
  State<SessionItem> createState() => _SessionItemState();
}

class _SessionItemState extends State<SessionItem> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAPICallProcess = false;
  SessionsModel? sessionsModel;
  final TextEditingController _dateEditingController = TextEditingController();
  final TextEditingController _hourlyEditingController =
      TextEditingController();

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {});
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.red.withAlpha(30),
        child: Container(
          width: 200,
          height: 85,
          child: sessionCardItem(context),
        ),
      ),
    );
  }

  Widget sessionCardItem(context) {
    debugPrint(widget.sessionsModel!.id);
    String formattedDate = formatDate(widget.sessionsModel!.date!);
    return Card(
      color: Colors.black87,
      child: ListTile(
        title: Text(
          "Data: $formattedDate",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          "Horário: ${widget.sessionsModel!.timeDay}",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SessionsAddEditDialog(
                        sessionModel: widget.sessionsModel);
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_sweep,
                color: Colors.white,
              ),
              onPressed: () {
                widget.onDelete!(widget.sessionsModel);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: globalKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _dateEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Data',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _hourlyEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Hora',
                        ),
                      ),
                    ],
                  )),
              title: Text('Sessão'),
              actions: <Widget>[
                InkWell(
                  child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        child: const Text('Salvar'),
                        onPressed: () async {
                          if (vaidateAndSave()) {
                            setState(() {
                              isAPICallProcess = true;
                            });

                            APIService.saveSessions(sessionsModel!, false).then(
                              (response) {
                                setState(() {
                                  isAPICallProcess = false;
                                });

                                if (response) {
                                  Navigator.of(context).pushNamed(
                                    '/sessions-movie',
                                    arguments: {'movieModel': widget.model},
                                  );
                                  // Navigator.pushNamed(
                                  //         context, '/sessions-movie')
                                  //     .then((_) => setState(() {}));

                                  Navigator.of(context).pop();
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
                        }),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  bool vaidateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      debugPrint('form: $form');
      return true;
    }
    return false;
  }
}
