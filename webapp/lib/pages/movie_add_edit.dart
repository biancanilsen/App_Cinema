import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:image_picker/image_picker.dart';
import '../config.dart';
import '../models/image_model.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';
import 'package:flutter/foundation.dart';

class MovieAddEdit extends StatefulWidget {
  const MovieAddEdit({Key? key}) : super(key: key);

  @override
  State<MovieAddEdit> createState() => _MovieAddEditState();
}

class _MovieAddEditState extends State<MovieAddEdit> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAPICallProcess = false;
  MovieModel? movieModel;
  bool isEditMode = false;
  bool isImageSalected = false;
  bool newImage = false;
  String fileName = "";
  String movieId = "";

  @override
  void initState() {
    super.initState();
    movieModel = MovieModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        movieModel = arguments["model"];
        isEditMode = true;
        print(movieModel?.classification);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          elevation: 0,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (vaidateAndSave()) {
              //API Service
              setState(() {
                isAPICallProcess = true;
              });

              APIService.saveMovies(
                      movieModel!, isEditMode, isImageSalected, fileName)
                  .then(
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
          child: const Icon(Icons.save),
          backgroundColor: Colors.red[900],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isAPICallProcess,
          opacity: .3,
          key: UniqueKey(),
          child: Form(
            key: globalKey,
            child: movieForm(),
          ),
        ),
      ),
    );
  }

  Widget movieForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 30),
            child: FormHelper.inputFieldWidget(
              context,
              initialValue: movieModel?.name ?? "",
              "name",
              "Nome do Filme",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Movie name can´t be empty';
                }
                return null;
              },
              (onSavedVal) => {
                movieModel?.name = onSavedVal,
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
            padding:
                const EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(),
              ),
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0, left: 6, right: 4),
                  child: DropdownButtonFormField(
                    value: movieModel?.classification,
                    hint: const Text('Classificação'),
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 16.0,
                    ),
                    decoration: const InputDecoration(),
                    onChanged: (newValue) {
                      setState(() {
                        movieModel?.classification = newValue as int;
                      });
                    },
                    dropdownColor: Colors.white,
                    items: const [
                      DropdownMenuItem(
                        child: Text("Livre"),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text("10+"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("12+"),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("14+"),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        child: Text("16+"),
                        value: 4,
                      ),
                      DropdownMenuItem(
                        child: Text("18+"),
                        value: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(),
              ),
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0, left: 6, right: 4),
                  child: DropdownButtonFormField(
                    value: movieModel?.type,
                    hint: const Text('Tipo'),
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 16.0,
                    ),
                    decoration: const InputDecoration(),
                    onChanged: (newValue) {
                      setState(() {
                        movieModel?.type = newValue as int;
                      });
                    },
                    dropdownColor: Colors.white,
                    items: const [
                      DropdownMenuItem(
                        child: Text('Dublado'),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text('Legendado'),
                        value: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "duration",
              "Duração",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Duration can´t be empty';
                }
                return null;
              },
              (onSavedVal) => {
                movieModel?.duration = onSavedVal,
              },
              initialValue: movieModel?.duration ?? "",
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: FormHelper.inputFieldWidget(
              context,
              "room",
              "Sala",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Sala can´t be empty';
                }
                return null;
              },
              (onSavedVal) => {
                movieModel?.room = int.parse(onSavedVal),
              },
              initialValue:
                  movieModel?.room == null ? "" : movieModel!.room.toString(),
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),
          picPicker(isImageSalected, movieModel?.path ?? "", (file) {
            setState(() {
              movieModel?.path = file.path;
              isImageSalected = true;
              APIService.uploadImage(movieModel!, isImageSalected)
                  .then((value) => fileName = value);
              if (fileName != null) {
                newImage = true;
              }
            });
          }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool vaidateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget picPicker(
    bool isFileSelected,
    String fileName,
    Function onFilePicked,
  ) {
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();

    return Column(
      children: [
        fileName.isNotEmpty
            ? isFileSelected
                ? Image.file(
                    File(fileName),
                    height: 180,
                    width: 180,
                  )
                : SizedBox(
                    child: Image.network(
                      (isEditMode == true && movieModel!.path == "")
                          ? fileName
                          : "http://172.16.8.73:3000/movie/file/upload/${movieModel!.path!}",
                      height: 180,
                      fit: BoxFit.scaleDown,
                    ),
                  )
            : SizedBox(
                child: Image.network(
                  (movieModel!.path == null || movieModel!.path == "")
                      ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                      : "http://172.16.8.73:3000/movie/file/upload/${movieModel!.path!}",
                  height: 180,
                  fit: BoxFit.scaleDown,
                ),
              ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 35.0,
            width: 35.0,
            child: InkWell(
              onTap: () => {
                _imageFile = _picker.pickImage(source: ImageSource.gallery),
                _imageFile.then((file) async {
                  onFilePicked(file);
                }),
              },
              child: const Icon(Icons.image),
            ),
          ),
          SizedBox(
            height: 35.0,
            width: 35.0,
            child: InkWell(
              onTap: () => {
                _imageFile = _picker.pickImage(source: ImageSource.camera),
                _imageFile.then((file) async {
                  onFilePicked(file);
                }),
              },
              child: const Icon(Icons.camera),
            ),
          ),
        ])
      ],
    );
  }
}
