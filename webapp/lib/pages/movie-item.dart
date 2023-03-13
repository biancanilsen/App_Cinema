import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../models/movie-model.dart';
import 'package:flutter/foundation.dart';

class MovieItem extends StatelessWidget {
  // const MovieItem({Key? key, this.model, this.onDelete}) : super(key: key);

  final MovieModel? model;
  final Function? onDelete;

  MovieItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

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
          // child: Image.file(File(model?.path!)),
          child: Image.network(
            (model!.path == null || model!.path == "")
                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                : "http://192.168.8.158:3000/movie/file/upload/" + model!.path!,
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
              Text(
                model!.name!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${model!.classification}",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                "${model!.type}",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                "${model!.duration}",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                "${model!.room}",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 250,
                margin: const EdgeInsets.only(top: 75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.edit, color: Colors.green),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/edit-movie',
                          arguments: {'model': model},
                        );
                      },
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        onDelete!(model);
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
