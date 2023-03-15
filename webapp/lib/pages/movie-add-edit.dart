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
  List<dynamic> countries = [];
  String? countruId;
  // String dropdownValue = 'One';
  // String fileName = MovieModel.path.toString();

  @override
  void initState() {
    super.initState();

    this.countries.add({"id": 1, "label": "India"});
    this.countries.add({"id": 2, "label": "EUA"});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: const Text("Dados"),
          backgroundColor: Colors.red[900],
          elevation: 0,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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

            // child: FormHelper.dropDownWidgetWithLabel(
            //   context,
            //   "Selecione uma classificação",
            //   this.countruId,
            //   this.countruId,
            //   this.countries,
            //   (onChanged{}),
            //   onValidate)

            // child: DropdownButtonFormField(
            //   // value: 'item1',
            //   hint: Text('Classificação'),
            //   decoration: const InputDecoration(),
            //   onChanged: (_) {},
            //   dropdownColor: Colors.white,

            //   items: [
            //     DropdownMenuItem(
            //       child: Text('Livre'),
            //       value: '0',
            //     ),
            //     DropdownMenuItem(
            //       child: Text('10+'),
            //       value: '1',
            //     ),
            //     DropdownMenuItem(
            //       child: Text('12+'),
            //       value: '2',
            //     ),
            //     DropdownMenuItem(
            //       child: Text('14+'),
            //       value: '3',
            //     ),
            //     DropdownMenuItem(
            //       child: Text('16+'),
            //       value: '4',
            //     ),
            //     DropdownMenuItem(
            //       child: Text('18+'),
            //       value: '5',
            //     ),
            //   ],
            // ),

            // child: FormHelper.dropDownWidgetWithLabel(
            //   context,
            //   "Classificação",
            //   "Classificação indicativa",
            //   dropdownValue,
            //   lstData,
            //  (String? newValue) {
            //       setState(() {
            //         dropdownValue = newValue!;
            //       });
            //     },
            //   (){

            //   },
            //   )

            // child: FormHelper.inputFieldWidget(
            //   context,
            //   "classification",
            //   "Classificação",
            //   (onValidateVal) {
            //     if (onValidateVal.isEmpty) {
            //       return 'Movie classification can´t be empty';
            //     }
            //     return null;
            //   },
            //   (onSavedVal) {
            //     movieModel!.classification = int.parse(onSavedVal);
            //   },
            //   initialValue: movieModel!.classification == null
            //       ? ""
            //       : movieModel!.classification.toString(),
            //   borderColor: Colors.black,
            //   borderFocusColor: Colors.black,
            //   textColor: Colors.black,
            //   hintColor: Colors.black.withOpacity(.7),
            //   borderRadius: 10,
            //   showPrefixIcon: false,
            // ),
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
            padding: const EdgeInsets.only(bottom: 5, top: 10),
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
              debugPrint('movieModel.path: $file.path');
              isImageSalected = true;
              APIService.uploadImage(imageModel!, movieModel!, isImageSalected)
                  .then((value) => fileName = value);
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
        isEditMode
            ? SizedBox(
                child: Image.network(
                  (movieModel!.path == null || movieModel!.path == "")
                      ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                      : "http://192.168.8.158:3000/movie/file/upload/" +
                          movieModel!.path!,
                  height: 290,
                  fit: BoxFit.scaleDown,
                ),
              )
            : fileName.isNotEmpty
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
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                      width: 200,
                      height: 200,
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
