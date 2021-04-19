import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/model/fileData.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/widgets/documentHandle/dialogState.dart';
import 'package:synword/userData/controller/serverRequestsController.dart';
import 'package:sizer/sizer.dart';
import 'package:synword/widgets/documentHandle/documentHandlerData.dart';
import 'package:provider/provider.dart';

class ChoiceCase extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _ChoiceCaseState();
}

class _ChoiceCaseState extends State<ChoiceCase> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var docData = context.read<DocumentHandlerData>();
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: HexColor('#262626'),
      content: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 1.5,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 3.0.h,
                ),
                Card(
                  color: HexColor('#366CCA'),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('icons/docx_logo.png'),
                          height: 15.0.h,
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Text(docData.file.names.first ?? 'null',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Roboto')),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                Card(
                    color: HexColor('#5C5C5C'),
                    child: ListTile(
                      dense: false,
                      title: Text(
                        'documentHandleChoiceCaseUniqueUp'.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 12.0.sp),
                      ),
                      trailing: Switch(
                          activeColor: Colors.blue,
                          value: docData.uniqueUp,
                          onChanged: (value) {
                            setState(() {
                              docData.uniqueUp = value;
                            });
                          }),
                    )),
                Card(
                    color: HexColor('#5C5C5C'),
                    child: ListTile(
                      dense: true,
                      title: Text(
                        'documentHandleChoiceCaseUniqueCheck'.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 12.0.sp),
                      ),
                      subtitle: Text(
                        'documentHandleChoiceCaseUniqueCheckSubtitle'.tr(),
                        style: TextStyle(
                            color: Colors.amber,
                            fontFamily: 'Roboto',
                            fontSize: 9.0.sp),
                      ),
                      trailing: ButtonTheme(
                        minWidth: 5.0.w,
                        height: 5.0.h,
                        child: Switch(
                            activeColor: Colors.blueAccent,
                            value: docData.uniqueCheck,
                            onChanged: (value) {
                              if (CurrentUser.userData.isPremium == true) {
                                setState(() {
                                  docData.uniqueCheck = value;
                                });
                              }
                            }),
                      ),
                    )),
                SizedBox(
                  height: 2.0.h,
                ),
                RaisedButton(
                  disabledColor: Colors.grey,
                  color: Colors.blueAccent,
                  onPressed: docData.uniqueCheck == true ||
                      docData.uniqueUp == true
                      ? () => onClickButtonHandler(docData)
                      : null,
                  child: Text(
                    'documentHandleChoiceCaseButton'.tr(),
                    style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> onClickButtonHandler(DocumentHandlerData docData) async {
  docData.updateState(DialogState.loading);
  try {
    if (docData.uniqueUp == true && docData.uniqueCheck == true) {
      await uniqueUp(docData);
      await uniqueCheck(docData);
    } else if (docData.uniqueUp == true) {
      await uniqueUp(docData);
    } else if (docData.uniqueCheck == true) {
      await uniqueCheck(docData);
    }
    docData.updateState(DialogState.finish);
  } catch (ex) {
    print(ex);
    docData.updateState(DialogState.error);
  }
}

Future<void> uniqueUp(DocumentHandlerData docData) async {
  Uint8List fileBytes = await _readFileByte(docData.file.files.first.path!);
  FileData fileData = FileData(docData.file.names.first!, fileBytes);

  Response response =
      await ServerRequestsController.docxUniqueUpRequest(file: fileData);

  File file = File(
    join(docData.downloadPath, "synword_" + docData.file.names.first!),
  );

  file.writeAsBytesSync(response.data);
}

Future<void> uniqueCheck(DocumentHandlerData docData) async {
  Uint8List fileBytes = await _readFileByte(docData.file.files.first.path!);
  FileData fileData = FileData(docData.file.names.first!, fileBytes);

  docData.uniqueCheckData =
      await ServerRequestsController.docxUniqueCheckRequest(file: fileData);
}

Future<Uint8List> _readFileByte(String filePath) async {
  Uri myUri = Uri.parse(filePath);
  File file = new File.fromUri(myUri);
  Uint8List bytes = Uint8List.fromList(await file.readAsBytes());
  return bytes;
}
