import 'package:file_picker/file_picker.dart';

class DocumentData{
  FilePickerResult file;
  bool uniqueUp = false;
  bool uniqueCheck = false;
  static const String downloadPath = "/storage/emulated/0/Download/";

  void reset(){
    file = null;
    uniqueUp = false;
    uniqueCheck = false;
  }

}

final DocumentData docData = DocumentData();