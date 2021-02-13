import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/widgets/documentHandle/documentData.dart';
import 'package:open_file/open_file.dart';
import 'package:easy_localization/easy_localization.dart';

class UniqueUpResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                Text("synword_" + docData.file.names.first,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Roboto')),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Card(
          color: HexColor('#5C5C5C'),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16, top: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'documentHandleFinishCaseSavedFile'.tr(),
                  style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ButtonBar(
          buttonMinWidth: 90,
          alignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              color: Colors.amber,
              onPressed: () => OpenFile.open(DocumentData.downloadPath + "synword_" + docData.file.names.first, type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document"),
              child: Text('documentHandleFinishCaseUniqueUpButton', style: TextStyle(fontFamily: 'Roboto'),).tr(),
            )
          ],
        )
      ],
    );
  }
}
