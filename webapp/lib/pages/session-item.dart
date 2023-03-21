import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
        trailing: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: const Icon(Icons.edit, color: Colors.green),
                onTap: () {
                  // Navigator.of(context).pushNamed(
                  //   '/edit-movie',
                  //   arguments: {'model': widget.model},
                  // );
                },
              ),
              GestureDetector(
                child: const Icon(
                  Icons.delete_sweep,
                  color: Colors.red,
                ),
                onTap: () {
                  // widget.onDelete!(widget.model);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
