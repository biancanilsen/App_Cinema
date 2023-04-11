// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../config.dart';
import '../models/image_model.dart';
import '../models/movie_model.dart';
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).pushNamed(
            '/sessions-movie',
            arguments: {'movieModel': widget.model},
          );
        },
        child: Container(
          width: 200,
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.black87,
            // borderRadius: BorderRadius.circular(50),
          ),
          child: movieCardItem(context),
        ),
      ),
    );
  }

  Widget movieCardItem(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 300,
          child: Image.network(
            (widget.model!.path == null || widget.model!.path == "")
                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                : "http://172.16.8.73:3000/movie/file/upload/${widget.model!.path}",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: Text(
                  "${widget.model!.name}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.8,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  if (widget.model!.classification == 0)
                    const Text("Classificação: Livre",
                        style: TextStyle(color: Colors.white)),
                  if (widget.model!.classification == 1)
                    const Text("Classificação: 10+",
                        style: TextStyle(color: Colors.white)),
                  if (widget.model!.classification == 2)
                    const Text("Classificação: 12+",
                        style: TextStyle(color: Colors.white)),
                  if (widget.model!.classification == 3)
                    const Text("Classificação: 14+",
                        style: TextStyle(color: Colors.white)),
                  if (widget.model!.classification == 4)
                    const Text("Classificação: 16+",
                        style: TextStyle(color: Colors.white)),
                  if (widget.model!.classification == 5)
                    const Text("Classificação: 18+",
                        style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  if (widget.model!.type == 0)
                    const Text("Tipo: Dublado",
                        style: TextStyle(color: Colors.white)),
                  if (widget.model!.type == 1)
                    const Text("Tipo: Legendado",
                        style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Duração: ${widget.model!.duration} minutos",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                "Sala: ${widget.model!.room}",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 7,
                    left: MediaQuery.of(context).size.width / 2.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        child: const Icon(Icons.edit, color: Colors.white),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/edit-movie',
                            arguments: {'model': widget.model},
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete_sweep,
                        color: Colors.white,
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
}
