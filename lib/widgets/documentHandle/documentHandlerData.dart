import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:synword/model/json/uniqueCheckData.dart';

class DocumentHandlerData {
  DocumentHandlerData(this.updateMainState);

  late FilePickerResult pickedFile;

  late bool uniqueUp = true;
  late bool uniqueCheck = false;

  UniqueCheckData? uniqueCheckData;

  late String downloadedFilePath;

  Function updateMainState;

  void updateState(Widget widget){
    updateMainState(widget);
  }
}