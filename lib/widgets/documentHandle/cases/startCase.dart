import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:synword/widgets/documentHandle/documentData.dart';
import 'package:synword/widgets/documentHandle/dialogState.dart';

class StartCase extends StatefulWidget {
  final Function _setStateCallback;

  StartCase(
      this._setStateCallback
      );

  @override
  State<StatefulWidget> createState() => _StartCaseState(_setStateCallback);
}

class _StartCaseState extends State<StartCase> {
  FilePickerResult _file;
  final Function _setStateCallback;

  _StartCaseState(
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
        height: MediaQuery.of(context).size.height / 2.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            IconButton(
              iconSize: 100,
              icon: SvgPicture.asset(
                'icons/upload_file_button.svg',
                semanticsLabel: 'Upload file',
              ),
              onPressed: () async {
                _file = await _filePickerCallback();
                if (_file != null) {
                  docData.file = _file;
                  _setStateCallback(
                    state: DialogState.choice,
                  );
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'fileUploadSupportedFiles',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ).tr(),
          ],
        ),
      ),
    );
  }
}

Future<FilePickerResult> _filePickerCallback() async {
  var status = await Permission.storage.request();
  if (status.isGranted) {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx'],
      withData: true,
    );
    return result;
  }
  return null;
}