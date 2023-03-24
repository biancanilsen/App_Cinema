import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';
import '../models/sessions_model.dart';
import '../services/api_service.dart';

class SessionsAddEditDialog extends StatefulWidget {
  const SessionsAddEditDialog({Key? key, this.sessionModel}) : super(key: key);
  final SessionsModel? sessionModel;

  @override
  State<SessionsAddEditDialog> createState() => _SessionsAddEditDialogState();
}

class _SessionsAddEditDialogState extends State<SessionsAddEditDialog> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAPICallProcess = false;
  SessionsModel? sessionsModel;
  // late final String id;

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);

    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    sessionsModel = SessionsModel();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sessão'),
      content: Form(
        key: globalKey,
        child: sessionForm(),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (vaidateAndSave()) {
              setState(() {
                isAPICallProcess = true;
              });

              APIService.saveSessions(sessionsModel!, true).then(
                (response) {
                  setState(() {
                    isAPICallProcess = false;
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
          child: Text('Salvar'),
        ),
      ],
    );
  }

  // getData(String id) async {
  //   sessionsModel = await APIService.getSessionsEdit(id) as SessionsModel?;
  //   return sessionsModel;
  // }

  bool vaidateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget sessionForm() {
    String? formattedDate;
    if (widget.sessionModel!.date != null || widget.sessionModel!.date != "") {
      formattedDate = formatDate(widget.sessionModel!.date!);
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 30),
            child: FormHelper.inputFieldWidget(
              context,
              initialValue: formattedDate ?? "",
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
                  return 'Hourly can´t be empty';
                }
                return null;
              },
              (onSavedVal) => {
                sessionsModel?.timeDay = onSavedVal,
              },
              initialValue: sessionsModel?.timeDay ?? "",
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
