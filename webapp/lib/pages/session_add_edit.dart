// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:snippet_coder_utils/FormHelper.dart';
// import 'package:snippet_coder_utils/ProgressHUD.dart';

// import '../config.dart';
// import '../models/sessions_model.dart';
// import '../services/api_service.dart';

// class SessionsAddEditDialog extends StatefulWidget {
//   const SessionsAddEditDialog({super.key});
//   static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

//   @override
//   State<SessionsAddEditDialog> createState() => _SessionsAddEditDialogState();
// }

// class _SessionsAddEditDialogState extends State<SessionsAddEditDialog> {
//   static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
//   bool isAPICallProcess = false;
//   SessionsModel? sessionsModel;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           // title: const Text("Dados"),
//           backgroundColor: Colors.red[900],
//           elevation: 0,
//         ),
//         bottomNavigationBar: BottomAppBar(
//           shape: const CircularNotchedRectangle(),
//           child: Container(height: 50.0),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             if (vaidateAndSave()) {
//               //API Service
//               setState(() {
//                 isAPICallProcess = true;
//               });

//               APIService.saveSessions(sessionsModel!).then(
//                 (response) {
//                   setState(() {
//                     isAPICallProcess = false;
//                   });

//                   if (response) {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, '/', (route) => false);
//                   } else {
//                     FormHelper.showSimpleAlertDialog(
//                       context,
//                       Config.appName,
//                       "Error Occure",
//                       "OK",
//                       () {
//                         Navigator.of(context).pop();
//                       },
//                     );
//                   }
//                 },
//               );
//             }
//           },
//           child: const Icon(Icons.save),
//           backgroundColor: Colors.red[900],
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         backgroundColor: Colors.grey[200],
//         body: ProgressHUD(
//           inAsyncCall: isAPICallProcess,
//           opacity: .3,
//           key: UniqueKey(),
//           child: Form(
//             key: globalKey,
//             child: sessionsForm(),
//           ),
//         ),
//       ),
//     );
//   }

//   // @override
//   // Widget sessionsForm() {
//   //   return TextButton(
//   //     onPressed: () => showDialog<String>(
//   //       context: context,
//   //       builder: (BuildContext context) => AlertDialog(
//   //         title: const Text('AlertDialog Title'),
//   //         content: const Text('AlertDialog description'),
//   //         actions: <Widget>[
//   //           TextButton(
//   //             onPressed: () => Navigator.pop(context, 'Cancel'),
//   //             child: const Text('Cancel'),
//   //           ),
//   //           TextButton(
//   //             onPressed: () => Navigator.pop(context, 'OK'),
//   //             child: const Text('OK'),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //     child: const Text('Show Dialog'),
//   //   );
//   // }

//   // @override
//   // Widget sessionsForm() {
//   //   return GestureDetector(
//   //     onTap: () => Navigator.pop(context),
//   //     child: AlertDialog(
//   //       content: InkWell(
//   //         onTap: () => Navigator.pop(context),
//   //         child: const Padding(
//   //           padding: EdgeInsets.all(16.0),
//   //           child: Text('AlertDialog description'),
//   //         ),
//   //       ),
//   //       actions: <Widget>[
//   //         TextButton(
//   //           onPressed: () => Navigator.pop(context, 'Cancel'),
//   //           child: const Text('Cancel'),
//   //         ),
//   //         TextButton(
//   //           onPressed: () => Navigator.pop(context, 'OK'),
//   //           child: const Text('OK'),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   Future<void> sessionsForm(BuildContext context) async {
//     // Widget sessionsForm() async {
//     return await showDialog(
//       context: context,
//       builder: (context) {
//         bool isChecked = false;
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             content: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 1, top: 3),
//                   child: FormHelper.inputFieldWidget(
//                     context,
//                     initialValue: "",
//                     "date",
//                     "Data",
//                     (onValidateVal) {
//                       if (onValidateVal.isEmpty) {
//                         return 'Data can´t be empty';
//                       }
//                       return null;
//                     },
//                     (onSavedVal) => {
//                       sessionsModel?.date = onSavedVal,
//                     },
//                     borderColor: Colors.black,
//                     borderFocusColor: Colors.black,
//                     textColor: Colors.black,
//                     hintColor: Colors.black.withOpacity(.7),
//                     borderRadius: 10,
//                     showPrefixIcon: false,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10, top: 10),
//                   child: FormHelper.inputFieldWidget(
//                     context,
//                     "timeDay",
//                     "Hora",
//                     (onValidateVal) {
//                       if (onValidateVal.isEmpty) {
//                         return 'Hora can´t be empty';
//                       }
//                       return null;
//                     },
//                     (onSavedVal) => {
//                       sessionsModel?.timeDay = onSavedVal,
//                     },
//                     initialValue: "",
//                     borderColor: Colors.black,
//                     borderFocusColor: Colors.black,
//                     textColor: Colors.black,
//                     hintColor: Colors.black.withOpacity(.7),
//                     borderRadius: 10,
//                     showPrefixIcon: false,
//                   ),
//                 ),
//               ],
//             ),

            // Form(
            //     key: _formKey,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         TextFormField(
            //           controller: _dateEditingController,
            //           // validator: (value) {
            //           //   return value.isNotEmpty ? null : "Enter any text";
            //           // },
            //           decoration: const InputDecoration(
            //             border: OutlineInputBorder(),
            //             labelText: 'Data',
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         TextFormField(
            //           controller: _hourlyEditingController,
            //           // validator: (value) {
            //           //   return value.isNotEmpty ? null : "Enter any text";
            //           // },
            //           decoration: const InputDecoration(
            //             border: OutlineInputBorder(),
            //             labelText: 'Hora',
            //           ),
            //         ),
            //       ],
            //     )),
//             title: Text('Adicionar Sessão'),
//             actions: <Widget>[
//               InkWell(
//                 child: Center(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.green,
//                         textStyle: const TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.bold)),
//                     onPressed: () async {
//                       if (vaidateAndSave()) {
//                         //API Service
//                         setState(() {
//                           isAPICallProcess = true;
//                         });

//                         APIService.saveSessions(sessionsModel!).then(
//                           (response) {
//                             setState(() {
//                               isAPICallProcess = false;
//                             });

//                             if (response) {
//                               Navigator.pushNamedAndRemoveUntil(
//                                   context, '/', (route) => false);
//                             } else {
//                               const Text('Ocoreu um erro :(');
//                               // FormHelper.showSimpleAlertDialog(
//                               //   context,
//                               //   Config.appName,
//                               //   "Error Occure",
//                               //   "OK",
//                               //   () {
//                               //     Navigator.of(context).pop();
//                               //   },
//                               // );
//                             }
//                           },
//                         );
//                       }
//                     },
//                     child: const Text('Salvar'),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         });
//       },
//     );
//   }

//   bool vaidateAndSave() {
//     final form = globalKey.currentState;
//     if (form!.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }
// }
