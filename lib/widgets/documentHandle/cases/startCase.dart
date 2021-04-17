import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:synword/widgets/documentHandle/documentHandlerData.dart';
import 'package:synword/widgets/documentHandle/dialogState.dart';

class StartCase extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StartCaseState();
}

class _StartCaseState extends State<StartCase> {

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
              onPressed: () => _filePick(),
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

void _filePick() async {
  try {
    FilePickerResult _file = await _filePickerCallback();
    DocumentHandlerData.file = _file;
    DocumentHandlerData.updateState(DialogState.choice);
  }catch(ex){
    print(ex);
  }
}

Future<FilePickerResult> _filePickerCallback() async {
  if (await Permission.storage.request().isGranted) {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx'],
      withData: true,
    );

    if(result == null){
      throw Exception('FilePickerResult is null');
    }

    return result;
  }
  else{
    throw Exception('Permission.storage.request() is not granted');
  }
}