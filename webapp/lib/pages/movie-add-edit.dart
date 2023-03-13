import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:image_picker/image_picker.dart';
import '../config.dart';
import '../models/imageModel.dart';
import '../models/movie-model.dart';
import '../services/api-service.dart';
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
  ImageModel? imageModel;
  String fileName = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: const Text("Dados"),
          elevation: 0,
        ),
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

  @override
  void initState() {
    super.initState();
    movieModel = MovieModel();
    imageModel = ImageModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        movieModel = arguments["model"];
        imageModel = arguments["image"];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget movieForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "name",
              "Nome do Filme",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Movie name can´t be empty';
                }
                return null;
              },
              (onSavedVal) => {
                movieModel!.name = onSavedVal,
              },
              initialValue: movieModel!.name ?? "",
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
              "classification",
              "Classificação",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Movie classification can´t be empty';
                }
                return null;
              },
              (onSavedVal) {
                movieModel!.classification = int.parse(onSavedVal);
              },
              initialValue: movieModel!.classification == null
                  ? ""
                  : movieModel!.classification.toString(),
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
              "type",
              "Tipo",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Type can´t be empty';
                }
                return null;
              },
              (onSavedVal) => {
                movieModel!.type = int.parse(onSavedVal),
              },
              initialValue:
                  movieModel!.type == null ? "" : movieModel!.type.toString(),
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
              "duration",
              "Duração",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Duration can´t be empty';
                }
                return null;
              },
              (onSavedVal) => {
                movieModel!.duration = onSavedVal,
              },
              initialValue: movieModel!.duration ?? "",
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
              "room",
              "Sala",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Sala can´t be empty';
                }
                return null;
              },
              (onSavedVal) => {
                movieModel!.room = int.parse(onSavedVal),
              },
              initialValue:
                  movieModel!.room == null ? "" : movieModel!.room.toString(),
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),
          picPicker(isImageSalected, movieModel!.path ?? "", (file) {
            setState(() {
              movieModel!.path = file.path;
              isImageSalected = true;
              APIService.uploadImage(imageModel!, movieModel!, isImageSalected)
                  .then((value) => fileName = value);
            });
          }),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Save",
              () {
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
              btnColor: HexColor("#283B71"),
              borderColor: Colors.white,
              borderRadius: 10,
            ),
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
                    height: 200,
                    width: 200,
                  )
                : SizedBox(
                    child: Image.network(
                      fileName,
                      width: 200,
                      height: 200,
                      fit: BoxFit.scaleDown,
                    ),
                  )
            : SizedBox(
                child: Image.network(
                  (movieModel!.path == null || movieModel!.path == "")
                      ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                      : "http://192.168.8.158:3000/movie/file/upload/" +
                          movieModel!.path!,
                  height: 230,
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
