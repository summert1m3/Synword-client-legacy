import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/model/fileData.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/widgets/documentHandle/cases/results/DocUpAndCheckResultPage.dart';
import 'package:synword/widgets/documentHandle/cases/results/docUniqueCheckResultPage.dart';
import 'package:synword/widgets/documentHandle/documentData.dart';
import 'package:synword/widgets/documentHandle/dialogState.dart';
import 'package:synword/userData/controller/serverRequestsController.dart';
import 'package:sizer/sizer.dart';

class ChoiceCase extends StatefulWidget {
  final BuildContext _context;
  final Function _setStateCallback;

  ChoiceCase(this._context, this._setStateCallback);

  @override
  State<StatefulWidget> createState() => _ChoiceCaseState(_context, _setStateCallback);
}

class _ChoiceCaseState extends State<ChoiceCase> {
  final BuildContext _context;
  bool uniqueUpSwitchValue = true;
  bool uniqueCheckSwitchValue = false;
  CurrentUser user = CurrentUser();
  final Function _setStateCallback;

  _ChoiceCaseState(this._context, this._setStateCallback);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: HexColor('#262626'),
      content: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 1.5,
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
                      Text(docData.file.names.first,
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
                    //leading: Icon(Icons.loop, color: Colors.white, size: 5.0.h,),
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
                        value: uniqueUpSwitchValue,
                        onChanged: (value) {
                          setState(() {
                            uniqueUpSwitchValue = value;
                          });
                        }),
                  )),
              Card(
                  color: HexColor('#5C5C5C'),
                  child: ListTile(
                    //leading: Icon(Icons.check_circle, color: Colors.white, size: 5.0.h),
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
                          value: uniqueCheckSwitchValue,
                          onChanged: (value) {
                            if (user.userData.isPremium == true) {
                              setState(() {
                                uniqueCheckSwitchValue = value;
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
                onPressed: uniqueCheckSwitchValue == true ||
                        uniqueUpSwitchValue == true
                    ? () => onClickButtonHandler(_context, uniqueUpSwitchValue,
                        uniqueCheckSwitchValue, _setStateCallback)
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
    );
  }
}

Future<void> onClickButtonHandler(BuildContext context, bool uniqueUpSwitchValue,
    bool uniqueCheckSwitchValue, Function setStateCallback) async {
  docData.uniqueUp = uniqueUpSwitchValue;
  docData.uniqueCheck = uniqueCheckSwitchValue;
  setStateCallback(state: DialogState.loading);

  try {
    if (uniqueUpSwitchValue == true && uniqueCheckSwitchValue == true) {
      await uniqueUp();
      await uniqueCheck();

      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DocUpAndCheckResultPage()));
      Navigator.of(context).pop();
    } else if (uniqueUpSwitchValue == true) {
      await uniqueUp();

      setStateCallback(state: DialogState.finish);
    } else if (uniqueCheckSwitchValue == true) {
      await uniqueCheck();

      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DocUniqueCheckResultPage()));
      Navigator.of(context).pop();
    }
  } catch (_) {
    setStateCallback(state: DialogState.error);
  }
}

Future<void> uniqueUp() async {
  Uint8List fileBytes = await _readFileByte(docData.file.files.first.path);
  FileData fileData = FileData();
  fileData.name = docData.file.names.first;
  fileData.bytes = fileBytes;

  ServerRequestsController serverRequest = ServerRequestsController();
  Response response = await serverRequest.docxUniqueUpRequest(file: fileData);

  File file = File(
    join(DocumentData.downloadPath, "synword_" + docData.file.names.first),
  );

  file.writeAsBytesSync(response.data);
}

Future<void> uniqueCheck() async {
  Uint8List fileBytes = await _readFileByte(docData.file.files.first.path);
  FileData fileData = FileData();
  fileData.name = docData.file.names.first;
  fileData.bytes = fileBytes;

  ServerRequestsController serverRequest = ServerRequestsController();
  docData.uniqueCheckData =
      await serverRequest.docxUniqueCheckRequest(file: fileData);
}

Future<Uint8List> _readFileByte(String filePath) async {
  Uri myUri = Uri.parse(filePath);
  File audioFile = new File.fromUri(myUri);
  Uint8List bytes;
  await audioFile.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value);
    print('reading of bytes is completed');
  }).catchError((onError) {
    print(
        'Exception Error while reading audio from path:' + onError.toString());
  });
  return bytes;
}
