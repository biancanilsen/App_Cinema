// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../config.dart';
import '../models/imageModel.dart';
import '../models/movie-model.dart';
import 'package:flutter/foundation.dart';

import '../services/api-service.dart';

class MovieItem extends StatefulWidget {
  final MovieModel? model;
  final Function? onDelete;

  MovieItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  String movieId = "";

  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Container(
          width: 200,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: movieCardItem(context),
        ));
  }

  Widget movieCardItem(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: Image.network(
            (widget.model!.path == null || widget.model!.path == "")
                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                : "http://172.16.8.14:3000/movie/file/upload/${widget.model!.path}",
            height: 230,
            fit: BoxFit.scaleDown,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: Text(
                  "${widget.model!.name}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  if (widget.model!.classification == 0)
                    const Text("Classificação: Livre"),
                  if (widget.model!.classification == 1)
                    const Text("Classificação: 10+"),
                  if (widget.model!.classification == 2)
                    const Text("Classificação: 12+"),
                  if (widget.model!.classification == 3)
                    const Text("Classificação: 14+"),
                  if (widget.model!.classification == 4)
                    const Text("Classificação: 16+"),
                  if (widget.model!.classification == 5)
                    const Text("Classificação: 18+"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  if (widget.model!.type == 0) const Text("Tipo: Dublado"),
                  if (widget.model!.type == 1) const Text("Tipo: Legendado"),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Duração: ${widget.model!.duration}",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                "Sala: ${widget.model!.room}",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 250,
                margin: const EdgeInsets.only(top: 65),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.edit, color: Colors.green),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/edit-movie',
                          arguments: {
                            'model': widget.model //  "isEditMode": true
                          },
                        );
                      },
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete_sweep,
                        color: Colors.red,
                      ),
                      onTap: () {
                        widget.onDelete!(widget.model);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // Widget getType() {
  //   return Text((() {
  //     if (widget.model!.room == 0)
  //       [
  //         "Tipo: Dublado",
  //       ];
  //     return "Tipo: Legendado";
  //   })());
  // }
}
