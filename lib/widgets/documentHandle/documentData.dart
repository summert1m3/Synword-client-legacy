import 'package:file_picker/file_picker.dart';
import 'package:synword/model/json/uniqueCheckData.dart';

class DocumentData{
  static final DocumentData _singleton = DocumentData._internal();

  factory DocumentData() {
    return _singleton;
  }

  DocumentData._internal();

  FilePickerResult file;

  bool uniqueUp = false;
  bool uniqueCheck = false;

  UniqueCheckData uniqueCheckData;

  static const String downloadPath = "/storage/emulated/0/Download/";

}

final DocumentData docData = DocumentData();