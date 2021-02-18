import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:synword/widgets/documentHandle/documentData.dart';
import 'package:synword/widgets/documentHandle/dialogState.dart';
import 'package:synword/userData/controller/serverRequestsController.dart';


class ChoiceCase extends StatefulWidget {
  final Function _setStateCallback;

  ChoiceCase(
      this._setStateCallback
      );

  @override
  State<StatefulWidget> createState() => _ChoiceCaseState(_setStateCallback);
}

class _ChoiceCaseState extends State<ChoiceCase> {
  bool uniqueUpSwitchValue = true;
  bool uniqueCheckSwitchValue = false;
  final Function _setStateCallback;

  _ChoiceCaseState(
      this._setStateCallback
      );

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
        height: MediaQuery.of(context).size.height / 1.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
              color: HexColor('#366CCA'),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('icons/docx_logo.png'),
                      height: 90,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(docData.file.names.first,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Roboto')),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
                color: HexColor('#5C5C5C'),
                child: ListTile(
                  dense: true,
                  title: Center(
                      child: Text(
                        'documentHandleChoiceCaseUniqueUp'.tr(),
                        style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
                      )),
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
                  dense: true,
                  title: Center(
                      child: Text(
                        'documentHandleChoiceCaseUniqueCheck'.tr(),
                        style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
                      )),
                  trailing: Switch(
                      activeColor: Colors.blueAccent,
                      value: uniqueCheckSwitchValue,
                      onChanged: (value) {
                          setState(() {
                            uniqueCheckSwitchValue = value;
                          });
                      }),
                )),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              disabledColor: Colors.grey,
              color: Colors.blueAccent,
              onPressed: uniqueCheckSwitchValue == true || uniqueUpSwitchValue == true ? () => onClickButtonHandler(uniqueUpSwitchValue, uniqueCheckSwitchValue, _setStateCallback) : null,
              child: Text(
                'documentHandleChoiceCaseButton'.tr(),
                style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> onClickButtonHandler(bool uniqueUpSwitchValue, bool uniqueCheckSwitchValue, Function setStateCallback) async{
    docData.uniqueUp = uniqueUpSwitchValue;
    docData.uniqueCheck = uniqueCheckSwitchValue;
    setStateCallback(state: DialogState.loading);

    if(uniqueUpSwitchValue == true && uniqueCheckSwitchValue == true){
      await uniqueUp();
      await uniqueCheck();
    }
    else if (uniqueUpSwitchValue == true){
      await uniqueUp();
    }
    else if(uniqueCheckSwitchValue == true){
      await uniqueCheck();
    }

    setStateCallback(state: DialogState.finish);
}

Future<void> uniqueUp() async{
  ServerRequestsController serverRequest = ServerRequestsController();
  Response docxUniqueUpResponse = await serverRequest.docxUniqueUpRequest(filePickerResult: docData.file);

  File file = File(
    join(DocumentData.downloadPath, "synword_" + docData.file.names.first),
  );

  file.writeAsBytesSync(docxUniqueUpResponse.data);
}

Future<void> uniqueCheck() async{
  ServerRequestsController serverRequest = ServerRequestsController();
  docData.uniqueCheckData = await serverRequest.docxUniqueCheckRequest(filePickerResult: docData.file);
}