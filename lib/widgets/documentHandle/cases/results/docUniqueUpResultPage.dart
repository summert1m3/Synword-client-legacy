import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:open_file/open_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:synword/widgets/documentHandle/documentHandlerData.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class DocUniqueUpResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var docData = context.read<DocumentHandlerData>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image(
                  image: AssetImage('icons/docx_logo.png'),
                  height: 130,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("synword_" + (docData.file.names.first ?? 'null'),
                    style: TextStyle(fontFamily: 'Roboto')),
              ],
            ),
          ),
        SizedBox(
          height: 3.0.h,
        ),
        Card(
          color: HexColor('#5C5C5C'),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16, top: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'documentHandleFinishCaseSavedFile'.tr(),
                  style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        ),
        ButtonBar(
          buttonMinWidth: 90,
          alignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              color: Colors.amber,
              onPressed: () => OpenFile.open(docData.downloadPath + "synword_" + docData.file.names.first!, type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document"),
              child: Text('documentHandleFinishCaseUniqueUpButton', style: TextStyle(fontFamily: 'Roboto'),).tr(),
            ),
          ],
        )
      ],
    );
  }
}


