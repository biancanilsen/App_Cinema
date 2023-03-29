import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/models/sessions_model.dart';
import 'package:flutter_application/pages/session_add_edit.dart';
import 'package:flutter_application/services/api_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../models/movie_model.dart';
import 'movie_item.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  bool isAPICallProcess = false;
  SessionsModel? sessionModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cinema"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        child: loadMovies(),
        inAsyncCall: isAPICallProcess,
        opacity: .3,
        key: UniqueKey(),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add-movie");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.red[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget loadMovies() {
    return FutureBuilder(
      future: APIService.getMovies(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<MovieModel>?> model,
      ) {
        if (model.hasData) {
          debugPrint('movieList: $movieList');
          return movieList(model.data);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget movieList(movies) {
    debugPrint('movies: $movies');
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
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieItem(
                  model: movies[index],
                  onDelete: (MovieModel model) {
                    setState(() {
                      isAPICallProcess = true;
                    });

                    APIService.deleteMovies(model.id).then((response) {
                      setState(() {
                        isAPICallProcess = false;
                      });
                    });
                  },
                );
              },
            ),
          ])
        ]));
  }
}
