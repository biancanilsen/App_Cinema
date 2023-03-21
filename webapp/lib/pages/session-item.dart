import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application/pages/session-add-edit.dart';
import '../models/sessions_model.dart';
import 'package:intl/intl.dart';

class SessionItem extends StatefulWidget {
  final SessionsModel? model;

  // const SessionItem({super.key, required sessionsModel});

  SessionItem({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  State<SessionItem> createState() => _SessionItemState();
}

class _SessionItemState extends State<SessionItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        // onTap: () {
        //   Navigator.of(context).pushNamed(
        //     '/sessions-movie',
        //     arguments: {'movieModel': widget.model},
        //   );
        // },
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: sessionCardItem(context),
        ),
      ),
    );
  }

  Widget sessionCardItem(context) {
    String formattedDate = formatDate(widget.model!.date!);
    return Card(
      child: ListTile(
        title: Text("Data: $formattedDate"),
        subtitle: Text(
          "Horário: ${widget.model!.timeDay}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.green,
              ),
              // onPressed: () {
              //   Navigator.of(context).pushNamed(
              //     '/edit-session',
              //     // arguments: {'model': widget.model},
              //   );
              // },
              onPressed: () async {
                await showInformationDialog(context);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_sweep,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/edit-session',
                  // arguments: {'model': widget.model},
                );
              },
            ),
          ],
        ),

        // trailing: Padding(
        //   padding: const EdgeInsets.only(top: 50),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       IconButton(
        //         icon: const Icon(Icons.edit, color: Colors.green),
        //         tooltip: 'Increase volume by 10',
        //         onPressed: () {
        //           Navigator.of(context).pushNamed(
        //             '/edit-session',
        //             // arguments: {'model': widget.model},
        //           );
        //         },
        //       ),
        //       IconButton(
        //         icon: const Icon(Icons.delete_sweep, color: Colors.red),
        //         tooltip: 'Increase volume by 10',
        //         onPressed: () {
        //           Navigator.of(context).pushNamed(
        //             '/edit-session',
        //             // arguments: {'model': widget.model},
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        // validator: (value) {
                        //   return value.isNotEmpty ? null : "Enter any text";
                        // },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Data',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _textEditingController,
                        // validator: (value) {
                        //   return value.isNotEmpty ? null : "Enter any text";
                        // },
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
                      onPressed: () {},
                      child: const Text('Salvar'),
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }
}
