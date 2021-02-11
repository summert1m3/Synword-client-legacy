import 'package:file_picker/file_picker.dart';
import 'package:synword/uniqueCheckData.dart';

class DocumentData{
  FilePickerResult file;

  bool uniqueUp = false;
  bool uniqueCheck = false;

  static const String downloadPath = "/storage/emulated/0/Download/";

  UniqueCheckData uniqueCheckData;

  void reset(){
    file = null;
    uniqueUp = false;
    uniqueCheck = false;
    uniqueCheckData = null;
  }

}

final DocumentData docData = DocumentData();